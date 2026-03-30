public class SOSLAssignment {
    
    public static void demo() {
        List<List<sObject>> results = searchUnitedOil();
        List<Account> accounts = (List<Account>)results[0];
        List<Contact> contacts = (List<Contact>)results[1];
        List<Opportunity> opportunities = (List<Opportunity>)results[2];
        System.debug('DIY - 1 - a) Search for United Oil');
        System.debug('Accounts: ' + accounts);
        System.debug('Contacts: ' + contacts);
        System.debug('Opportunities: ' + opportunities);
        
        System.debug('DIY - 1 - b) Search for Pyramid ');
        results = searchPyramid();
        accounts = (List<Account>)results[0];
        List<Lead> leads = (List<Lead>)results[1];
        System.debug('Accounts: ' + accounts);
        System.debug('Leads: ' + leads);
        
        System.debug('DIY - 2 - Search for Burlington');
        searchBurlington();
        
        System.debug('DIY - 3 - Print Accounts and Contacts Name Only');
        printAccountsAndContactsNameOnly('Test');
        
        System.debug('DIY - 4 - Search Accounts and Contacts with filters');
        SearchAccountsContacts('Test');
        
        System.debug('DIY - 5 - Find Hot Accounts and Open Opportunities');
        findHotAccountsAndOpenOpportunities('Test');
        
        System.debug('DIY - 6 - Account and Opportunity Fetcher');
        List<String> accountTypes = new List<String>{'Customer - Direct', 'Prospect'};
        accountOpportunityFetcher('Test', accountTypes, 50000, 5);
    }
    
    
    // DIY - 1:
    // a)
    public static List<List<sObject>> searchUnitedOil() {
        List<List<sObject>> results = [FIND 'United Oil' IN ALL FIELDS
            RETURNING Account(Id, Name), Contact(Id, Name), Opportunity(Id, Name)];
        return results;
    }
    // b)
    public static List<List<sObject>> searchPyramid() {
        List<List<sObject>> results = [FIND 'Pyramid' IN NAME FIELDS
            RETURNING Account(Id, Name), Lead(Id, Name)];
        return results;
    }
    
    // DIY - 2
    public static void searchBurlington() {
        List<List<sObject>> results = [FIND 'Burlington' IN ALL FIELDS
            RETURNING Account(Id, Name), Contact(Id, Name)];
        List<Account> accounts = (List<Account>)results[0];
        List<Contact> contacts = (List<Contact>)results[1];
        System.debug('Accounts: ' + accounts);
        System.debug('Contacts: ' + contacts);
    }
    
    // DIY - 3
    public static void printAccountsAndContactsNameOnly(String searchString) {
        List<List<sObject>> results = [FIND :searchString IN NAME FIELDS
            RETURNING Account(Id, Name), Contact(Id, Name)];
        List<Account> accounts = (List<Account>)results[0];
        List<Contact> contacts = (List<Contact>)results[1];
        System.debug('Accounts: ');
        for (Account acc : accounts) {
            System.debug(acc.Name);
        }
        
        System.debug('Contacts: ');
        for (Contact con : contacts) {
            System.debug(con.Name);
        }
    }
    
    // DIY - 4
    
    public static void SearchAccountsContacts(String searchString) {
        List<List<sObject>> results = [FIND :searchString IN ALL FIELDS
            RETURNING Account(Id, Name, AnnualRevenue WHERE AnnualRevenue > 25000),
        Contact(Id, FirstName, LastName, Email WHERE Email != null)];
        
        List<Account> accounts = (List<Account>)results[0];
        List<Contact> contacts = (List<Contact>)results[1];
        
        System.debug('Accounts with AnnualRevenue > 25,000:');
        for (Account acc : accounts) {
            System.debug('Name: ' + acc.Name + ', AnnualRevenue: ' + acc.AnnualRevenue);
        }
        
        System.debug('Contacts with non-empty Email:');
        for (Contact con : contacts) {
            System.debug('Full Name: ' + con.FirstName + ' ' + con.LastName + ', Email: ' + con.Email);
        }
    }
    
    // DIY 5
    
    public static void findHotAccountsAndOpenOpportunities(String searchString) {
        List<List<sObject>> results = [FIND :searchString IN ALL FIELDS
            RETURNING Account(Id, Name WHERE Rating = 'Hot'),
        Opportunity(Id, Name WHERE StageName != 'Closed Won' AND StageName != 'Closed Lost')];
        
        List<Account> accounts = (List<Account>)results[0];
        List<Opportunity> opportunities = (List<Opportunity>)results[1];
        System.debug('Accounts');
        for (Account acc : accounts) {
            System.debug(acc.Name);
        }
        System.debug('Opportunities');
        for (Opportunity opp : opportunities) {
            System.debug(opp.Name);
        }
    }
    
    
    // DIY - 6
    public static void accountOpportunityFetcher(String searchString, List<String> accountTypes, Decimal minAnnualRevenue, Integer topN) {
        if (String.isBlank(searchString)) {
            System.debug('Search string cannot be blank.');
            return;
        }
        if (accountTypes == null || accountTypes.isEmpty()) {
            System.debug('Account types list cannot be null or empty.');
            return;
        }
        if (minAnnualRevenue < 0) {
            System.debug('Minimum Annual Revenue cannot be negative.');
            return;
        }
        if (topN <= 0) {
            System.debug('Top N must be greater than zero.');
            return;
        }
        
        
        
        List<List<SObject>> results = [ FIND :searchString IN ALL FIELDS
            RETURNING
            Account(Id, Name, Type, AnnualRevenue
            WHERE Type IN :accountTypes
            AND AnnualRevenue >= :minAnnualRevenue
            LIMIT :topN),
        Opportunity(Id, Name, StageName
            WHERE StageName != 'Closed Won'
            LIMIT :topN)
            ];
        
        List<Account> accounts = (List<Account>)results[0];
        List<Opportunity> opportunities = (List<Opportunity>)results[1];
        
        System.debug('Accounts matching criteria:');
        for (Account acc : accounts) {
            System.debug('Name: ' + acc.Name);
        }
        
        System.debug('Opportunities matching criteria:');
        for (Opportunity opp : opportunities) {
            System.debug('Name: ' + opp.Name);
        }
    }
}