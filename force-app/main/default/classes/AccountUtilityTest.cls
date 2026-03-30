@IsTest
class AccountUtilityTest {
    
    @IsTest
    static void testGetAccountsRelatedChild() {
        Account acc = new Account(Name='Test Account');
        insert acc;
        Contact con = new Contact(LastName='Test Contact', AccountId=acc.Id);
        insert con;
        Opportunity opp = new Opportunity(Name='Test Opportunity', AccountId=acc.Id, StageName='Prospecting', CloseDate=Date.today());
        insert opp;
        Integer totalChildRecords = AccountUtility.getAccountsRelatedChild();
        System.Assert.areEqual(2, totalChildRecords, 'Total child records should be 2');
        delete opp;
        delete con;
        delete acc;
        totalChildRecords = AccountUtility.getAccountsRelatedChild();
        Assert.areEqual(0, totalChildRecords, 'Total child records should be 0 after deletion');
    }
    
    @IsTest
    static void testClearAccount() {
        Account acc1 = new Account(Name='Active Account', Status__c='Active');
        Account acc2 = new Account(Name='Inactive Account', Status__c='Inactive');
        insert new List<Account>{acc1, acc2};
        Integer inactiveCount = AccountUtility.clearAccount();
        System.debug(inactiveCount);
        Assert.areEqual(1, inactiveCount, 'One inactive account should be deleted');
    }
    
    @IsTest
    static void testGetCategory() {
        insert new List<Account>{
            new Account(Name = 'Acc Platinum', AnnualRevenue = 1000000),
            new Account(Name = 'Acc Gold', AnnualRevenue = 500000),
            new Account(Name = 'Acc Silver', AnnualRevenue = 100000),
            new Account(Name = 'Acc Bronze', AnnualRevenue = 50000),
            new Account(Name = 'Acc Unknown')
        };
        
        Assert.areEqual('Platinum', AccountUtility.getCategory('Acc Platinum'));
        Assert.areEqual('Gold', AccountUtility.getCategory('Acc Gold'));
        Assert.areEqual('Silver', AccountUtility.getCategory('Acc Silver'));
        Assert.areEqual('Bronze', AccountUtility.getCategory('Acc Bronze'));
        Assert.areEqual('Unknown', AccountUtility.getCategory('Acc Unknown'));
        Assert.areEqual('Unknown', AccountUtility.getCategory('Not Existing'));
        Assert.areEqual('Unknown', AccountUtility.getCategory(null));
    }
    
    @IsTest
    static void testGetRevenueRange() {
        insert new List<Account>{
            new Account(Name = 'Acc High', AnnualRevenue = 1000000),
            new Account(Name = 'Acc Medium', AnnualRevenue = 500000),
            new Account(Name = 'Acc Low', AnnualRevenue = 100000),
            new Account(Name = 'Acc Rev Unknown')
        };
        
        Assert.areEqual('High', AccountUtility.getRevenueRange('Acc High'));
        Assert.areEqual('Medium', AccountUtility.getRevenueRange('Acc Medium'));
        Assert.areEqual('Low', AccountUtility.getRevenueRange('Acc Low'));
        Assert.areEqual('Unknown', AccountUtility.getRevenueRange('Acc Rev Unknown'));
        Assert.areEqual('Unknown', AccountUtility.getRevenueRange('Not Existing'));
        Assert.areEqual('Unknown', AccountUtility.getRevenueRange(null));
    }
}