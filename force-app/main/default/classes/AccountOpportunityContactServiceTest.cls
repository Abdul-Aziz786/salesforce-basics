@IsTest
private class AccountOpportunityContactServiceTest {
    @IsTest
    static void testFetchByAccountNameSkipsContactsInTestContext() {
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        
        insert new Opportunity(
            Name = 'Test Opportunity',
        StageName = 'Prospecting',
        CloseDate = Date.today().addDays(30),
        AccountId = acc.Id
            );
        
        insert new Contact(
            LastName = 'Test Contact',
        AccountId = acc.Id
            );
        
        AccountOpportunityContactService.FetchResult result =
            AccountOpportunityContactService.fetchByAccountName(acc.Name);
        
        Assert.areEqual(1, result.opportunities.size(), 'Opportunities should be fetched for the account.');
        Assert.areEqual(0, result.contacts.size(), 'Contacts should be skipped in test.');
    }
}