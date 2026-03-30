trigger TriggerApprovalC on Approval__c (after insert) {
    if (Trigger.isAfter && Trigger.isInsert) {
        RecursiveTriggersDIY2.updateProjectAfterApproval(Trigger.new);
    }
}