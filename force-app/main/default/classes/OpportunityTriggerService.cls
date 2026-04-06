public  class OpportunityTriggerService implements ITrigger {
    public void beforeInsert(List<SObject> newList) {
    }
    
    public void afterInsert(List<SObject> newList,Map<Id,SObject> newMap) {
        
        
        
    }
    
    public void beforeUpdate(List<SObject> newList,
    Map<Id,SObject> newMap,
    List<SObject> oldList,
    Map<Id,SObject> oldMap)
    {     }
    
    public void afterUpdate(List<SObject> newList,
    Map<Id,SObject> newMap,
    List<SObject> oldList,
    Map<Id,SObject> oldMap) {
        Opportunity opp = (Opportunity) newList[0];
        Opportunity oldOpp = (Opportunity) oldMap.get(opp.Id);
        
        if(opp.StageName == 'Closed Won' && opp.StageName != oldOpp.StageName) {
            String amount = String.valueOf((Integer)opp.Amount) + '00';
            String oppName = opp.Name;
            String oppId = opp.Id;
            StripeController.updatePaymentLinkInOpportunity(amount, oppName, oppId);
        }
        
    }
    public void beforeDelete(List<SObject> oldList,Map<Id,SObject> oldMap) {}
    
    public void afterDelete(List<SObject> oldList,Map<Id,SObject> oldMap) {
    }
    public void afterUnDelete(List<SObject> newList,Map<Id,SObject> newMap) {
    }
    
    void UpdateAccountTotalOppValue(List<Opportunity> newList,
    List<Opportunity> oldList) {
        Set<Id> accountIds = new Set<Id>();
        
        if (newList != null) {
            for (Opportunity opp : newList) {
                if (opp.AccountId != null) {
                    accountIds.add(opp.AccountId);
                }
            }
        }
        
        if (oldList != null && newList == null) {
            for (Opportunity opp : oldList) {
                if (opp.AccountId != null) {
                    accountIds.add(opp.AccountId);
                }
            }
        }
        
        if(newList != null && oldList != null) {
            for (Integer i = 0; i < newList.size(); i++) {
                Opportunity newOpp = newList[i];
                Opportunity oldOpp = oldList[i];
                if (newOpp.AccountId != oldOpp.AccountId || newOpp.Amount != oldOpp.Amount) {
                    if (newOpp.AccountId != null) {
                        accountIds.add(newOpp.AccountId);
                    }
                    if (oldOpp.AccountId != null) {
                        accountIds.add(oldOpp.AccountId);
                    }
                }
            }
        }
        
        if (!accountIds.isEmpty()) {
            System.enqueueJob(new QueueableUpdateAccountTotalOppAmount(accountIds));
        }
    }
    
}