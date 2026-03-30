public  class TriggerRollupWithAggregateDIY {
    // DIY - Trigger Rollup using Aggregate
    // DIY 1:
    
    public static void rollupOpportunityAmount(List<Opportunity> newList,
    Map<Id, Opportunity> newMap,
    List<Opportunity> oldList,
    Map<Id, Opportunity> oldMap
    ) {
        Set<Id> accountIds = new Set<Id>();
        if(newList != null && oldList == null)  {
            for (Opportunity opp : newList) {
                if (opp.AccountId != null) {
                    accountIds.add(opp.AccountId);
                }
            }
        } else if(oldList != null && newList == null){
            for (Opportunity opp : oldList) {
                if (opp.AccountId != null) {
                    accountIds.add(opp.AccountId);
                }
            }
        } else {
            for (Opportunity opp : newList) {
                Opportunity oldOpp = oldMap.get(opp.Id);
                if(oldOpp.AccountId != opp.AccountId || oldOpp.Amount != opp.Amount) {
                    
                    if (opp.AccountId != null) {
                        accountIds.add(opp.AccountId);
                    }
                    if (oldOpp.AccountId != null) {
                        accountIds.add(oldOpp.AccountId);
                    }
                }
            }
        }
        
        
        List<Account> accountsToUpdate = new List<Account>();
        for (AggregateResult ar : [
                                    SELECT AccountId, 
                                    SUM(Amount) totalAmount 
                                    FROM Opportunity 
                                    WHERE AccountId IN :accountIds 
                                    GROUP BY AccountId]) {
            Id accountId = (Id) ar.get('AccountId');
            Decimal totalAmount = (Decimal) ar.get('totalAmount');
            accountsToUpdate.add(new Account(Id = accountId, Total_Opportunity_Amount__c = totalAmount));
        }
        
        if (!accountsToUpdate.isEmpty()) {
            try {
                update accountsToUpdate;
            } catch (Exception e) {
                System.debug('Error updating accounts: ' + e.getMessage());
            }
        }
    }
    
    // DIY 2: Store the largest Opportunity Amount per Account in Max_Opportunity__c field in Account.
    public static void rollupMaxOpportunityAmount(List<Opportunity> newList,
    Map<Id, Opportunity> newMap,
    List<Opportunity> oldList,
    Map<Id, Opportunity> oldMap
    ) {
        Set<Id> accountIds = new Set<Id>();
        if(newList != null && oldList == null)  {
            for (Opportunity opp : newList) {
                if (opp.AccountId != null) {
                    accountIds.add(opp.AccountId);
                }
            }
        } else if(oldList != null && newList == null){
            for (Opportunity opp : oldList) {
                if (opp.AccountId != null) {
                    accountIds.add(opp.AccountId);
                }
            }
        } else {
            for (Opportunity opp : newList) {
                Opportunity oldOpp = oldMap.get(opp.Id);
                if(oldOpp.AccountId != opp.AccountId || oldOpp.Amount != opp.Amount) {
                    
                    if (opp.AccountId != null) {
                        accountIds.add(opp.AccountId);
                    }
                    if (oldOpp.AccountId != null) {
                        accountIds.add(oldOpp.AccountId);
                    }
                }
            }
        }
        
        List<Account> accountsToUpdate = new List<Account>();
        for (AggregateResult ar : [
                                    SELECT AccountId, 
                                    MAX(Amount) maxAmount 
                                    FROM Opportunity 
                                    WHERE AccountId IN :accountIds 
                                    GROUP BY AccountId]) {
            Id accountId = (Id) ar.get('AccountId');
            Decimal maxAmount = (Decimal) ar.get('maxAmount');
            accountsToUpdate.add(new Account(Id = accountId, Max_Opportunity__c = maxAmount));
        }
        
        if (!accountsToUpdate.isEmpty()) {
            try {
                update accountsToUpdate;
            } catch (Exception e) {
                System.debug('Error updating accounts: ' + e.getMessage());
            }
        }
    }
    
    
    // DIY 3:
    
    public static void rollupTotalTaskOnProject(List<Task> newList,
    Map<Id, Task> newMap,
    List<Task> oldList,
    Map<Id, Task> oldMap
    ) {
        Set<Id> projectIds = new Set<Id>();
        if(newList != null && oldList == null)  {
            for (Task t : newList) {
                if (t.WhatId != null) {
                    projectIds.add(t.WhatId);
                }
            }
        } else if(oldList != null && newList == null){
            for (Task t : oldList) {
                if (t.WhatId != null) {
                    projectIds.add(t.WhatId);
                }
            }
        } else {
            for (Task t : newList) {
                Task oldTask = oldMap.get(t.Id);
                if(oldTask.WhatId != t.WhatId) {
                    
                    if (t.WhatId != null) {
                        projectIds.add(t.WhatId);
                    }
                    if (oldTask.WhatId != null) {
                        projectIds.add(oldTask.WhatId);
                    }
                }
            }
        }
        
        List<Customer_Project__c> projectsToUpdate = new List<Customer_Project__c>();
        for (AggregateResult ar : [
                                    SELECT WhatId,
                                    COUNT(Id) totalTasks 
                                    FROM Task 
                                    WHERE WhatId IN :projectIds 
                                    GROUP BY WhatId]) {
            Id projectId = (Id) ar.get('WhatId');
            Integer totalTasks = (Integer) ar.get('totalTasks');
            projectsToUpdate.add(new Customer_Project__c(Id = projectId, Total_Tasks__c = totalTasks));
        }
        
        if (!projectsToUpdate.isEmpty()) {
            try {
                update projectsToUpdate;
            } catch (Exception e) {
                System.debug('Error updating projects: ' + e.getMessage());
            }
        }
    }
    
    
    
    // DIY 4: Update Active_Opportunity_Count__c in Account with the count of Opportunities that are not Closed Won/Lost.
    public static void rollupActiveOpportunityCount(List<Opportunity> newList,
    Map<Id, Opportunity> newMap,
    List<Opportunity> oldList,
    Map<Id, Opportunity> oldMap
    ) {
        Set<Id> accountIds = new Set<Id>();
        if(newList != null && oldList == null)  {
            for (Opportunity opp : newList) {
                if (opp.AccountId != null) {
                    accountIds.add(opp.AccountId);
                }
            }
        } else if(oldList != null && newList == null){
            for (Opportunity opp : oldList) {
                if (opp.AccountId != null) {
                    accountIds.add(opp.AccountId);
                }
            }
        } else {
            for (Opportunity opp : newList) {
                Opportunity oldOpp = oldMap.get(opp.Id);
                if(oldOpp.AccountId != opp.AccountId || oldOpp.StageName != opp.StageName) {
                    
                    if (opp.AccountId != null) {
                        accountIds.add(opp.AccountId);
                    }
                    if (oldOpp.AccountId != null) {
                        accountIds.add(oldOpp.AccountId);
                    }
                }
            }
        }
        
        List<Account> accountsToUpdate = new List<Account>();
        for (AggregateResult ar : [
                                    SELECT AccountId, 
                                    COUNT(Id) totalOpportunities 
                                    FROM Opportunity 
                                    WHERE AccountId IN :accountIds 
                                    AND StageName != 'Closed Won' 
                                    AND StageName != 'Closed Lost' 
                                    GROUP BY AccountId]) {
            Id accountId = (Id) ar.get('AccountId');
            Integer totalOpportunities = (Integer) ar.get('totalOpportunities');
            accountsToUpdate.add(new Account(Id = accountId, Active_Opportunity_Count__c = totalOpportunities));
        }
        
        if (!accountsToUpdate.isEmpty()) {
            try {
                update accountsToUpdate;
            } catch (Exception e) {
                System.debug('Error updating accounts: ' + e.getMessage());
            }
        }
    }
    
    // DIY 5: When Employee records change, update Department's average salary (Average_Salary__c) field.
    public static void rollupAverageSalaryOnDepartment(List<Employee__c> newList,
    Map<Id, Employee__c> newMap,
    List<Employee__c> oldList,
    Map<Id, Employee__c> oldMap
    ) {
        Set<Id> departmentIds = new Set<Id>();
        if(newList != null && oldList == null)  {
            for (Employee__c emp : newList) {
                if (emp.Department__c != null) {
                    departmentIds.add(emp.Department__c);
                }
            }
        } else if(oldList != null && newList == null){
            for (Employee__c emp : oldList) {
                if (emp.Department__c != null) {
                    departmentIds.add(emp.Department__c);
                }
            }
        } else {
            for (Employee__c emp : newList) {
                Employee__c oldEmp = oldMap.get(emp.Id);
                if(oldEmp.Department__c != emp.Department__c || oldEmp.Salary__c != emp.Salary__c) {
                    if (emp.Department__c != null) {
                        departmentIds.add(emp.Department__c);
                    }
                    if (oldEmp.Department__c != null) {
                        departmentIds.add(oldEmp.Department__c);
                    }
                }
            }
        }
        
        List<Department__c> departmentsToUpdate = new List<Department__c>();
        for (AggregateResult ar : [
                                    SELECT Department__c, 
                                    AVG(Salary__c) averageSalary 
                                    FROM Employee__c 
                                    WHERE Department__c IN :departmentIds 
                                    GROUP BY Department__c]) {
            Id departmentId = (Id) ar.get('Department__c');
            Decimal averageSalary = (Decimal) ar.get('averageSalary');
            departmentsToUpdate.add(new Department__c(Id = departmentId, Average_Salary__c = averageSalary));
        }
        
        if (!departmentsToUpdate.isEmpty()) {
            try {
                update departmentsToUpdate;
            } catch (Exception e) {
                System.debug('Error updating departments: ' + e.getMessage());
            }
        }
    }
    
}