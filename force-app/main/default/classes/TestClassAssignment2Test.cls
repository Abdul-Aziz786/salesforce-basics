@isTest
private class TestClassAssignment2Test {
    
    @testSetup
    static void setupTestData() {
        Opportunity opp1 = new Opportunity(Name='Test Opp 1',
        StageName='Prospecting', Amount=5000, CloseDate=Date.today().addDays(30));
        Opportunity opp2 = new Opportunity(Name='Test Opp 2',
        StageName='Qualification', Amount=15000, CloseDate=Date.today().addDays(60));
        Opportunity opp3 = new Opportunity(Name='Test Opp 3',
        StageName='Negotiation', Amount=3000, CloseDate=Date.today().addDays(90));
        
        Account acc = new Account(Name='Test Account');
        insert acc;
        opp3.AccountId = acc.Id;
        insert new List<Opportunity>{opp1, opp2, opp3};
    }
    
    @IsTest
    static void testFetchOpportunitiesByStage() {
        Test.startTest();
        List<Opportunity> result = TestClassAssingnment2.fetchOpportunitiesByStage('Prospecting');
        System.assertEquals(1, result.size(), 'Expected one opportunity in Prospecting stage');
        System.assertEquals('Prospecting', result[0].StageName, 'Expected stage name to be Prospecting');
        Test.stopTest();
    }
    
    @IsTest
    static void testFetchOpportunitiesByAmount() {
        Test.startTest();
        List<Opportunity> result = TestClassAssingnment2.fetchOpportunitiesByAmount();
        System.assertEquals(1, result.size(), 'Expected one opportunity with the specified amount');
        System.assertEquals(15000, result[0].Amount, 'Expected opportunity amount to be 15000');
        Test.stopTest();
    }
    
    
    @IsTest
    static void testUpdateOpportunitiesToQualification() {
        Test.startTest();
        TestClassAssingnment2.updateOpportunitiesToQualification();
        List<Opportunity> updatedOpps = [SELECT StageName FROM Opportunity WHERE Name = 'Test Opp 1'];
        System.assertEquals('Qualification', updatedOpps[0].StageName, 'Expected stage name to be Qualification');
        Test.stopTest();
    }
    
    @IsTest
    static void testFetchOpportunitiesClosingSoon() {
        Test.startTest();
        List<Opportunity> result = TestClassAssingnment2.fetchOpportunitiesClosingSoon();
        System.assertEquals(1, result.size(), 'Expected one opportunity closing soon');
        System.assertEquals(Date.today().addDays(30), result[0].CloseDate, 'Expected close date to be within the next 30 days'  );
        System.assertEquals('Test Opp 1', result[0].Name, 'Expected opportunity name to be Test Opp 1');
        Test.stopTest();
    }
    
    @IsTest
    static void testFetchOpportunitiesByAccountName() {
        Test.startTest();
        List<Opportunity> result = TestClassAssingnment2.fetchOpportunitiesByAccountName('Test Account');
        System.assertEquals(1, result.size(), 'Expected one opportunity for the specified account');
        System.assertEquals('Test Opp 3', result[0].Name, 'Expected opportunity name to be Test Opp 3');
        Test.stopTest();
    }
}