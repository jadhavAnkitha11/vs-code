
public class OpportunityContactHandler implements Database.Batchable<sObject>, Database.Stateful,System.Schedulable {
    /**
     * Find Opp with no account id.
     * If Contact found -> Fetch related account and assign to opp
     * If no account found on Contact -> Check opp description for a company value and create an account
     * Assign newly created account to Contact and Opportunity
     * If no Contact found -> Check for Opp Description field for a company value and create an account
     * with this value and a contact with Opp info.
     * Assign Account to Contact and Opp.
     */
    public Database.QueryLocator start(Database.BatchableContext bc) {
        
        return Database.getQueryLocator([SELECT Id, Name, Description FROM Opportunity WHERE AccountId = NULL ]);
    }
  
    public void execute(Database.BatchableContext bc, List<Opportunity> opps) {
        
        Set<String> opportunityNames = new Set<String>();
        for (Opportunity opp : opps) {
            opportunityNames.add(opp.Name);
        }
        Map<String, Contact> nameToContactMap = new Map<String, Contact>();
        List<Contact> contacts = [SELECT Id, AccountId, Name FROM Contact WHERE Name IN :opportunityNames];
        for(Contact cont : contacts) {
            nameToContactMap.put(cont.Name, cont);
        }
        List<Account> accountsToInsert = new List<Account>();
        List<Contact> conToUpdate = new List<Contact>();
        List<Opportunity> oppToUpdate = new List<Opportunity>();
        Map<String,Account> someMap = new Map<String, Account>();
        Map<String,Opportunity> oppDescToOpp = new Map<String, Opportunity>();
  
        for (Opportunity opp : opps) {
            
            
            if (nameToContactMap.containsKey(opp.Name)) {
                
                if (nameToContactMap.get(opp.Name).AccountId != null) {
                    
                    opp.AccountId = nameToContactMap.get(opp.Name).AccountId;
                    oppToUpdate.add(opp);
                } else if (String.isNotBlank(opp.Description)) {
                    //build a map with opp description to new Account
                    Account newAccount = new Account(Name = opp.Description);
                    someMap.put(opp.Description, newAccount);
  
                    oppDescToOpp.put(opp.Name, opp);
                    /**
                     * map related contact with Opp
                     * once new Accounts are inserted, assign this new Account Id with the related Contact.
                     */
                    
                }
            }
        }
        insert someMap.values();

        for(Opportunity opp : oppDescToOpp.values()){
            opp.AccountId = someMap.get(opp.Description).Id;
            oppToUpdate.add(opp);
            nameToContactMap.get(opp.Name).AccountId = someMap.get(opp.Description).Id;
            conToUpdate.add(nameToContactMap.get(opp.Name));
        }
        //  update oppToUpdate;
        //  update conToUpdate;
        List<SObject> allRecords = new List<SObject>();
        allRecords.addAll(oppToUpdate);
        allRecords.addAll(conToUpdate);
        update allRecords;
    }
    //
    public void execute(System.SchedulableContext sContext){
        Database.executeBatch(new OpportunityContactHandler ());
    }
    public static void scheduleJob() {
        
    OpportunityContactHandler opc=new OpportunityContactHandler();
        String cronExp = '0 0 8 * * ?';
        String jobName = 'Daily Opportunity Contact Batch Job';
        System.schedule(jobName, cronExp,opc);
    }
  
    public void finish(Database.BatchableContext bc) {
        System.debug('finish');
    }
  }
  