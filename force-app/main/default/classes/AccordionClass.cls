public with sharing class AccordionClass {
    @AuraEnabled(cacheable=true)
   public static List<Account> accounts() {
    List<Account> acc=[SELECT Id,Name FROM Account];
      return acc; 
   }
    @AuraEnabled(cacheable=true)
    public static List<Contact> contacts(Id accountId){
        List<Contact> con=[SELECT Id, Name FROM Contact WHERE AccountId =: accountId];
        return con;
    }
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> opportunities(Id accountId){
        List<Opportunity> opp=[SELECT Id, Name FROM Opportunity WHERE AccountId =: accountId];
        return opp;
    }
    @AuraEnabled(cacheable=true)
   public static List<Case> cases(Id accountId){
    List<Case> cs=[SELECT Id, CaseNumber, Subject, Status FROM Case WHERE AccountId =: accountId];
    return cs;
   }
}

