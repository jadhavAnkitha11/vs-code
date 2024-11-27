@isTest
private class AccountTriggerHandlerTest {
    @isTest
    static void AccountAfterUpdateTest() {
        Account acc = new Account(Name = 'Test Account', Status__c = true);
        insert acc;
        List<Contact> contacts = new List<Contact>();
        contacts.add(new Contact(FirstName = 'Sharu', LastName = 'Shinde', AccountId = acc.Id));
        
        contacts.add(new Contact(FirstName = 'nikki', LastName = 'Shinde1', AccountId = acc.Id));
        insert contacts;
        Test.startTest();
        acc.Status__c = false;
        update acc; 
        for (Contact c : contacts) {
            System.assertEquals(false, c.Status__c);
            
        }
        Test.stopTest();
    }
}