@isTest
private class ContactTriggerHandlerTest {
    @isTest
    static void updateContactWithAccountStatusTest() {
        Account a=new Account(Name='Test Account',Status__c = true);
        insert a;
        Contact c=new Contact(FirstName='Test',LastName='Contact', AccountId=a.Id);
       Test.startTest();
        insert c;
        Test.stopTest();
        Contact updatedCon=[SELECT Id,Status__c FROM Contact WHERE id=:c.Id];
        System.assertEquals(true,updatedCon.Status__c);
}
@isTest
static void testBeforeUpdateLogic(){
    Account a=new Account(Name='Test Account',Status__c = true);
    insert a;
    Contact c=new Contact(FirstName='Test',LastName='Contact',AccountId=a.Id);
    insert c;
    Test.startTest();
    c.Status__c = false;
    update c;
    Test.stopTest();
    Contact updatedCon=[SELECT Id,Status__c FROM Contact WHERE AccountId=:a.Id];
    System.assertEquals(true, updatedCon.Status__c,'Should be true');
}
}



