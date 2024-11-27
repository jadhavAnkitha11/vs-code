public  class ContactsFetching {
    @AuraEnabled(cacheable=true)
   
    public static  List<Contact> contactsQuerying() {
        
        List<Contact> conList=[SELECT Id,Name FROM Contact];
        System.debug('conList:'+conList);
        return conList;

    }
}