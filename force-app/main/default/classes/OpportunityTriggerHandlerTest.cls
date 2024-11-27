
@isTest
private class OpportunityTriggerHandlerTest {

    @isTest
    static void amountUpdate()
    {
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        List<Opportunity> opp=new List<Opportunity>();
        opp.add(new Opportunity(Name='First Opportunity',StageName='Closed Lost',CloseDate=Date.today(),AccountId=acc.Id,Amount=1000));

        
        opp.add(new Opportunity(Name='Second Opportunity',StageName='Closed Won',CloseDate=Date.today(),AccountId=acc.Id,Amount=1500));
        insert opp;
        Test.startTest();
        for(Opportunity op:opp)
        {
            op.Amount=3000;
        }
        update opp;
        Test.stopTest();
        Account a=[Select Id,SumofOppAmount__c from Account where Id=:acc.Id];
        System.assertEquals(6000,a.SumofOppAmount__c);
    }
} 
