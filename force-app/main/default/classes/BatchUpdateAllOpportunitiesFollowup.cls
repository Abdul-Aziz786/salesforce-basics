public  class BatchUpdateAllOpportunitiesFollowup implements Database.Batchable<sObject>, Database.Stateful {
    public Integer totalUpdated = 0;
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT Id, Follow_Up__c FROM Opportunity WHERE CloseDate = THIS_MONTH]);
    }
    public void execute(Database.BatchableContext bc, List<Opportunity> scope) {
        for (Opportunity opp : scope) {
            opp.Follow_Up__c = true;
            totalUpdated++;
        }
        System.debug('Updating ' + scope.size() + ' opportunities Per Batch');
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