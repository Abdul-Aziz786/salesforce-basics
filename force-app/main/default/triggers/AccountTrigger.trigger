trigger AccountTrigger on Account (
    before insert,
after insert,
before update,
after update,
before delete,
after delete,
after undelete) {
    TriggerDispatcher.run(new AccountTriggerService(), Trigger.OperationType);
    
}

// trigger AccountTrigger on Account (before delete) {
    
    //     if(Trigger.isBefore && Trigger.isDelete){
    //     }
    
// }