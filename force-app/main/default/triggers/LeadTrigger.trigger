trigger LeadTrigger on Lead (before insert,before update) {
    if(Trigger.isBefore && Trigger.isUpdate) {
       // DIYMapTriggerHelper.preventLeadSourceToClear((Map<Id,Lead>)Trigger.oldMap,(Map<Id,Lead>)Trigger.newMap);
    }
}