trigger CaseTrigger on Case (before insert,before update) {   
    if(Trigger.isBefore && Trigger.isUpdate) {
       // DIYMapTriggerHelper.preventReopenClosedCases((Map<Id,Case>)Trigger.oldMap,(Map<Id,Case>)Trigger.newMap);
    }
    
}