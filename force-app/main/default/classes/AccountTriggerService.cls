public class AccountTriggerService implements ITrigger {
    
    static Set<Id> processedIds = new Set<Id>();
    
    public void beforeInsert(List<SObject> newList) {
        
    }
    public void afterInsert(List<SObject> newList,Map<Id,SObject> newMap) {
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
        Set<Id> accountIds = new Set<Id>();
        for(Account acc : (List<Account>)newList) {
            Account oldAcc = (Account)oldMap.get(acc.Id);
            if(acc.Phone != oldAcc.Phone && !processedIds.contains(acc.Id)) {
                accountIds.add(acc.Id);
                processedIds.add(acc.Id);
            }
        }
        
        updatePhoneNumberToRelatedContacts(accountIds);
    }
    
    public void beforeDelete(List<SObject> oldList,Map<Id,SObject> oldMap) {
    }
    
    public void afterDelete(List<SObject> oldList,Map<Id,SObject> oldMap) {}
    
    public void afterUnDelete(List<SObject> newList,Map<Id,SObject> newMap) {}
    
    @future
    static void updatePhoneNumberToRelatedContacts(Set<Id> accountIds) {
        if(accountIds.isEmpty()) {
            return;
        }
        
        Map<Id,Account> newMap = new Map<Id,Account>([SELECT Id, Phone FROM Account WHERE Id IN :accountIds]);
        System.debug('Account IDs with changed phone numbers: ' + accountIds.size());
        List<Contact> cons = [SELECT Id, AccountId, Phone FROM Contact WHERE AccountId IN :accountIds];
        for(Contact con : cons) {
            Account newAcc = newMap.get(con.AccountId);
            con.Phone = newAcc.Phone;
        }
        if(!cons.isEmpty()) {
            try {
                update cons;
            } catch(Exception e) {
                System.debug('Error updating contact phone numbers: ' + e.getMessage());
            }
        }
    }
}