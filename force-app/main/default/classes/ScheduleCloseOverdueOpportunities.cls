public  class ScheduleCloseOverdueOpportunities implements Schedulable {
    public void execute(SchedulableContext sc) {
        BatchCloseOverdueOpportunities batch = new BatchCloseOverdueOpportunities();
        Database.executeBatch(batch);
    }
}