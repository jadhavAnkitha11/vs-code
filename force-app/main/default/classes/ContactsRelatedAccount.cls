public with sharing class ContactsRelatedAccount {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactList(Id accountId,Integer offset,Integer limits){
        list<Contact> conList = [SELECT Id,FirstName,LastName,LastModifiedDate FROM Contact WHERE AccountId =: accountId ORDER BY LastModifiedDate DESC LIMIT:limits OFFSET:offset];
          return conList;
    }
}