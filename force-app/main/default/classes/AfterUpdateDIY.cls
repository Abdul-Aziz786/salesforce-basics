public class AfterUpdateDIY {
/*
//DIY 1
if(Trigger.isAfter && Trigger.isUpdate) {
            
            Set<Id> updatedIds = new Set<Id>();
            
            for(Id accId : Trigger.newMap.keySet()) {
                Account oldAcc = Trigger.oldMap.get(accId);
                Account newAcc = Trigger.newMap.get(accId);
                
                if(oldAcc.Rating != newAcc.Rating) {
                    updatedIds.add(newAcc.Id);
                } 
            }
            System.debug(updatedIds.size() + ' Items has to be updated');
            
            if(!updatedIds.isEmpty()) {
                List<Opportunity> oppIdsNeedToUpdated = [SELECT Id,Description, AccountId
                                                         From Opportunity 
                                                         WHERE AccountId IN:updatedIds];
                System.debug(oppIdsNeedToUpdated + ' Items has to be updated');
                
                for(Opportunity opp : oppIdsNeedToUpdated) {
                    String updatedRating = Trigger.newMap.get(opp.AccountId).Rating;
                    
                    if(updatedRating == 'Hot')
                        opp.Description = 'High Priority Opportunity';
                    else if(updatedRating == 'Cold') 
                        opp.Description = 'Low Priority Opportunity';
                    else 
                        opp.Description = ''; 
                }
                if(!oppIdsNeedToUpdated.isEmpty()) {
                    update oppIdsNeedToUpdated;
                }
                
            }   
        }
*/
// DIY 2 Rollup In Lookup Relationship
    /*
     trigger ContactCountTrigger on Contact (after insert, after update, after delete, after undelete) {

    Set<Id> accountIds = new Set<Id>();

    if(Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete){
        for(Contact c : Trigger.new){
            if(c.AccountId != null){
                accountIds.add(c.AccountId);
            }
        }
    }

    if(Trigger.isUpdate || Trigger.isDelete){
        for(Contact c : Trigger.old){
            if(c.AccountId != null){
                accountIds.add(c.AccountId);
            }
        }
    }

    if(accountIds.isEmpty()) return;

    Map<Id,Integer> countMap = new Map<Id,Integer>();

    for(AggregateResult ar : [
        SELECT AccountId accId, COUNT(Id) cnt
        FROM Contact
        WHERE AccountId IN :accountIds
        GROUP BY AccountId
    ]){
        countMap.put((Id)ar.get('accId'), (Integer)ar.get('cnt'));
    }

    List<Account> accountsToUpdate = new List<Account>();

    for(Id accId : accountIds){

        Integer countValue = countMap.containsKey(accId) ? countMap.get(accId) : 0;

        accountsToUpdate.add(
            new Account(
                Id = accId,
                Number_of_Contacts__c = countValue
            )
        );
    }

    if(!accountsToUpdate.isEmpty()){
        update accountsToUpdate;
    }
}
*/
    
}