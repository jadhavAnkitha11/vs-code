public class OpportunitySumTriggerHandler implements Database.Batchable<sObject> {
    public Map<Id, List<Contact>> leadToContactsMap = new Map<Id, List<Contact>>();

    public Database.QueryLocator start(Database.BatchableContext bc) {
        // Query all Leads with relevant fields.
        return Database.getQueryLocator([SELECT Id, FirstName, LastName, Email, Phone FROM Lead]);
    }

    public void execute(Database.BatchableContext bc, List<Lead> leadList) {
        // Maps to hold contacts by different criteria
        Map<String, List<Contact>> emailToContactsMap = new Map<String, List<Contact>>();
        Map<String, List<Contact>> nameToContactsMap = new Map<String, List<Contact>>();
        Map<String, List<Contact>> phoneToContactsMap = new Map<String, List<Contact>>();

        // Collect unique values for querying
        Set<String> emails = new Set<String>();
        Set<String> names = new Set<String>(); // Combining FirstName and LastName
        Set<String> phones = new Set<String>();

        for (Lead lead : leadList) {
            if (lead.Email != null) emails.add(lead.Email);
            if (lead.FirstName != null && lead.LastName != null) {
                names.add(lead.FirstName + ' ' + lead.LastName);
            }
            if (lead.Phone != null) phones.add(lead.Phone);
        }

        // Query contacts based on collected criteria
        List<Contact> contacts = [
            SELECT Id, FirstName, LastName, Email, Phone
            FROM Contact
            WHERE Email IN :emails
            OR (FirstName + ' ' + LastName) IN :names
            OR Phone IN :phones
        ];

        // Populate the contact maps
        for (Contact contact : contacts) {
            if (contact.Email != null) {
                if (!emailToContactsMap.containsKey(contact.Email)) {
                    emailToContactsMap.put(contact.Email, new List<Contact>());
                }
                emailToContactsMap.get(contact.Email).add(contact);
            }
            
            String fullName = contact.FirstName + ' ' + contact.LastName;
            if (!nameToContactsMap.containsKey(fullName)) {
                nameToContactsMap.put(fullName, new List<Contact>());
            }
            nameToContactsMap.get(fullName).add(contact);

            if (contact.Phone != null) {
                if (!phoneToContactsMap.containsKey(contact.Phone)) {
                    phoneToContactsMap.put(contact.Phone, new List<Contact>());
                }
                phoneToContactsMap.get(contact.Phone).add(contact);
            }
        }

        // Match leads to contacts
        for (Lead lead : leadList) {
            List<Contact> matchedContacts = new List<Contact>();
            Integer matchCount = 0;

            if (lead.Email != null && emailToContactsMap.containsKey(lead.Email)) {
                matchCount++;
                matchedContacts.addAll(emailToContactsMap.get(lead.Email));
            }

            String fullName = lead.FirstName + ' ' + lead.LastName;
            if (lead.FirstName != null && lead.LastName != null && nameToContactsMap.containsKey(fullName)) {
                matchCount++;
                matchedContacts.addAll(nameToContactsMap.get(fullName));
            }

            if (lead.Phone != null && phone
