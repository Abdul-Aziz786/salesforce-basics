public class TriggerDispatcher {
    public static void run(ITrigger service,System.TriggerOperation operation) {
        
        switch on operation {
            when BEFORE_INSERT {
                service.beforeInsert(Trigger.New);
            }
            when AFTER_INSERT {
                service.afterInsert(Trigger.New, Trigger.newMap);
            }
            when BEFORE_UPDATE {
                service.beforeUpdate(Trigger.New, Trigger.newMap, Trigger.old, Trigger.oldMap);
            }
            when AFTER_UPDATE {
                service.afterUpdate(Trigger.New, Trigger.newMap, Trigger.old, Trigger.oldMap);
            }
            when BEFORE_DELETE {
                service.beforeDelete(Trigger.old, Trigger.oldMap);
            }
            when AFTER_DELETE {
                service.afterDelete(Trigger.old, Trigger.oldMap);
            }
            when AFTER_UNDELETE {
                service.afterUnDelete(Trigger.New, Trigger.newMap);
            }
        }
    }
}