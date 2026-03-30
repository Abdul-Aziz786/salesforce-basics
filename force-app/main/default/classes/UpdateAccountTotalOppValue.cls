public  class UpdateAccountTotalOppValue implements Database.Batchable<SObject> ,Database.Stateful {
    
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, Total_Opportunity_Amount__c FROM Account');
    }
    
    public void execute(Database.BatchableContext bc, List<Account> scope) {
        Set<Id> accountIds = new Set<Id>();
        for (Account acc : scope) {
            accountIds.add(acc.Id);
        }
        
        List<AggregateResult> aggResults = [SELECT AccountId, SUM(Amount) totalOppValue 
                                          FROM Opportunity 
                                          WHERE AccountId IN :accountIds 
                                          GROUP BY AccountId];
        
        List<Account> accountsToUpdate = new List<Account>();
        
        for(AggregateResult ar : aggResults) {
            Id accId = (Id) ar.get('AccountId');
            Decimal totalValue = (Decimal) ar.get('totalOppValue');
            Account acc = new Account(Id = accId);
            acc.Total_Opportunity_Amount__c = totalValue;
            accountsToUpdate.add(acc);
        }
        
        if (!accountsToUpdate.isEmpty()) {
            try {
                update accountsToUpdate;
            } catch (DmlException e) {
                System.debug('Error updating accounts: ' + e.getMessage());
            }
        }
    }
    
    public void finish(Database.BatchableContext bc) {
    }
    
}