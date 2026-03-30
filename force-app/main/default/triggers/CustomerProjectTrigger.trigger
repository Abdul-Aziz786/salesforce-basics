trigger CustomerProjectTrigger on Customer_Project__c (
    before insert,
after insert,
before update,
after update,
before delete,
after delete,
after undelete) {
    TriggerDispatcher.run(new CustomerProjectTriggerService(), Trigger.OperationType);
    
    // if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
        //     RecursiveTriggersDIY2.createApproval(Trigger.new);
    // }
    
}