public class AccountUtility {
    public static Integer getAccountsRelatedChild() {
        List<Account> accList = [Select Name, (Select LastName from Contacts), (Select Name, StageName, Amount from Opportunities) From Account];
        Integer contactCount=0,opportunityCount=0, totalChildRecords=0;
        for (Account acc:accList) {
            if(acc.contacts.size()>0)
                contactCount=acc.contacts.size();
            
            if(acc.opportunities.size()>0)
                opportunityCount=acc.opportunities.size();
        }
        totalChildRecords=contactCount+opportunityCount;
        return totalChildRecords;
    }
    
    public static Integer clearAccount()
    {
        List<Account> inactiveAccounts = [Select Name from Account where Status__c='Inactive'];
        delete inactiveAccounts;
        return inactiveAccounts.size();
    }
    
    public static String getCategory(String accName) {
        if (String.isBlank(accName)) {
            return 'Unknown';
        }
        
        List<Account> accounts = [
            SELECT AnnualRevenue
            FROM Account
            WHERE Name = :accName
            LIMIT 1
        ];
        
        if (accounts.isEmpty() || accounts[0].AnnualRevenue == null) {
            return 'Unknown';
        }
        
        Decimal annualRevenue = accounts[0].AnnualRevenue;
        if (annualRevenue >= 1000000) {
            return 'Platinum';
        } else if (annualRevenue >= 500000) {
            return 'Gold';
        } else if (annualRevenue >= 100000) {
            return 'Silver';
        }
        
        return 'Bronze';
    }
    
    public static String getRevenueRange(String accountName) {
        if (String.isBlank(accountName)) {
            return 'Unknown';
        }
        
        List<Account> accounts = [
            SELECT AnnualRevenue
            FROM Account
            WHERE Name = :accountName
            LIMIT 1
        ];
        
        if (accounts.isEmpty() || accounts[0].AnnualRevenue == null) {
            return 'Unknown';
        }
        
        Decimal annualRevenue = accounts[0].AnnualRevenue;
        if (annualRevenue >= 1000000) {
            return 'High';
        } else if (annualRevenue >= 500000) {
            return 'Medium';
        }
        
        return 'Low';
    }
}