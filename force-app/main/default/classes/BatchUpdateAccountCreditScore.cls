public  class BatchUpdateAccountCreditScore implements Database.Batchable<SObject>{
    
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT Id, Credit_Score__c FROM Account'
            );
    }
    
    public void execute(Database.BatchableContext bc, List<Account> scope) {
        
        Set<Id> accountIds = new Set<Id>();
        for(Account acc : scope){
            accountIds.add(acc.Id);
        }
        
        Map<Id, Decimal> accToAmount = new Map<Id, Decimal>();
        
        for (AggregateResult ar : [
            SELECT AccountId accId, SUM(Amount) totalAmount
            FROM Opportunity
            WHERE AccountId IN :accountIds
            AND StageName = 'Closed Won'
            AND CloseDate = LAST_N_YEARS:1
            GROUP BY AccountId
        ]) {
            accToAmount.put(
                (Id) ar.get('accId'),
            (Decimal) ar.get('totalAmount')
                );
        }
        
        List<Account> updates = new List<Account>();
        
        for(Account acc : scope){
            
            Decimal total = accToAmount.containsKey(acc.Id)
                ? accToAmount.get(acc.Id)
                : 0;
            
            if (total > 500000 ) {
                acc.Credit_Score__c = 'High';
            } else if (total > 100000 ) {
                acc.Credit_Score__c = 'Medium';
            } else {
                acc.Credit_Score__c = 'Low';
            }
            
            updates.add(acc);
        }
        
        if (!updates.isEmpty()) {
            Database.update(updates, false);
        }
    }
    
    public void finish(Database.BatchableContext bc) {}
    
}