trigger TaskTrigger on Task (before insert,after insert,
before update,after update,before delete,after delete) {
    // TriggerRollupWithAggregateDIY.rollupTotalTaskOnProject(Trigger.new, Trigger.newMap, Trigger.old, Trigger.oldMap);
}