@isTest
public  class UpdateAccountTotalOppValueTest {
    
    @testSetup
    static void setup() {
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 5; i++) {
            accounts.add(new Account(Name = 'Test Account ' + i));
        }
        insert accounts;
        
        List<Opportunity> opps = new List<Opportunity>();
        for (Account acc : accounts) {
            for (Integer j = 0; j < 3; j++) {
                opps.add(new Opportunity(Name = 'Test Opp ' + j,
                 AccountId = acc.Id,
                 Amount = 100 * (j + 1),
                 StageName = 'Prospecting', 
                 CloseDate = Date.today().addDays(30)));
            }
        }
        insert opps;
    }
    
    @isTest
    static void testBatchExecution() {
        Test.startTest();
        UpdateAccountTotalOppValue batch = new UpdateAccountTotalOppValue();
        Database.executeBatch(batch);
        Test.stopTest();
        
        List<Account> updatedAccounts = [SELECT Id, Total_Opportunity_Amount__c FROM Account];
        for (Account acc : updatedAccounts) {
            System.assertEquals(600, acc.Total_Opportunity_Amount__c, 'Total Opportunity Amount should be 600 for each account');
        }
    }
}