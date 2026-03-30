public  class ScheduleUpdateInactiveContacts implements Schedulable {
    public void execute(SchedulableContext context) {
        System.enqueueJob(new QueueableUpdateInactiveContacts());
    }
    
}