public class BatchUpdateAllAccountIndustryIfBlank implements Database.Batchable<SObject>, Database.Stateful {
    public Integer totalUpdated = 0;
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT Id, Industry FROM Account WHERE Industry = null]);
    }
    public void execute(Database.BatchableContext bc, List<Account> scope) {
        for (Account acc : scope) {
            acc.Industry = 'Technology';
            totalUpdated++;
        }
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