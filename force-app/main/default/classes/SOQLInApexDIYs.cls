public class SOQLInApexDIYs {
        
        public static void demo() {
            
            System.debug('--- DIY 1 ---');
            System.debug('Account Count: ' + getAccountCount());
            
            System.debug('--- DIY 2 ---');
            System.debug('First Account Name: ' + getFirstAccountName());
            
            System.debug('--- DIY 3 ---');
            System.debug('All Contact LastNames: ' + getAllContactNames());
            
            System.debug('--- DIY 4 ---');
            System.debug('Second Account Name: ' + getSecondAccountName());
            
            System.debug('--- DIY 5 ---');
            System.debug('First Opportunity Name: ' + getFirstOpportunityName());
            
            System.debug('--- DIY 6 ---');
            System.debug('Account Phones: ' + getAccountPhones());
            
            System.debug('--- DIY 7 ---');
            System.debug('Contact Count: ' + getContactCount());
            
            System.debug('--- DIY 8 ---');
            System.debug('Closed Won Opportunity Names: ' + getClosedWonOpportunityNames());
            
            System.debug('--- DIY 9 ---');
            System.debug('Second Account Id and Name: ' + getSecondAccountIdAndName());
            
            System.debug('--- DIY 10 ---');
            System.debug('Safe Account Name: ' + getAccountName());
        }

    // DIY 1
    public static Integer getAccountCount() {
        return [SELECT Id FROM Account].size();
        //return [SELECT COUNT() FROM Account];
    }

    // DIY 2 
    public static String getFirstAccountName() {
        List<Account> accs = [
            SELECT Name
            FROM Account
            ORDER BY CreatedDate
            LIMIT 1
        ];

        if (accs.isEmpty()) {
            return null;
        }

        return accs[0].Name;
    }

    // DIY 3
    public static List<String> getAllContactNames() {
        List<Contact> contacts = [
            SELECT LastName
            FROM Contact
        ];

        List<String> names = new List<String>();

        for (Contact c : contacts) {
            names.add(c.LastName);
        }

        return names;
    }

    // DIY 4 
    public static String getSecondAccountName() {
        List<Account> accs = [
            SELECT Name
            FROM Account
            ORDER BY CreatedDate
            LIMIT 2
        ];

        if (accs.size() < 2) {
            return null;
        }

        return accs[1].Name;
    }

    // DIY 5
    public static String getFirstOpportunityName() {
        List<Opportunity> opps = [
            SELECT Name
            FROM Opportunity
            ORDER BY CreatedDate
            LIMIT 1
        ];

        if (opps.isEmpty()) {
            return 'No Opportunities Found';
        }

        return opps[0].Name;
    }

    // DIY 6 
    public static List<String> getAccountPhones() {
        List<Account> accs = [
            SELECT Id,Phone
            FROM Account
        ];

        List<String> phones = new List<String>();

        for (Account a : accs) {
            phones.add(a.Phone);
        }

        return phones;
    }

    // DIY 7 
    public static Integer getContactCount() {
        return [SELECT COUNT() FROM Contact];
    }

    // DIY 8
    public static List<String> getClosedWonOpportunityNames() {
        List<Opportunity> opps = [
            SELECT Name
            FROM Opportunity
            WHERE StageName = 'Closed Won'
        ];

        List<String> names = new List<String>();

        for (Opportunity o : opps) {
            names.add(o.Name);
        }

        return names;
    }

    // DIY 9
    public static String getSecondAccountIdAndName() {
        List<Account> accs = [
            SELECT Id, Name
            FROM Account
            ORDER BY CreatedDate
            LIMIT 2
        ];

        if (accs.size() < 2) {
            return 'Not Enough Accounts';
        }

        return accs[1].Id + ' - ' + accs[1].Name;
    }

    // DIY 10 
    public static String getAccountName() {
        List<Account> accs = [
            SELECT Name
            FROM Account
            LIMIT 1
        ];

        if (accs.isEmpty()) {
            return null;
        }

        return accs[0].Name;
    }
}