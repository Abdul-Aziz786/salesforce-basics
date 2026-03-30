@IsTest
public  class OpportunityTriggerTest {
    
    @TestSetup
    static void makeData(){
        Account acc1 = new Account(Name = 'Test Account 1');
        insert acc1;
    }
    
    @IsTest
    static void testAccountOppTotalAmountAfterInsert(){
        
        Test.startTest();
        
        Opportunity opp1 = new Opportunity(
            Name = 'Test Opportunity 1',
        Amount = 10000,
        StageName = 'Prospecting',
        CloseDate = Date.today().addDays(30),
        AccountId = [SELECT Id FROM Account LIMIT 1].Id
            );
        insert opp1;
        
        Test.stopTest();
        Account acc = [SELECT Id, Total_Opportunity_Amount__c FROM Account LIMIT 1];
        System.assertEquals(10000, acc.Total_Opportunity_Amount__c);
        
    }
    
    @IsTest
    static void testAccountOppTotalAmountAfterUpdate(){
        
        Test.startTest();
        
        Opportunity opp1 = new Opportunity(
            Name = 'Test Opportunity 1',
        Amount = 10000,
        StageName = 'Prospecting',
        CloseDate = Date.today().addDays(30),
        AccountId = [SELECT Id FROM Account LIMIT 1].Id
            );
        insert opp1;
        
        opp1.Amount = 20000;
        update opp1;
        
        Test.stopTest();
        Account acc = [SELECT Id, Total_Opportunity_Amount__c FROM Account LIMIT 1];
        System.assertEquals(20000, acc.Total_Opportunity_Amount__c);
    }
    
    @isTest
    static void testAccountOppTotalAmountAfterDelete(){
        
        Test.startTest();
        
        Opportunity opp1 = new Opportunity(
            Name = 'Test Opportunity 1',
        Amount = 10000,
        StageName = 'Prospecting',
        CloseDate = Date.today().addDays(30),
        AccountId = [SELECT Id FROM Account LIMIT 1].Id
            );
        insert opp1;
        
        
        delete opp1;
        
        
        Test.stopTest();
        Account acc = [SELECT Id, Total_Opportunity_Amount__c FROM Account LIMIT 1];
        System.assertEquals(0, acc.Total_Opportunity_Amount__c);
    }
}