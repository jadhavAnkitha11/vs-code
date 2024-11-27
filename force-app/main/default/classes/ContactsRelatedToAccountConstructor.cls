public with sharing class ContactsRelatedToAccountConstructor {
        // @AuraEnabled
        // public String columnName;
        // @AuraEnabled
        // public String columnApiName;
         @AuraEnabled
        public List<ContactsRelatedToAccount__mdt> metadata;
        @AuraEnabled
        public List<Contact> contacts; 
        public ContactsRelatedToAccountConstructor(List<ContactsRelatedToAccount__mdt> metadata) {
          this.metadata= metadata;
         
        }
        public ContactsRelatedToAccountConstructor(List<Contact> contacts){
    
            this.contacts=contacts;
        }
    
    }