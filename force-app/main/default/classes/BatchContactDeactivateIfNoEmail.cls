public  class BatchContactDeactivateIfNoEmail implements Database.Batchable<SObject>, Database.Stateful {
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT Id, Email FROM Contact WHERE Email = null]);
    }
    
    public void execute(Database.BatchableContext bc, List<Contact> scope) {
        for (Contact c : scope) {
            c.Active__c = false;
            
            
        }
        if (!scope.isEmpty()) {
            update scope;
        }
    }
    
    public void finish(Database.BatchableContext bc) {
        Database.executeBatch(new BatchNotifyOwners());
    }
    
}