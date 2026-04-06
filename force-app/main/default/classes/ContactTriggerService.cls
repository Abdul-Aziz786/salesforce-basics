public class ContactTriggerService implements ITrigger {
    public void beforeInsert(List<SObject> newList) {
        
    }
    public void afterInsert(List<SObject> newList,Map<Id,SObject> newMap) {
        // for(SObject s : newList) {
            //     Contact c = (Contact)s;
            
            //     if(c.Email != null && c.LastName != null) {
                //         StripeController.createCustomerInStripe(c.LastName, c.Email, c.Id);
            //     }
        // }
    }
    
    public void beforeUpdate(List<SObject> newList,
    Map<Id,SObject> newMap,
    List<SObject> oldList,
    Map<Id,SObject> oldMap) {
        
        
    }
    
    public void afterUpdate(List<SObject> newList,
    Map<Id,SObject> newMap,
    List<SObject> oldList,
    Map<Id,SObject> oldMap) {
        
    }
    
    public void beforeDelete(List<SObject> oldList,Map<Id,SObject> oldMap) {
        
    }
    
    public void afterDelete(List<SObject> oldList,Map<Id,SObject> oldMap) {
        
    }
    
    public void afterUnDelete(List<SObject> newList,Map<Id,SObject> newMap) {
    }
    
    
}