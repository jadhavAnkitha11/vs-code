public class contactsRelatedToAccount1 {
    @AuraEnabled(cacheable=true)
    String columnName;
    String columnApiName;
    List<Contact> contacts;
    public contactsRelatedToAccount1(String columnName,String columnApiName) {
      this..columnName = columnName;
      this.columnApiName = columnApiName;
    }
    public contactsRelatedToAccount1(List<Contact> contacts){
        this.contacts=contacts;
    }

}