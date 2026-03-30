public class SOQLDIY {
    
    public static void demo() {

        // 1. All Opportunities
        System.debug('All Opportunities:');
        System.debug(getAllOpportunities());

        // 2. Opportunities greater than amount
        System.debug('Opportunities > 10000:');
        System.debug(getOpportunitiesGreaterThan(10000));

        // 3. Count by Stage
        System.debug('Count - Prospecting:');
        System.debug(countOpportunitiesByStage('Prospecting'));

        // 4. By LeadSource and Stage
        System.debug('Web + Qualification:');
        System.debug(
            getOpportunitiesBySourceAndStage(
                'Web',
                'Qualification'
            )
        );

        // 5. Name starts with A
        System.debug('Name starts with A:');
        System.debug(
            getOpportunitiesStartingWith('A')
        );

        // 6. Sum of Amount by Stage
        System.debug('Total Amount - Closed Won:');
        System.debug(
            getStageAmountSum('Closed Won')
        );

        // 7
        AccountOpportunityMap aom = new AccountOpportunityMap();
       // Map<Id, List<Opportunity>> accMap =  aom.getClosedOpportunitiesByAccount();
       // System.debug('Account → Closed Opportunities Map:');
       // System.debug(accMap);

        System.debug('Displaying Account with Opportunities:');
        aom.displayAccountsWithOpportunities();
    }

    // 1. Display All Opportunities
    public static List<Opportunity> getAllOpportunities() {
        return [
            SELECT Id, Name, StageName, Amount, LeadSource, AccountId
            FROM Opportunity
        ];
    }

    // 2. Display Opportunities greater than given Amount
    public static List<Opportunity> getOpportunitiesGreaterThan(Decimal minAmount) {
        return [
            SELECT Id, Name, Amount
            FROM Opportunity
            WHERE Amount > :minAmount
        ];
    }

    // 3. Count opportunities by Stage Name
    public static Integer countOpportunitiesByStage(String stageName) {
        return [
            SELECT COUNT()
            FROM Opportunity
            WHERE StageName = :stageName
        ];
    }

    // 4. List opportunities by Lead Source AND Stage Name
    public static List<Opportunity> getOpportunitiesBySourceAndStage(
        String leadSource,
        String stageName
    ) {
        return [
            SELECT Id, Name, LeadSource, StageName
            FROM Opportunity
            WHERE LeadSource = :leadSource
            AND StageName = :stageName
        ];
    }

    // 5. List opportunities whose name starts with parameter
    public static List<Opportunity> getOpportunitiesStartingWith(String prefix) {
        return [
            SELECT Id, Name
            FROM Opportunity
            WHERE Name LIKE :prefix + '%'
        ];
    }

    // 6. Display sum of Amount for a given Stage
    public static Decimal getStageAmountSum(String stageName) {
        List<Opportunity> opps = [
            SELECT Amount
            FROM Opportunity
            WHERE StageName = :stageName
        ];

        Decimal total = 0;

        for (Opportunity o : opps) {
            if (o.Amount != null) {
                total += o.Amount;
            }
        }

        return total;
    }
    
    public class AccountOpportunityMap {

    public  Map<Id, List<Opportunity>> getClosedOpportunitiesByAccount() {

        List<Opportunity> opps = [
            SELECT Id, Name, StageName, AccountId
            FROM Opportunity
            WHERE StageName IN ('Closed Won', 'Closed Lost')
            AND AccountId != NULL
        ];

        Map<Id, List<Opportunity>> accountOppMap = new Map<Id, List<Opportunity>>();

        for (Opportunity o : opps) {

            if (!accountOppMap.containsKey(o.AccountId)) {
                accountOppMap.put(o.AccountId, new List<Opportunity>());
            }

            accountOppMap.get(o.AccountId).add(o);
        }

        return accountOppMap;
    }


    // Display Accounts and their Opportunities
    public  void displayAccountsWithOpportunities() {
        
        Map<Id,List<Opportunity>> oppGrp = getClosedOpportunitiesByAccount();
        
        List<Account> accList = [SELECT Id,Name
                                 FROM Account
                                 WHERE Id IN :oppGrp.keySet()];
        
        for(Account acc : accList) {
            System.debug('Account Name - ' + acc.Name);
            
            List<Opportunity> opps = oppGrp.get(acc.Id);
            
            for(Opportunity op : opps) {
                System.debug('Opp Name - ' + op.Name);
            }
        }
        
    }
}
}