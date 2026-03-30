trigger ContactTrigger on Contact (
    before insert,
after insert,
before update,
after update,
before delete,
after delete,
after undelete) {
    TriggerDispatcher.run(new ContactTriggerService(), Trigger.OperationType);
    
    
    
}


// trigger ContactTrigger on Contact (after insert, after update, after delete, after undelete) {
    
    //     Set<Id> accountIds = new Set<Id>();
    
    //     if(Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete){
        //         for(Contact c : Trigger.new){
            //             if(c.AccountId != null){
                //                 accountIds.add(c.AccountId);
            //             }
        //         }
    //     }
    
    //     if(Trigger.isUpdate || Trigger.isDelete){
        //         for(Contact c : Trigger.old){
            //             if(c.AccountId != null){
                //                 accountIds.add(c.AccountId);
            //             }
        //         }
    //     }
    
    //     if(accountIds.isEmpty()) return;
    
    //     Map<Id,Integer> countMap = new Map<Id,Integer>();
    
    //     for(AggregateResult ar : [
    //         SELECT AccountId accId, COUNT(Id) cnt
    //         FROM Contact
    //         WHERE AccountId IN :accountIds
    //         GROUP BY AccountId
    //     ]){
        //         countMap.put((Id)ar.get('accId'), (Integer)ar.get('cnt'));
    //     }
    //     List<Account> accountsToUpdate = new List<Account>();
    //     for(Id accId : accountIds){
        
        //         Integer countValue = countMap.containsKey(accId) ? countMap.get(accId) : 0;
        
        //         accountsToUpdate.add(
        //             new Account(
        //                 Id = accId,
        //                 Number_of_Contacts__c = countValue
        //             )
        //         );
    //     }
    
    //     if(!accountsToUpdate.isEmpty()){
        //         update accountsToUpdate;
    //     }
// }