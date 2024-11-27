public class TriggerHandler {
    public void afterUpdate(List<Account> newList,Map<Id,Account>  oldMap) {
        Map<Id,Account> accMap=new Map<Id,Account>();
        //Set<Id> accIds=new Set<Id>();
        for (Account acc:newList){
            if (acc.Status__c<>oldMap.get(acc.Id).Status__c){
                // accIds.add(acc.Id);
                accMap.put(acc.Id,acc);
            }
        }
        if (!accMap.isEmpty()){
            List<Contact> Contacts=[Select Id,Status__c, AccountId from Contact Where AccountId In :accMap.keySet()];
            List<Contact> updatedContacts=new List<Contact>();
            for (Contact c:Contacts){
                Account a=accMap.get(c.AccountId);
                c.Status__c=a.Status__c;
                updatedContacts.add(c);
            }
            update updatedContacts;
        }
    }
    public void beforeInsert(List<Contact> newList){
        Set<Id> accid=new Set<Id>();
        for(Contact con:newList){
            if(con.AccountId<>null){
                accid.add(con.AccountId);
            }
        }
        List<Account> accList=[Select Id,Status__c from Account Where Id in :accid And Status__c=True];
            for(Contact con:newList){
                for(Account acc:accList){
                    if(acc.Id==con.AccountId) {
                    con.Status__c=acc.Status__c;
                }
            }
        }
    }
    public void beforeUpdate(List<Contact> newList,Map<Id,Contact> oldMap){
        Set<Id> accIds = new Set<Id>();
        for(Contact con : newList){
            if(con.Status__c <>oldMap.get(con.Id).Status__c && con.AccountId <> null) {
                accIds.add(con.AccountId);
            }
        }
        List<Account> accList=[SELECT Id,Status__c from Account WHERE Id IN :accIds];
        for(Contact c : newList){
            for (Account a:accList){
                if (c.AccountId==a.Id){
                c.Status__c=a.Status__c;
            }
        }
    }
    }
}



