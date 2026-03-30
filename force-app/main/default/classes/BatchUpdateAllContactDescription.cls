public  class BatchUpdateAllContactDescription implements Database.Batchable<SObject>, Database.Stateful {
    public Integer totalUpdated = 0;
    
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT Id, Description FROM Contact]);
    }
    
    public void execute(Database.BatchableContext bc, List<Contact> scope) {
        for (Contact con : scope) {
            con.Description = 'Updated By Batch';
        }
        totalUpdated += scope.size();
        update scope;
    }
    
    public void finish(Database.BatchableContext bc) {
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems FROM AsyncApexJob WHERE Id = :bc.getJobId()];
        System.debug('Batch Job Status: ' + job.Status);
        System.debug('Number of Errors: ' + job.NumberOfErrors);
        System.debug('Job Items Processed: ' + job.JobItemsProcessed);
        System.debug('Total Job Items: ' + job.TotalJobItems);
        System.debug('Total Records Updated: ' + totalUpdated);
    }
}