public class RecursiveTriggersHelperDIY {
    
    
    public static Set<Id> processedAccounts = new Set<Id>();
    public static Set<Id> processedOpps = new Set<Id>();
    public static Set<Id> processedProjects = new Set<Id>();
    
    
    // DIY 1
    
    public static void trackRevenueHistory(List<Account> newList, Map<Id,Account> oldMap){
        
        List<Revenue_History__c> historyList = new List<Revenue_History__c>();
        
        for(Account acc : newList){
            
            Account oldAcc = oldMap.get(acc.Id);
            
            if(acc.AnnualRevenue != oldAcc.AnnualRevenue){
                
                if(processedAccounts.contains(acc.Id)) continue;
                
                historyList.add(new Revenue_History__c(
                    Account_Name__c = acc.Name,
                Old_Value__c = String.valueOf(oldAcc.AnnualRevenue),
                New_Value__c = String.valueOf(acc.AnnualRevenue),
                Change_Date__c = DateTime.now()
                    ));
                
                processedAccounts.add(acc.Id);
            }
        }
        
        if(!historyList.isEmpty()){
            try {
                insert historyList;
            } catch (Exception e) {
                System.debug('Error inserting Revenue History: ' + e.getMessage());
            }
        }
    }
    
    
    
    // DIY 2
    
    public static void updateOpportunityDescByOppLineItemCount(List<OpportunityLineItem> newList,
    List<OpportunityLineItem> oldList,
    Map<Id,OpportunityLineItem> newMap,
    Map<Id,OpportunityLineItem> oldMap)
    {
        Set<Id> oppIds =  new Set<Id>();
        if(newList !=null) {
            for(OpportunityLineItem oli: newList) {
                System.debug('Line Id - ' +oli.Id + ' - Opp Id - ' + oli.opportunityId);
                
                if(!processedOpps.contains(oli.opportunityId)) {
                    oppIds.add(oli.opportunityId);
                    processedOpps.add(oli.opportunityId);
                }
                
            }
        }
        if(oldList != null) {
            for(OpportunityLineItem oli: oldList) {
                System.debug('Line Id - ' +oli.Id + ' - Opp Id - ' + oli.opportunityId);
                if(!processedOpps.contains(oli.opportunityId)) {
                    oppIds.add(oli.opportunityId);
                    processedOpps.add(oli.opportunityId);
                }
                
            }
        }
        
        if(oppIds.isEmpty()) return;
        List<Opportunity> oppsToUpdate = new List<Opportunity>();
        List<AggregateResult> groupedResults = [SELECT OpportunityId, COUNT(Id) itemCount
                                        FROM OpportunityLineItem
                                        WHERE OpportunityId IN :oppIds
                                        GROUP BY OpportunityId];
        
        for(AggregateResult ar : groupedResults) {
            Id oppId = (Id) ar.get('OpportunityId');
            Integer itemCount = (Integer) ar.get('itemCount');
            Opportunity opp = new Opportunity(Id = oppId);
            opp.Description = itemCount > 100 ? 'High' : 'Low';
            oppsToUpdate.add(opp);
            
        }
        if(!oppsToUpdate.isEmpty()) {
            try {
                update oppsToUpdate;
            } catch(Exception e) {
                System.debug('Error Updating Opportunities - ' +e.getMessage());
            }
        }
    }
    
    // DIY 3
    
    public static void updateAccountStatus(List<Opportunity> newList, Map<Id,Opportunity> oldMap){
        
        Map<Id,String> accStatus = new Map<Id,String>();
        
        for(Opportunity opp : newList){
            
            Opportunity oldOpp = oldMap.get(opp.Id);
            
            if(opp.StageName != oldOpp.StageName && opp.AccountId != null){
                
                if(opp.StageName == 'Closed Won'){
                    accStatus.put(opp.AccountId,'Active');
                }
                else if(opp.StageName == 'Closed Lost'){
                    accStatus.put(opp.AccountId,'Inactive');
                }
            }
        }
        
        List<Account> updates = new List<Account>();
        
        for(Id accId : accStatus.keySet()){
            
            if(processedAccounts.contains(accId)) continue;
            
            updates.add(new Account(
                Id = accId,
            Status__c = accStatus.get(accId)
                ));
            
            processedAccounts.add(accId);
        }
        
        if(!updates.isEmpty()){
            try {
                update updates;
            } catch(Exception e) {
                System.debug('Error Updating Accounts - ' +e.getMessage());
            }
        }
    }
    
    
    
    // DIY 4
    
    public static void updateCompletedProjects(List<Customer_Project__c> newList, Map<Id,Customer_Project__c> oldMap){
        
        Set<Id> accIds = new Set<Id>();
        
        for(Customer_Project__c p : newList){
            
            Customer_Project__c oldP = oldMap.get(p.Id);
            
            if(p.Status__c == 'Completed' && oldP.Status__c != 'Completed'){
                accIds.add(p.AccountId__c);
            }
        }
        
        if(accIds.isEmpty()) return;
        
        Map<Id,Integer> countMap = new Map<Id,Integer>();
        
        for(AggregateResult ar : [
            SELECT AccountId__c accId, COUNT(Id) total
            FROM Customer_Project__c
            WHERE Status__c='Completed'
            AND AccountId__c IN :accIds
            GROUP BY AccountId__c
        ]){
            countMap.put((Id)ar.get('accId'),(Integer)ar.get('total'));
        }
        
        List<Account> updates = new List<Account>();
        
        for(Id accId : countMap.keySet()){
            
            if(processedAccounts.contains(accId)) continue;
            
            updates.add(new Account(
                Id = accId,
            Completed_Projects__c = countMap.get(accId)
                ));
            
            processedAccounts.add(accId);
        }
        
        if(!updates.isEmpty()){
            try {
                update updates;
            } catch (Exception e) {
                System.debug('Error Updating Accounts - ' + e.getMessage());
            }
        }
    }
    
    
    
    // DIY 5
    
    public static void updateLowestOpportunity(List<Opportunity> newList, List<Opportunity> oldList, Map<Id,Opportunity> oldMap){
        
        
        Set<Id> accIds = new Set<Id>();
        
        if(newList != null && oldMap == null){
            for(Opportunity opp : newList){
                Opportunity oldOpp = oldMap.get(opp.Id);
                if(opp.Amount != oldOpp.Amount && opp.AccountId != null){
                    if(processedAccounts.contains(opp.AccountId)) continue;
                    accIds.add(opp.AccountId);
                }
            }
        } else if (oldList != null && newList == null) {
            for(Opportunity opp : oldList){
                Opportunity newOpp = oldMap.get(opp.Id);
                if(opp.Amount != newOpp.Amount && opp.AccountId != null){
                    if(processedAccounts.contains(opp.AccountId)) continue;
                    accIds.add(opp.AccountId);
                }
            }
        } else {
            for(Opportunity opp : newList){
                Opportunity oldOpp = oldMap.get(opp.Id);
                if(opp.Amount != oldOpp.Amount && opp.AccountId != null){
                    if(processedAccounts.contains(opp.AccountId)) continue;
                    accIds.add(opp.AccountId);
                }
            }
        }
        processedAccounts.addAll(accIds);
        
        if(accIds.isEmpty()) return;
        
        List<Account> updates = new List<Account>();
        
        
        for(AggregateResult ar : [
            SELECT Min(Amount) minAmount,AccountId,Name oppName
            FROM Opportunity
            WHERE AccountId IN :accIds
            GROUP BY AccountId,Name
        ]){
            
            Id accId = (Id)ar.get('AccountId');
            Decimal minAmount = (Decimal)ar.get('minAmount');
            String oppName = (String)ar.get('oppName');
            
            
            updates.add(new Account(
                Id = accId,
            Lowest_Opportunity_Name__c = oppName + ' - ' + String.valueOf(minAmount)
                ));
        }
        if(!updates.isEmpty()){
            try {
                update updates;
            } catch (Exception e) {
                System.debug('Error Updating Accounts - ' + e.getMessage());
            }
        }
    }
    
}