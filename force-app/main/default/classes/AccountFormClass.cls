public with sharing class AccountFormClass{
    @AuraEnabled
    public static Id getAccountDetails(String accountName, String phone, Decimal annualRevenue) {
        Account acc = new Account();
        acc.Name = accountName;
        acc.Phone = phone;
        acc.AnnualRevenue = annualRevenue;
        insert acc;
        return acc.Id;     
    }
    @AuraEnabled
   public static Id getContactdetails(String firstName, String lastName, String email, Id AccountId){
       Contact con = new Contact();
     con.FirstName = firstName;
     con.LastName = lastName;
     con.Email = email;
     System.debug('AccountId---'+accountId);
     if (accountId != null){
         con.AccountId = accountId;
        
     }
     insert con;
     return con.Id;
   }
   @AuraEnabled
   public static List<Account> getAccounts(){
    return[SELECT Id, Name FROM Account];
   }
   @AuraEnabled
    public static Id getOpportunitydetails(String name, Date closeDate, String stage, Id accountId) {
        Opportunity opp = new Opportunity();
        opp.Name = name;
        opp.CloseDate = closeDate;
        opp.StageName = stage;

        System.debug('AccountId---' + accountId);
        if (accountId != null) {
            opp.AccountId = accountId;
        }

        insert opp;
        return opp.Id;
    }

    @AuraEnabled
    public static List<Opportunity> getOpportunities() {
        return [SELECT Id, Name, StageName, CloseDate FROM Opportunity];
    }
}