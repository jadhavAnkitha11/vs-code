public with sharing class learnsimpledatatable {
    @AuraEnabled(cacheable=true)
    
    public static List<Contact> allContacts(){
      return [SELECT Id, Name, Email, Phone FROM Contact];
    }
    
}