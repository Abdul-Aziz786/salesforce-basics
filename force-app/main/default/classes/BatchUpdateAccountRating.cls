public with sharing class BatchUpdateAccountRating implements Database.Batchable<SObject>, Database.Stateful {
    public Integer totalUpdated = 0;
    public Map<Id,String> failedRecords = new Map<Id,String>();
    
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT Id, Rating, Description FROM Account]);
    }
    
    public void execute(Database.BatchableContext bc, List<Account> scope) {
        for (Account acc : scope) {
            acc.Rating = 'Hot';
        }
        List<Database.SaveResult> result = Database.update(scope, false);
        
        for (Database.SaveResult r : result) {
            if (r.isSuccess()) {
                totalUpdated++;
            } else {
                String errorMessages = '';
                for (Database.Error err : r.getErrors()) {
                    errorMessages +=  err.getMessage() + '; ';
                }
                failedRecords.put(r.getId(), errorMessages);
            }
        }
    }
    
    public void finish(Database.BatchableContext bc) {
        System.debug('Total Records Updated: ' + totalUpdated);
        for (Id id : failedRecords.keySet()) {
            System.debug('Failed Record Id: ' + id);
            System.debug('Failed Record Errors: ' + failedRecords.get(id));
        }
    }
}