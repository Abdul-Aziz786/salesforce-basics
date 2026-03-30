@IsTest
public  class BatchCloseOverdueOpportunitiesTest {
    @TestSetup
    static void setup() {
        Opportunity opp = new Opportunity(
            Name = 'Test Opp',
        StageName = 'Prospecting',
        Amount = 10000,
        CloseDate = Date.today().addDays(-1)
            );
        
        
        insert opp;
    }
    
    @IsTest
    static void testBatchCloseOverdueOpportunities() {
        Test.startTest();
        Database.executeBatch(new BatchCloseOverdueOpportunities());
        Test.stopTest();
        Opportunity opp = [SELECT Id, StageName FROM Opportunity LIMIT 1];
        System.Assert.areEqual('Closed Lost', opp.StageName);
    }
}