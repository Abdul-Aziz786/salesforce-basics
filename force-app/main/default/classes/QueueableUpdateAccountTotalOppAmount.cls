public  class QueueableUpdateAccountTotalOppAmount implements Queueable {
    Set<Id> accountIds;
    
    public QueueableUpdateAccountTotalOppAmount(Set<Id> accountIds) {
        this.accountIds = accountIds;
    }
    
    public void execute(QueueableContext context) {
        
        Map<Id, Decimal> accountTotalOppAmountMap = new Map<Id, Decimal>();
        for (AggregateResult ar : [SELECT AccountId, SUM(Amount) totalAmount 
                                    FROM Opportunity 
                                    WHERE AccountId IN :accountIds 
                                    GROUP BY AccountId]) {
            Id accountId = (Id) ar.get('AccountId');
            Decimal totalAmount = (Decimal) ar.get('totalAmount');
            accountTotalOppAmountMap.put(accountId, totalAmount);
        }
        List<Account> accountsToUpdate = new List<Account>();
        for (Account acc : [SELECT Id, Total_Opportunity_Amount__c 
                        FROM Account WHERE Id IN :accountIds]) {
            Decimal newTotal = accountTotalOppAmountMap.containsKey(acc.Id)
                ? accountTotalOppAmountMap.get(acc.Id)
                : 0;
            
            if(acc.Total_Opportunity_Amount__c != newTotal) {
                acc.Total_Opportunity_Amount__c = newTotal;
                accountsToUpdate.add(acc);
            }
        }
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
}