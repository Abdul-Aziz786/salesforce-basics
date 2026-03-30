public  class DynamicDMLAssignment {
    
    public static void demo() {
        List<Account> accounts = findAccountRecords('Id, Name, Industry');
        System.debug(accounts);
        
        List<Opportunity> opportunities = searchOpportunities(
            'Id, Name, StageName, Amount',
        '=',
        'Prospecting',
        '<',
        5000,
        'AND'
            );
        System.debug(opportunities);
        
        // 3. Filter Accounts by Fixed Fields
        List<Account> filteredAccounts = findAccounts('Acme', 'Tech', 'USA');
        System.debug(filteredAccounts);
        
        // 4. Dynamic Lead Query by Fields and Status with Limit
        List<String> leadFields = new List<String>{'Id', 'Name', 'Company', 'Email', 'Status'};
        List<Lead> leads = getLeads(leadFields, 'Open - Not Contacted', 3);
        System.debug(leads);
        
        // 5. Retrieve Top N Opportunities by Amount
        List<String> oppFields = new List<String>{'Id', 'Name', 'Amount', 'CloseDate', 'StageName'};
        List<Opportunity> topOpps = getTopOpportunities('Prospecting', 5, oppFields, 'DESC');
        System.debug(topOpps);
    }
    
    //DIY - 1: Dynamic Account Query by Specified Fields
    public static List<Account> findAccountRecords(String fieldList) {
        if (String.isBlank(fieldList)) {
            fieldList = 'Id, Name';
        }
        String query = 'SELECT ' + fieldList + ' FROM Account';
        return Database.query(query);
    }
    
    // DIY - 2: Dynamic Opportunity Search with Filterss
    
    public static List<Opportunity> searchOpportunities(
        String fieldsList,
    String stageOperator,
    String stageValue,
    String amountOperator,
    Decimal amountValue,
    String logicalOperator) {
        
        if (String.isBlank(fieldsList)) {
            fieldsList = 'Id, Name';
        }
        Map<String,Object> bindMap = new Map<String,Object>{
            'StageName' => stageValue,
            'Amount' => amountValue
        };
        
        String query = 'SELECT ' + fieldsList
            + ' FROM Opportunity WHERE StageName '
            + stageOperator + ' :StageName '
            + logicalOperator + ' Amount '
            + amountOperator + ' :Amount';
        return Database.queryWithBinds(query, bindMap, AccessLevel.USER_MODE);
    }
    
    
    // DIY - 3: Filter Accounts by Fixed Fields
    public static List<Account> findAccounts(String namePattern, String industryPattern, String countryPattern) {
        String query = 'SELECT Id, Name, Industry, BillingCountry FROM Account WHERE ' +
            '(Name LIKE :namePattern OR Industry LIKE :industryPattern OR BillingCountry LIKE :countryPattern)';
        Map<String,Object> bindMap = new Map<String,Object>{
            'namePattern' => '%' + namePattern + '%',
            'industryPattern' => '%' + industryPattern + '%',
            'countryPattern' => '%' + countryPattern + '%'
        };
        return Database.queryWithBinds(query, bindMap, AccessLevel.USER_MODE);
    }
    
    // DIY 4: Dynamic Lead Query by Fields and Status with Limit
    public static List<Lead> getLeads(List<String> fieldsList, String leadStatus, Integer recordLimit) {
        if (fieldsList == null || fieldsList.isEmpty()) {
            fieldsList = new List<String>{'Id', 'Name'};
        }
        String fieldString = String.join(fieldsList, ', ');
        String query = 'SELECT ' + fieldString + ' FROM Lead WHERE Status = :leadStatus LIMIT :recordLimit';
        Map<String,Object> bindMap = new Map<String,Object>{
            'leadStatus' => leadStatus,
            'recordLimit' => recordLimit
        };
        return Database.queryWithBinds(query, bindMap, AccessLevel.USER_MODE);
    }
    
    
    // DIY 5: Retrieve Top N Opportunities by Amount
    
    
    public static List<Opportunity> getTopOpportunities(String stageName, Integer topCount, List<String> fieldsList, String orderDirection) {
        if (fieldsList == null || fieldsList.isEmpty()) {
            fieldsList = new List<String>{'Id', 'Name', 'Amount'};
        }
        
        if (orderDirection != 'ASC' && orderDirection != 'DESC') {
            orderDirection = 'DESC';
        }
        String fieldString = String.join(fieldsList, ', ');
        String query = 'SELECT ' + fieldString + ' FROM Opportunity WHERE StageName = :stageName ORDER BY Amount ' + orderDirection + ' LIMIT :topCount';
        Map<String,Object> bindMap = new Map<String,Object>{
            'stageName' => stageName,
            'topCount' => topCount
        };
        return Database.queryWithBinds(query, bindMap, AccessLevel.USER_MODE);
    }
}