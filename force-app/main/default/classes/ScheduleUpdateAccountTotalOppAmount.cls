public  class ScheduleUpdateAccountTotalOppAmount implements Schedulable {
    
    public void execute(SchedulableContext sc) {
        UpdateAccountTotalOppValue batch = new UpdateAccountTotalOppValue();
        Database.executeBatch(batch);
    }
}