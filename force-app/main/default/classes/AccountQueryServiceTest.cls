@IsTest
private class AccountQueryServiceTest {
    @IsTest
    static void testGovernorLimitsResetWithStartStopTest() {
        insert new List<Account>{
            new Account(Name = 'Gov Limit Account 1'),
            new Account(Name = 'Gov Limit Account 2')
        };
            
        Integer queriesBeforeStart = Limits.getQueries();
        System.debug('Before - ' + queriesBeforeStart);
        Test.startTest();
        Integer queriesAtStart = Limits.getQueries();
        System.debug('At Start - ' + queriesAtStart);
        List<Account> accounts = AccountQueryService.getAccounts();
        Integer queriesAfterServiceCall = Limits.getQueries();
        System.debug('After Service Call - ' + queriesAfterServiceCall);
        Test.stopTest();
        
        Assert.isTrue(queriesBeforeStart >= 0, 'Query count before startTest should be available.');
        Assert.areEqual(0, queriesAtStart, 'SOQL governor limits should reset at startTest.');
        Assert.areEqual(1, queriesAfterServiceCall, 'Service method should consume one SOQL query.');
        Assert.isTrue(accounts.size() >= 2, 'Inserted accounts should be returned.');
    }
}