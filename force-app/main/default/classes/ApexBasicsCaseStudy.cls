public  class ApexBasicsCaseStudy {
    // 1
    public static Integer getCurrentYear = Date.today().year();
    // 2
    public static String loggedInUserName = UserInfo.getName();
    public static String userLocale = UserInfo.getLocale();
    public static String userInterface = UserInfo.getUiTheme();
    // 3
    public static Integer loggedInUserNameLength = loggedInUserName.length();
    // 4
    public static String loggedInUserLastNameFirst5Chars = UserInfo.getLastName().substring(0, 5);
    // 5
    public static Date weekStartDate = Date.today().toStartOfWeek();
    
    // 6
    public static void loadAccounts() {
        try {
            List<Account> accounts = new List<Account>();
            for(Integer i = 1; i <= 100; i++) {
                String accountName = i < 10 ? 'test0' + i : 'test' + i;
                Account acc = new Account(Name = accountName);
                accounts.add(acc);
            }
            insert accounts;
        } catch (Exception e) {
            System.debug('Error inserting accounts: ' + e.getMessage());
        }
    }
    // 7
    public static void updateAccounts() {
        try {
            List<Account> accountsToUpdate = [SELECT Id, BillingState FROM Account WHERE BillingState = 'California' ];
            for (Account acc : accountsToUpdate) {
                acc.BillingState = 'Florida';
            }
            update accountsToUpdate;
        } catch (Exception e) {
            System.debug('Error updating accounts: ' + e.getMessage());
        }
    }
    
    // 8
    public static void printWordCounts(String sentence) {
        Map<String, Integer> wordCountMap = new Map<String, Integer>();
        List<String> words = sentence.split(' ');
        
        for (String word : words) {
            if (wordCountMap.containsKey(word)) {
                wordCountMap.put(word, wordCountMap.get(word) + 1);
            } else {
                wordCountMap.put(word, 1);
            }
        }
        
        for (String key : wordCountMap.keySet()) {
            System.debug( key + ' appears (' + wordCountMap.get(key) + ') times');
        }
    }
    // 9
    public static void findArunOrAravind(String searchTerm) {
        List<List<SObject>> searchList = [FIND :searchTerm IN ALL FIELDS RETURNING Lead(Name, Phone), Contact(Name, Phone)];
        System.debug('Leads In - ' + searchTerm);
        for (SObject s : searchList[0]) {
            System.debug(s);
        }
        System.debug('Contacts In - ' + searchTerm);
        for (SObject s : searchList[1]) {
            System.debug(s);
        }
    }
    
    // 10
    
    public static List<Account> getAccountAndRelatedContacts() {
        List<Account> accountsWithContacts = [SELECT Name, (SELECT LastName FROM Contacts) FROM Account  LIMIT 5];
        
        for (Account acc : accountsWithContacts) {
            System.debug('Account Name: ' + acc.Name);
            for (Contact con : acc.Contacts) {
                System.debug('Contact Last Name: ' + con.LastName);
            }
        }
        return accountsWithContacts;
    }
    
    // 11
    public static Integer getTotalOpportunities() {
        Integer totalOpportunities = [SELECT COUNT() FROM Opportunity];
        return totalOpportunities;
    }
    // 12
    public static Decimal accountTotalOpportunitiesAmount(String accName) {
        try {
            Account acc = new Account(Name = 'AO1');
            insert acc;
            Opportunity opp1 = new Opportunity(Name = 'Opp1', Amount = 345,AccountId = acc.Id,StageName = 'Prospecting', CloseDate = Date.today().addDays(5));
            Opportunity opp2 = new Opportunity(Name = 'Opp2', Amount = 567,AccountId = acc.Id,StageName = 'Prospecting', CloseDate = Date.today().addDays(5));
            insert new List<Opportunity>{opp1,opp2};
            
            List<AggregateResult> results = [SELECT SUM(Amount) totalAmount FROM Opportunity WHERE Account.Name = :acc.Name];
            Decimal totalAmount = (Decimal) results[0].get('totalAmount');
            return totalAmount;
        } catch (Exception e) {
            System.debug('Error' + e.getMessage());
            return 0;
        }
    }
    
    // 13
    public static Map<String,Integer> getOpportunityStageCounts() {
        Map<String, Integer> stageCounts = new Map<String, Integer>();
        List<AggregateResult> results = [SELECT StageName, COUNT(Id) oppCount FROM Opportunity GROUP BY StageName];
        
        for (AggregateResult ar : results) {
            String stageName = (String) ar.get('StageName');
            Integer count = (Integer) ar.get('oppCount');
            stageCounts.put(stageName, count);
        }
        return stageCounts;
    }
    
    
    public static void demo() {
        System.debug('--- 1 ----');
        System.debug('Current Year: ' + getCurrentYear);
        System.debug('--- 2 ----');
        System.debug('Logged In User Name: ' + loggedInUserName);
        System.debug('User Locale: ' + userLocale);
        System.debug('User Interface: ' + userInterface);
        System.debug('--- 3 ----');
        System.debug('Logged In User Name Length: ' + loggedInUserNameLength);
        System.debug('--- 4 ----');
        System.debug('First 5 Characters of Logged In User Last Name: ' + loggedInUserLastNameFirst5Chars);
        System.debug('--- 5 ----');
        System.debug('Start Date of Current Week: ' + weekStartDate);
        // System.debug('--- 6 ----');
        // loadAccounts();
        // System.debug('--- 7 ----');
        // updateAccounts();
        System.debug('--- 8 ----');
        printWordCounts('she saw a see saw');
        //System.debug('--- 9 ----');
        // findArunOrAravind('Aravind');
        //System.debug('--- 10 ----');
        ///getAccountAndRelatedContacts();
        //System.debug('--- 11 ----');
        /*System.debug('Total Opportunities: ' + getTotalOpportunities());
        
        System.debug('--- 12 ----');
        System.debug('Total Amount of Opportunities for Account "Ac02": ' + accountTotalOpportunitiesAmount('Ac02'));
        System.debug('--- 13 ----');
        System.debug('Opportunity Stage Counts: ' + getOpportunityStageCounts());
*/
       
    }
}