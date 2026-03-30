public  class CustomerProjectTriggerService implements ITrigger {
    
    public void beforeInsert(List<SObject> newList) {
        
    }
    public void afterInsert(List<SObject> newList,Map<Id,SObject> newMap) {
        CaseStudyHelper.updateActiveCustomerProjectCheckbox((List<Customer_Project__c>)newList);
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
    
    public void afterDelete(List<SObject> oldList,Map<Id,SObject> oldMap) {}
    
    public void afterUnDelete(List<SObject> newList,Map<Id,SObject> newMap) {}
}