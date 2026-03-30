public class AggregateFunctionsDIYs {
    
    public static void demo() {
        Set<Id> accIds = new Map<Id,Account>([SELECT Id FROM Account]).keySet();
        // 1.
        System.debug('--- DIY 1 ------');
        System.debug(getAccountHaveMorethan2Cases(accIds));
        // 2.
        System.debug('--- DIY 2 ------');
        System.debug(getOppCountByStages(new List<String>{'Prospecting','Qualification'}));
        // 3.
        System.debug('--- DIY 3 ------');
        System.debug(getAccountIdAndOppTotalAmount(accIds));
        // 4.
        System.debug('--- DIY 4 ------');
        System.debug(getAccountIdWithMaxAmountCloseDate(accIds));
        
        System.debug('--- DIY 5 ------');
        Map<Id, Integer> contactCountMap = getAccountContactCount(accIds);
        
        Id specificAccountId = '001dL00001ny23pQAA';
        
        if(contactCountMap.containsKey(specificAccountId)) {
            System.debug('Account exists. Contact count = ' + contactCountMap.get(specificAccountId));
        } else {
            System.debug('Account not present');
        }
        
    }
    
    //1. Create a method that accepts a List of Account Ids and 
    // returns a List<Account> of Accounts that have more than 2 related Cases.
    public static List<Account> getAccountHaveMorethan2Cases(Set<Id> input) {
        List<Account> acc = new List<Account>();
        Set<Id> accIdsWith3orMoreCases = new Set<Id>();
        
        List<AggregateResult> arList = [
            SELECT Count(Id) caseCount, AccountId accId 
            FROM Case
            WHERE AccountId IN :input
            GROUP BY AccountId
            HAVING Count(Id) > 2
        ]; 
        
        for(AggregateResult ar:arList) {
            accIdsWith3orMoreCases.add((Id)ar.get('accId'));
        }
        
        acc = [SELECT Id,Name
               FROM Account
               WHERE Id IN : accIdsWith3orMoreCases
              ];
        
        
        return acc;
    } 
    
    //2. Write a method that accepts a List of Opportunity StageNames and 
    // returns a Map<String, Integer> (StageName → Count of Opportunities).
    
    public static Map<String, Integer> getOppCountByStages(List<String > stages) {
        Map<String, Integer> result = new Map<String, Integer>();
        
        List<AggregateResult> opps = [SELECT Count(Id) oppCount,StageName sn
                                      FROM Opportunity
                                      WHERE StageName IN :stages
                                      GROUP BY StageName
                                     ];
        
        for(AggregateResult ar:opps) {
            result.put((String)ar.get('sn'),(Integer)ar.get('oppCount'));
        }
        
        return result;
    }
    
    //3. Create a class method that takes a List of Account Ids and 
    // returns a Map<Id, Decimal> (Accountld → SUM of Opportunity Amount).
    
    public static Map<Id, Decimal> getAccountIdAndOppTotalAmount(Set<Id> input) {
        Map<Id, Decimal> result = new Map<Id, Decimal>();
        
        List<AggregateResult> arList = [
            SELECT SUM(Amount) total,AccountId accId
            FROM Opportunity
            WHERE AccountId IN :input
            GROUP BY AccountId 
        ]; 
        
        for(AggregateResult ar:arList) {
            result.put((Id)ar.get('accId'),(Decimal)ar.get('total'));
        }
        
        return result;
    }
    
    //4. Write a method that accepts a List of Account Ids and 
    // returns a Map<Id, Date> (Accountld → MAX Opportunity CloseDate).
    
    public static Map<Id, Date> getAccountIdWithMaxAmountCloseDate(Set<Id> input) {
        Map<Id, Date> result = new Map<Id, Date>();
        
        List<AggregateResult> arList = [
            SELECT Max(CloseDate) maxDate,AccountId accId
            FROM Opportunity
            WHERE AccountId IN :input
            GROUP BY AccountId 
        ]; 
        
        for(AggregateResult ar:arList) {
            result.put((Id)ar.get('accId'),(Date)ar.get('maxDate'));
        }
        
        return result;
    }
    
    //5. Create a class method that takes a List of Account Ids and 
    // returns a Map<Id, Integer> (Accountld → Count of Contacts), 
    // and also check if a specific Account Id exists in the map using containskey.
    public static Map<Id, Integer> getAccountContactCount(Set<Id> accountIds) {
        
        Map<Id, Integer> result = new Map<Id, Integer>();
        
        for(AggregateResult ar : [
            SELECT AccountId accId, COUNT(Id) totalContacts
            FROM Contact
            WHERE AccountId IN :accountIds
            GROUP BY AccountId
        ]) {
            Id accId = (Id) ar.get('accId');
            Integer countVal = (Integer) ar.get('totalContacts');
            result.put(accId, countVal);
        }
        
        return result;
    }
}