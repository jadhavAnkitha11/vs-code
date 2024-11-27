public  class ContactsRelatedToAccount {
    //auraenabled is used to call the methods from lwc componenets,and cacheable=true results can be cached on client side
    // public static List<Contact> getContactList(Id accountId){
        //     list<Contact> conLst = [SELECT Id,Name,Phone,Email,Owner.Name FROM Contact WHERE AccountId =: accountId ORDER BY LastModifiedDate DESC];
        //       return conLst;
        // }
        
        @AuraEnabled(cacheable=true)
      public static List<ContactsRelatedToAccountConstructor> getContactsByAccountId(Id accountId) {
        List<ContactsRelatedToAccount__mdt> metadata = [SELECT column__c,Custom_Api_name__c FROM ContactsRelatedToAccount__mdt];
        List<ContactsRelatedToAccountConstructor> conList=new List<ContactsRelatedToAccountConstructor>();
        set<String> columns=new set<String>();
        
        //List<String> columnLabels=new List<String>();
        
        for(ContactsRelatedToAccount__mdt mdt:metadata){
            columns.add(mdt.Custom_Api_name__c);
        }
        conList.add(new ContactsRelatedToAccountConstructor(metadata));
        
        System.debug('conList----'+conList);
        String query='SELECT Id,'+ String.join(columns,',')+
        ' FROM Contact WHERE AccountId =: accountId ORDER BY LastModifiedDate DESC';
        System.debug(String.join(columns,','));
        List<Contact> contacts=database.query(query);
        conList.add(new ContactsRelatedToAccountConstructor(contacts));
        return conList;
    }
//     @AuraEnabled(cacheable=true)
//     public static List<ContactsRelatedToAccount__mdt> getColumn(){

//         return [SELECT 	column__c, Custom_Api_name__c FROM ContactsRelatedToAccount__mdt];
    
// }
}
