public  class DIYSOSL {
    
    public static void demo() {
        List<List<sObject>> results = searchAccountsAndOpportunities('Test');
        List<Account> accounts = (List<Account>)results[0];
        List<Opportunity> opportunities = (List<Opportunity>)results[1];
        System.debug(accounts);
        System.debug(opportunities);
    }
    
    
    public static List<List<sObject>> searchAccountsAndOpportunities(String searchString) {
        List<List<sObject>> results = [FIND :searchString IN Name FIELDS
            RETURNING Account(Id, Name WHERE Rating = 'Hot'),
        Opportunity(Id, Name)];
        return results;
    }
    
    
    
    
}