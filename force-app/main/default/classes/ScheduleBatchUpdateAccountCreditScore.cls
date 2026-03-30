public  class ScheduleBatchUpdateAccountCreditScore implements Schedulable {
    
    public void execute(SchedulableContext sc) {
        BatchUpdateAccountCreditScore batch = new BatchUpdateAccountCreditScore();
        Database.executeBatch(batch);
    }
}