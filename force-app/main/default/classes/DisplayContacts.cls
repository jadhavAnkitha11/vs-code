public  class DisplayContacts {
    @AuraEnabled(cacheable = true)
    public static List<Contact> queryContacts() {
      return [SELECT Id,Name , Email From Contact];
      
    }
}