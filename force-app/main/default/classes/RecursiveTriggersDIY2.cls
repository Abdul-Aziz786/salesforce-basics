public class RecursiveTriggersDIY2 {
    
    
    public static Set<Id> processedContacts = new Set<Id>();
    public static Set<Id> processedOpportunities = new Set<Id>();
    public static Set<Id> processedAccounts = new Set<Id>();
    public static Set<Id> processedCases = new Set<Id>();
    public static Set<Id> processedProjects = new Set<Id>();
    public static Set<Id> processedApprovals = new Set<Id>();
    
    
    // DIY 1
    
    
    public static void handleContactEmailChange(List<Contact> newList, Map<Id,Contact> oldMap){
        
        Set<Id> accIds = new Set<Id>();
        
        for(Contact c : newList){
            
            if(processedContacts.contains(c.Id)) continue;
            
            Contact oldC = oldMap.get(c.Id);
            
            if(c.Email != oldC.Email && c.AccountId != null){
                
                accIds.add(c.AccountId);
                processedContacts.add(c.Id);
            }
        }
        
        List<Account> updates = new List<Account>();
        
        for(Id accId : accIds){
            
            updates.add(new Account(
                Id = accId,
            Last_Contact_Updated__c = String.valueOf(System.now())
                ));
        }
        
        if(!updates.isEmpty()){
            try {
                update updates;
            } catch(Exception e) {
                System.debug('Account Update Failed - ' + e.getMessage());
            }
        }
    }
    
    
    
    // DIY 2
    
    public static void createFollowUpTask(List<Opportunity> newList, Map<Id,Opportunity> oldMap){
        
        List<Task> tasks = new List<Task>();
        
        for(Opportunity opp : newList){
            
            if(processedOpportunities.contains(opp.Id)) continue;
            
            Opportunity oldOpp = oldMap.get(opp.Id);
            
            if(opp.StageName == 'Perception Analysis'
            && oldOpp.StageName != 'Perception Analysis'){
                
                tasks.add(new Task(
                    Subject = 'Follow-Up',
                WhatId = opp.Id,
                Status = 'Not Started',
                Priority = 'Normal'
                    ));
                
                processedOpportunities.add(opp.Id);
            }
        }
        
        if(!tasks.isEmpty()){
            try{
                insert tasks;
            }catch(Exception e){
                System.debug('Error creating Tasks: ' + e.getMessage());
            }
        }
    }
    
    
    
    // DIY 3
    
    
    public static void createAutoContact(List<Account> newList, Map<Id,Account> oldMap){
        
        List<Contact> contacts = new List<Contact>();
        
        for(Account acc : newList){
            
            if(processedAccounts.contains(acc.Id)) continue;
            
            Account oldAcc = oldMap.get(acc.Id);
            
            if(acc.Create_Contact__c == true && (oldAcc == null || oldAcc.Create_Contact__c == false)){
                
                contacts.add(new Contact(
                    FirstName = acc.Name,
                LastName = 'AutoContact',
                AccountId = acc.Id
                    ));
                
                processedAccounts.add(acc.Id);
            }
        }
        
        if(!contacts.isEmpty()){
            try{
                insert contacts;
            }catch(Exception e){
                System.debug('Error creating Contacts: ' + e.getMessage());
            }
        }
    }
    
    
    
    // DIY 4
    
    public static void createCaseFollowUpTask(List<Case> newList){
        
        List<Task> tasks = new List<Task>();
        
        for(Case c : newList){
            
            if(processedCases.contains(c.Id)) continue;
            
            tasks.add(new Task(
                Subject = 'Case Follow-Up',
            WhatId = c.Id,
            Status = 'Not Started',
            Priority = 'Normal'
                ));
            
            processedCases.add(c.Id);
        }
        
        if(!tasks.isEmpty()){
            try{
                insert tasks;
            }catch(Exception e){
                System.debug('Error creating Tasks: ' + e.getMessage());
            }
        }
    }
    
    
    public static void updateCaseAfterTask(List<Task> newList){
        
        List<Case> updates = new List<Case>();
        
        for(Task t : newList){
            
            if(t.WhatId != null && t.WhatId.getSObjectType() == Case.getSObjectType()){
                
                if(processedCases.contains(t.WhatId)) continue;
                
                updates.add(new Case(
                    Id = t.WhatId,
                Follow_Up_Task_Created__c = true
                    ));
                
                processedCases.add(t.WhatId);
            }
        }
        
        if(!updates.isEmpty()){
            try{
                update updates;
            }catch(Exception e){
                System.debug('Error updating Cases: ' + e.getMessage());
            }
        }
    }
    
    
    
    // DIY 5
    
    public static void createApproval(List<Customer_Project__c> newList){
        
        List<Approval__c> approvals = new List<Approval__c>();
        
        
        
        for(Customer_Project__c p : newList){
            
            if(processedProjects.contains(p.Id)) continue;
            
            if(p.Approval_Created__c == false){
                
                approvals.add(new Approval__c(
                    Customer_ProjectId__c = p.Id
                    ));
                
                processedProjects.add(p.Id);
            }
        }
        System.debug('Approvals to create: ' + approvals.size());
        System.debug('Processed Projects: ' + processedProjects);
        
        if(!approvals.isEmpty()){
            try{
                insert approvals;
            }catch(Exception e){
                System.debug('Error creating Approvals: ' + e.getMessage());
            }
        }
    }
    
    
    public static void updateProjectAfterApproval(List<Approval__c> newList){
        
        List<Customer_Project__c> updates = new List<Customer_Project__c>();
        
        for(Approval__c a : newList){
            
            if(a.Customer_ProjectId__c != null){
                
                if(processedApprovals.contains(a.Customer_ProjectId__c)) continue;
                
                updates.add(new Customer_Project__c(
                    Id = a.Customer_ProjectId__c,
                Approval_Created__c = true
                    ));
                
                processedApprovals.add(a.Customer_ProjectId__c);
            }
        }
        
        System.debug('Projects to update: ' + updates.size());
        System.debug('Processed Approvals: ' + processedApprovals);
        
        if(!updates.isEmpty()){
            try{
                update updates;
            }catch(Exception e){
                System.debug('Error updating Projects: ' + e.getMessage());
            }
        }
        
    }
}