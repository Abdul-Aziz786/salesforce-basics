public class AfterInsertDIY {
/*
 // DIY 1
trigger OpportunityTrigger on Opportunity (after insert) {

    for(Opportunity opp : Trigger.new){
        if(opp.Amount != null && opp.Amount > 1000000){
            System.debug('High value opportunity created: ' + opp.Name);
        }
    }

}

// DIY 2
trigger OpportunityTaskTrigger on Opportunity (after insert) {

    List<Task> tasks = new List<Task>();

    for(Opportunity opp : Trigger.new){

        if(opp.StageName == 'Closed Won'){

            Task t = new Task();
            t.Subject = 'Follow up Closed Won Opportunity';
            t.WhatId = opp.Id;
            t.OwnerId = opp.OwnerId;
            t.Status = 'Not Started';
            t.Priority = 'Normal';

            tasks.add(t);
        }
    }

    if(!tasks.isEmpty()){
        insert tasks;
    }
}

// DIY 3

trigger ContactTrigger on Contact (after insert) {

    Set<Id> accountIds = new Set<Id>();

    for(Contact c : Trigger.new){
        if(c.AccountId != null){
            accountIds.add(c.AccountId);
        }
    }

    List<Account> accountsToUpdate = [
        SELECT Id, Has_Contacts__c
        FROM Account
        WHERE Id IN :accountIds
    ];

    for(Account acc : accountsToUpdate){
        acc.Has_Contacts__c = true;
    }

    if(!accountsToUpdate.isEmpty()){
        update accountsToUpdate;
    }
}

// DIY 4

trigger LeadTrigger on Lead (after insert) {

    List<Task> tasks = new List<Task>();

    for(Lead l : Trigger.new){

        Task t = new Task();
        t.Subject = 'Contact new Lead';
        t.OwnerId = l.OwnerId;
        t.WhoId = l.Id;
        t.Status = 'New';
        t.Priority = 'High';

        tasks.add(t);
    }

    if(!tasks.isEmpty()){
        insert tasks;
    }
}

// DIY 5
trigger OpportunityAccountUpdate on Opportunity (after insert) {

    Map<Id, Decimal> accountAmountMap = new Map<Id, Decimal>();

    for(Opportunity opp : Trigger.new){
        if(opp.AccountId != null){
            accountAmountMap.put(opp.AccountId, opp.Amount);
        }
    }

    List<Account> accountsToUpdate = [
        SELECT Id, Last_Opportunity_Amount__c
        FROM Account
        WHERE Id IN :accountAmountMap.keySet()
    ];

    for(Account acc : accountsToUpdate){
        acc.Last_Opportunity_Amount__c = accountAmountMap.get(acc.Id);
    }

    if(!accountsToUpdate.isEmpty()){
        update accountsToUpdate;
    }
}


 */
}