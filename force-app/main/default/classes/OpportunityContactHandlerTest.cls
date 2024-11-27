
@isTest
private class OpportunityContactHandlerTest {

    @testSetup
    static void setUp() {
        Account accountWithContact = new Account(Name = 'Test Account');
        insert accountWithContact;
        Contact contactWithAccount = new Contact(FirstName = 'sharu', LastName = 'shinde', AccountId = accountWithContact.Id);
        insert contactWithAccount;
        Opportunity oppWithContact = new Opportunity(Name = 'sharu shinde', CloseDate = Date.today(), StageName = 'Prospecting');
        insert oppWithContact;
        Contact contactWithoutAccount = new Contact(FirstName = 'sharu', LastName = 'smith');
        insert contactWithoutAccount;
        Opportunity oppWithContactNoAccount = new Opportunity(Name = 'sharu smith', CloseDate = Date.today(), StageName = 'Prospecting',Description = 'New Company');
        insert oppWithContactNoAccount;
    }
    @isTest
    static void testOpportunityBatch() {
        Test.startTest();
        OpportunityContactHandler batch = new OpportunityContactHandler();
        Database.executeBatch(batch);
        Test.stopTest();
        Opportunity oppWithContact = [SELECT AccountId FROM Opportunity WHERE Name = 'sharu shinde'];
        
        System.debug('Oppwithcontact '+ oppWithContact.AccountId);
        Account accountWithContact = [SELECT Id FROM Account WHERE Name = 'Test Account'];
        System.assertEquals(true, oppWithContact.AccountId <> null, 'When batch is executed Opportunity should have Account related to found Contact.');
        Assert.areEqual(accountWithContact.Id, oppWithContact.AccountId, 'Both should match');
        Opportunity oppWithContactNoAccount = [SELECT AccountId FROM Opportunity WHERE Name = 'sharu smith'];
       System.assertEquals(true,oppWithContactNoAccount.AccountId<>null);
    }
    @isTest
    static void testBulk(){
        //Test Bulk
        Account account1 = new Account(Name = 'Evangeline');
        insert account1;
        Contact contact1 = new Contact(FirstName = 'Eunice' , LastName = 'Shoshan' , AccountId = account1.Id);
        insert contact1;
        List<Opportunity> insertOpp = new List<Opportunity>();
        for(Integer i=0; i<10; i++){
            insertOpp.add(new Opportunity(Name = 'Eunice Shoshan' , CloseDate=Date.today() , StageName = 'Qualification'));
        }
        insert insertOpp;
        Test.startTest();
       OpportunityContactHandler batch1 = new opportunityContactHandler();
       Database.executeBatch(batch1);
       Test.stopTest();
       for(Opportunity o :[SELECT Id , AccountId FROM Opportunity WHERE Name='Eunice Shoshan']){
           System.AssertEquals(account1.Id, o.AccountId , 'Should Match');
       }
        // System.AssertEquals(account1.Id, o.AccountId , 'Should Match');
    //     Account a = [SELECT Id , Name FROM Account WHERE Name = 'Evangeline'];
    //    System.assertEquals(a.Id, o.AccountId , 'should match');
       }










   
    }

