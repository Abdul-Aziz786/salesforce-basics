public with sharing class DMLDIY2 {
    
    
    public static void demo() {
        // Step 1: Create Opportunities for Accounts
        Map<Id, Account> accountMap = new Map<Id, Account>([SELECT Id, Name, BillingState, Customer_Tier__c FROM Account Order By CreatedDate DESC LIMIT 7]);
        List<Opportunity> createdOpportunities = createOpportunitiesForAccounts(accountMap);
        
        // Step 2: Create Tasks for Opportunities
        Map<Id, Opportunity> opportunityMap = new Map<Id, Opportunity>();
        for (Opportunity opp : createdOpportunities) {
            opportunityMap.put(opp.Id, opp);
        }
        List<Task> createdTasks = createTasksForOpportunities(opportunityMap);
        
        // Step 3: Update Accounts Based on Opportunities
        List<Account> updatedAccounts = updateAccountsBasedOnOpportunities(opportunityMap);
        
        // Step 4: Child→Parent Aggregate Update
        Map<Id, Account> accountsWithAggregates = updateAccountsWithOpportunityAggregates(createdOpportunities);
        
        // Step 5: Parent→Child Selective Create (avoid duplicates)
        List<Task> tasksForAccounts = createTasksForAccountsWithDuplicateCheck(accountMap);
        
        // Step 6: Custom Object Follow-up for Opted-in Accounts (no duplicates)
        List<Lead_Followup__c> leadFollowups = createLeadFollowupsForOptedInAccounts(createdOpportunities);
    }
    
    // 1. Create Opportunities for Accounts
    public static List<Opportunity> createOpportunitiesForAccounts(Map<Id, Account> accountMap) {
        List<Opportunity> opportunitiesToInsert = new List<Opportunity>();
        
        for (Account acc : accountMap.values()) {
            Opportunity opp = new Opportunity();
            opp.Name = 'New Opportunity for ' + acc.Name;
            opp.AccountId = acc.Id;
            opp.StageName = 'Prospecting';
            opp.Amount = 10000 + Math.random() * 10000;
            opp.CloseDate = Date.today().addDays(30);
            opportunitiesToInsert.add(opp);
        }
        
        if (!opportunitiesToInsert.isEmpty()) {
            insert opportunitiesToInsert;
        }
        
        return opportunitiesToInsert;
    }
    
    // 2. Create Tasks for Opportunities
    
    public static List<Task> createTasksForOpportunities(Map<Id, Opportunity> opportunityMap) {
        List<Task> tasksToInsert = new List<Task>();
        
        for (Opportunity opp : opportunityMap.values()) {
            Task task = new Task();
            task.Subject = 'Follow up on ' + opp.Name;
            task.WhatId = opp.Id;
            task.Status = 'Not Started';
            task.Priority = 'Normal';
            tasksToInsert.add(task);
        }
        
        if (!tasksToInsert.isEmpty()) {
            insert tasksToInsert;
        }
        
        return tasksToInsert;
    }
    
    // 3. Update Accounts Based on Opportunities
    public static List<Account> updateAccountsBasedOnOpportunities(Map<Id, Opportunity> opportunityMap) {
        Set<Id> accountIds = new Set<Id>();
        
        for (Opportunity opp : opportunityMap.values()) {
            if (opp.AccountId != null) {
                accountIds.add(opp.AccountId);
            }
        }
        List<Account> accountsToUpdate = [SELECT Id, BillingState, Type 
                                          FROM Account 
                                          WHERE Id IN :accountIds AND BillingState = 'California'];
        
        for (Account acc : accountsToUpdate) {
            acc.Type = 'Prospect';
            acc.Customer_Tier__c = 'Gold';
        }
        
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
        
        return accountsToUpdate;
    }
    
    // 4. Child→Parent Aggregate Update
    // Method 1: Looping in Apex
    public static Map<Id, Account> updateAccountsWithOpportunityAggregates(List<Opportunity> opportunities) {
        Map<Id, Decimal> accountIdToTotalAmount = new Map<Id, Decimal>();
        Map<Id, Date> accountIdToLatestCloseDate = new Map<Id, Date>();
        
        for (Opportunity opp : opportunities) {
            if (opp.AccountId != null) {
                if (!accountIdToTotalAmount.containsKey(opp.AccountId)) {
                    accountIdToTotalAmount.put(opp.AccountId, 0);
                    accountIdToLatestCloseDate.put(opp.AccountId, Date.newInstance(1900, 1, 1));
                }
                accountIdToTotalAmount.put(opp.AccountId, accountIdToTotalAmount.get(opp.AccountId) + opp.Amount);
                if (opp.CloseDate > accountIdToLatestCloseDate.get(opp.AccountId)) {
                    accountIdToLatestCloseDate.put(opp.AccountId, opp.CloseDate);
                }
            }
        }
        
        List<Account> accountsToUpdate = new List<Account>();
        
        for (Id accId : accountIdToTotalAmount.keySet()) {
            Account acc = new Account(  Id = accId);
            
            acc.Total_Opportunity_Amount__c = accountIdToTotalAmount.get(acc.Id);
            acc.Latest_Close_Date__c = accountIdToLatestCloseDate.get(acc.Id);
            accountsToUpdate.add(acc);
        }
        
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
        
        Map<Id, Account> updatedAccountsMap = new Map<Id, Account>();
        for (Account acc : accountsToUpdate) {
            updatedAccountsMap.put(acc.Id, acc);
        }
        
        return updatedAccountsMap;
    }
    
    // Method 2: Aggregate SOQL
    public static Map<Id, Account> updateAccountAggregatesUsingAggregateSOQL(List<Opportunity> oppList) {
        
        Map<Id, Account> result = new Map<Id, Account>();
        
        if(oppList == null || oppList.isEmpty()) {
            return result;
        }
        
        Set<Id> oppIds = new Set<Id>();
        for(Opportunity opp : oppList) {
            if(opp.Id != null && opp.AccountId != null) {
                oppIds.add(opp.Id);
            }
        }
        
        if(oppIds.isEmpty()) {
            return result;
        }
        
        for(AggregateResult ar : [
            SELECT AccountId accId,
                   SUM(Amount) totalAmt,
                   MAX(CloseDate) maxDate
            FROM Opportunity
            WHERE Id IN :oppIds
            GROUP BY AccountId
        ]) {
            
            Id accId = (Id) ar.get('accId');
            Decimal total = (Decimal) ar.get('totalAmt');
            Date maxDate = (Date) ar.get('maxDate');
            
            Account acc = new Account(
                Id = accId,
            Total_Opportunity_Amount__c = total,
            Latest_Close_Date__c = maxDate
                );
            
            result.put(accId, acc);
        }
        
        if(!result.isEmpty()) {
            update result.values();
        }
        
        return result;
    }
    
    // 5. Parent→Child Selective Create (avoid duplicates)
    public static List<Task> createTasksForAccountsWithDuplicateCheck(Map<Id, Account> accountMap) {
        List<Task> tasksToInsert = new List<Task>();
        Set<Id> accountIds = new Set<Id>();
        
        for (Account acc : accountMap.values()) {
            if (acc.BillingState == 'California' || acc.Customer_Tier__c == 'Gold') {
                accountIds.add(acc.Id);
            }
        }
        
        if (!accountIds.isEmpty()) {
            Map<Id, Task> existingTasksMap = new Map<Id, Task>();
            for (Task t : [SELECT Id, WhatId FROM Task WHERE WhatId IN :accountIds]) {
                existingTasksMap.put(t.WhatId, t);
            }
            
            for (Id accId : accountIds) {
                if (!existingTasksMap.containsKey(accId)) {
                    Task task = new Task();
                    task.Subject = 'Follow up with ' + accountMap.get(accId).Name;
                    task.WhatId = accId;
                    task.Status = 'Not Started';
                    task.Priority = 'Normal';
                    tasksToInsert.add(task);
                }
            }
            
            if (!tasksToInsert.isEmpty()) {
                insert tasksToInsert;
            }
        }
        
        return tasksToInsert;
    }
    
    // 6. Custom Object Follow-up for Opted-in Accounts (no duplicates)
    
    public static List<Lead_Followup__c> createLeadFollowupsForOptedInAccounts(List<Opportunity> oppList) {
        List<Lead_Followup__c> followupsToInsert = new List<Lead_Followup__c>();
        Set<Id> accountIds = new Set<Id>();
        Set<Id> opportunityIds = new Set<Id>();
        
        for (Opportunity opp : oppList) {
            if (opp.AccountId != null) {
                accountIds.add(opp.AccountId);
                opportunityIds.add(opp.Id);
            }
        }
        
        if (!accountIds.isEmpty()) {
            Map<Id, Account> accountsMap = new Map<Id, Account>([SELECT Id, Name FROM Account WHERE Id IN :accountIds AND Marketing_Opt_In__c = true]);
            Set<Id> optedInAccountIds = accountsMap.keySet();
            
            Set<String> existingFollowupKeys = new Set<String>();
            for (Lead_Followup__c lf : [SELECT Id, OpportunityId__c FROM Lead_Followup__c WHERE OpportunityId__c IN :opportunityIds]) {
                existingFollowupKeys.add(lf.OpportunityId__c);
            }
            
            for (Opportunity opp : oppList) {
                if (optedInAccountIds.contains(opp.AccountId) && !existingFollowupKeys.contains(opp.Id)) {
                    Lead_Followup__c followup = new Lead_Followup__c();
                    followup.OpportunityId__c = opp.Id;
                    followup.Name__c = 'Follow up on ' + opp.Name;
                    followupsToInsert.add(followup);
                }
            }
            
            if (!followupsToInsert.isEmpty()) {
                insert followupsToInsert;
            }
        }
        
        return followupsToInsert;
    }
    
    
}