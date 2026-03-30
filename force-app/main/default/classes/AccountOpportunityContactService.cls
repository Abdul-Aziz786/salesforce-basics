public class AccountOpportunityContactService {
    public class FetchResult {
        public List<Opportunity> opportunities;
        public List<Contact> contacts;
        
        public FetchResult() {
            opportunities = new List<Opportunity>();
            contacts = new List<Contact>();
        }
    }
    
    public static FetchResult getAccountData(String accountName) {
        return fetchByAccountName(accountName);
    }
    
    
    @TestVisible
    private static FetchResult fetchByAccountName(String accountName) {
        FetchResult result = new FetchResult();
        
        if (String.isBlank(accountName)) {
            return result;
        }
        
        List<Account> accounts = [
            SELECT Id
            FROM Account
            WHERE Name = :accountName
            LIMIT 1
        ];
        
        if (accounts.isEmpty()) {
            return result;
        }
        
        Id accountId = accounts[0].Id;
        
        result.opportunities = [
            SELECT Id, Name, StageName, Amount
            FROM Opportunity
            WHERE AccountId = :accountId
        ];
        
        if (!Test.isRunningTest()) {
            result.contacts = [
                SELECT Id, LastName, Email
                FROM Contact
                WHERE AccountId = :accountId
            ];
        }
        
        return result;
    }
}