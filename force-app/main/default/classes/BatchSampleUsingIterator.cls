public  class BatchSampleUsingIterator implements Database.Batchable<Account>, Database.Stateful {
    public Integer totalProcessed = 0;
    
    public class AccountIterable implements Iterable<Account>{
        public Iterator<Account> iterator(){
            List<Account> accounts = [
            SELECT Id, Industry FROM Account LIMIT 500
        ];
            return accounts.iterator();
        }
    }
    public Iterable<Account> start(Database.BatchableContext bc) {
        return new AccountIterable();
    }
    public void execute(Database.BatchableContext bc, List<Account> scope) {
        for (Account acc : scope) {
            System.debug('Processing Account: ' + acc.Name);
            totalProcessed++;
        }
    }
    
    public void finish(Database.BatchableContext bc) {
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems FROM AsyncApexJob WHERE Id = :bc.getJobId()];
        System.debug('Batch Job Status: ' + job.Status);
        System.debug('Number of Errors: ' + job.NumberOfErrors);
        System.debug('Job Items Processed: ' + job.JobItemsProcessed);
        System.debug('Total Job Items: ' + job.TotalJobItems);
        System.debug('Total Records Processed: ' + totalProcessed);
    }
    
}