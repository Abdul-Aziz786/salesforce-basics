public class DIYMapTriggerHelper {
    public static void preventProspectDelete(List<Account> oldList){

        for(Account acc : oldList){
            if(acc.Type == 'Prospect'){
                acc.addError('Prospect accounts cannot be deleted');
            }
        }

    }
    
    
    public static void logDeletion(List<Opportunity> oldList){

        List<Opportunity_Deletion_Log__c> logs = new List<Opportunity_Deletion_Log__c>();

        for(Opportunity opp : oldList){
            
            String descrip =opp.Name + '-' + opp.Amount + ' - ' + System.today();

            logs.add(new Opportunity_Deletion_Log__c(Description__c  = descrip
            ));

        }

        if(!logs.isEmpty()){
            insert logs;
        }

    }
}
    
/*    
   // DIY 1
trigger AccountTrigger on Account (before update) {

    for(Account acc : Trigger.new){

        Account oldAcc = Trigger.oldMap.get(acc.Id);

        if(oldAcc.ParentId != null && acc.ParentId != oldAcc.ParentId){
            acc.addError('Parent Account cannot be changed once assigned.');
        }
    }
}

// DIY 2
trigger OpportunityTrigger on Opportunity (before update) {

    for(Opportunity opp : Trigger.new){

        Opportunity oldOpp = Trigger.oldMap.get(opp.Id);

        if(opp.Amount < oldOpp.Amount){
            opp.addError('Opportunity Amount cannot be decreased.');
        }
    }
}

// DIY 3
trigger OpportunityDateTrigger on Opportunity (before update) {

    for(Opportunity opp : Trigger.new){

        Opportunity oldOpp = Trigger.oldMap.get(opp.Id);

        if(opp.CloseDate < oldOpp.CloseDate){
            opp.addError('Close Date cannot be moved earlier.');
        }
    }
}




// DIY 4
trigger CaseTrigger on Case (before update) {

    for(Case c : Trigger.new){

        Case oldCase = Trigger.oldMap.get(c.Id);

        if(oldCase.Status == 'Closed' && c.Status != 'Closed'){
            c.addError('Closed cases cannot be reopened.');
        }
    }
}

// DIY 5

trigger LeadTrigger on Lead (before update) {

    for(Lead l : Trigger.new){

        Lead oldLead = Trigger.oldMap.get(l.Id);

        if(oldLead.LeadSource != null && String.isBlank(l.LeadSource)){
            l.addError('Lead Source cannot be cleared once set.');
        }
    }
}

*/
    
    

/*    
   // DIY 1
trigger AccountTrigger on Account (before update) {

    for(Account acc : Trigger.new){

        Account oldAcc = Trigger.oldMap.get(acc.Id);

        if(oldAcc.ParentId != null && acc.ParentId != oldAcc.ParentId){
            acc.addError('Parent Account cannot be changed once assigned.');
        }
    }
}

// DIY 2
trigger OpportunityTrigger on Opportunity (before update) {

    for(Opportunity opp : Trigger.new){

        Opportunity oldOpp = Trigger.oldMap.get(opp.Id);

        if(opp.Amount < oldOpp.Amount){
            opp.addError('Opportunity Amount cannot be decreased.');
        }
    }
}

// DIY 3
trigger OpportunityDateTrigger on Opportunity (before update) {

    for(Opportunity opp : Trigger.new){

        Opportunity oldOpp = Trigger.oldMap.get(opp.Id);

        if(opp.CloseDate < oldOpp.CloseDate){
            opp.addError('Close Date cannot be moved earlier.');
        }
    }
}




// DIY 4
trigger CaseTrigger on Case (before update) {

    for(Case c : Trigger.new){

        Case oldCase = Trigger.oldMap.get(c.Id);

        if(oldCase.Status == 'Closed' && c.Status != 'Closed'){
            c.addError('Closed cases cannot be reopened.');
        }
    }
}

// DIY 5

trigger LeadTrigger on Lead (before update) {

    for(Lead l : Trigger.new){

        Lead oldLead = Trigger.oldMap.get(l.Id);

        if(oldLead.LeadSource != null && String.isBlank(l.LeadSource)){
            l.addError('Lead Source cannot be cleared once set.');
        }
    }
}

*/