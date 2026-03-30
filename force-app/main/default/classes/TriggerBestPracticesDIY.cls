public class TriggerBestPracticesDIY {
    
    
    private static Set<Id> processedAccounts = new Set<Id>();
    private static Set<Id> processedContacts = new Set<Id>();
    private static Set<Id> processedEmployees = new Set<Id>();
    
    
    
    // DIY 1
    
    
    public static void handleAccountDeactivation(List<Account> newList, Map<Id,Account> oldMap){
        
        Set<Id> accIds = new Set<Id>();
        
        for(Account acc : newList){
            
            Account oldAcc = oldMap.get(acc.Id);
            
            if(oldAcc.Active__c == 'Yes' && acc.Active__c == 'No'){
                
                if(processedAccounts.contains(acc.Id)) continue;
                
                accIds.add(acc.Id);
                processedAccounts.add(acc.Id);
            }
        }
        
        if(accIds.isEmpty()) return;
        
        List<Opportunity> oppUpdates = new List<Opportunity>();
        
        for(Opportunity opp : [
        SELECT Id, StageName
        FROM Opportunity
        WHERE AccountId IN :accIds
        AND StageName != 'Closed Won']){
            opp.StageName = 'Closed Lost';
            oppUpdates.add(opp);
        }
        
        if(!oppUpdates.isEmpty()){
            try{
                update oppUpdates;
            }catch(Exception e){
                System.debug('Error updating Opportunities: ' + e.getMessage());
            }
        }
    }
    
    
    
    // DIY 2
    public static void syncContactAddress(List<Account> newList, Map<Id,Account> oldMap){
        
        Set<Id> accIds = new Set<Id>();
        
        for(Account acc : newList){
            
            Account oldAcc = oldMap.get(acc.Id);
            
            if(acc.BillingStreet != oldAcc.BillingStreet ||
                acc.BillingCity != oldAcc.BillingCity ||
                acc.BillingState != oldAcc.BillingState ||
                acc.BillingPostalCode != oldAcc.BillingPostalCode ||
            acc.BillingCountry != oldAcc.BillingCountry){
                
                if(processedAccounts.contains(acc.Id)) continue;
                
                accIds.add(acc.Id);
                processedAccounts.add(acc.Id);
            }
        }
        if(accIds.isEmpty()) return;
        
        List<Account> accList = [SELECT Id, BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry,
        (SELECT Id, MailingStreet, MailingCity, MailingState, MailingPostalCode, MailingCountry FROM Contacts)
        FROM Account
        WHERE Id IN :accIds];
        
        List<Contact> contactsToUpdate = new List<Contact>();
        
        for(Account acc : accList){
            
            for(Contact con : acc.Contacts){
                con.MailingStreet = acc.BillingStreet;
                con.MailingCity = acc.BillingCity;
                con.MailingState = acc.BillingState;
                con.MailingPostalCode = acc.BillingPostalCode;
                con.MailingCountry = acc.BillingCountry;
                contactsToUpdate.add(con);
            }
        }
        
        if(!contactsToUpdate.isEmpty()){
            try{
                update contactsToUpdate;
            }catch(Exception e){
                System.debug('Error updating Contacts: ' + e.getMessage());
            }
        }
    }
    
    
    
    // DIY 3
    
    
    //     DIY 3: When the Employee record is inserted, deleted and undeleted then update
    // 'Present Employee Count' on related Account. [Parent-Child SOQL]
    
    public static void updateEmployeeCount(List<Employee__c> newList, Map<Id,Employee__c> oldMap){
        
        Set<Id> accIds = new Set<Id>();
        
        for(Employee__c emp : newList){
            
            Employee__c oldEmp = oldMap.get(emp.Id);
            
            if((oldEmp == null || oldEmp.AccountId__c != emp.AccountId__c) && emp.AccountId__c != null){
                
                if(processedEmployees.contains(emp.Id)) continue;
                
                accIds.add(emp.AccountId__c);
                processedEmployees.add(emp.Id);
            }
        }
        
        if(accIds.isEmpty()) return;
        
        List<Account> accList = [SELECT Id, (SELECT Id FROM Employees__r) FROM Account WHERE Id IN :accIds];
        
        List<Account> accountsToUpdate = new List<Account>();
        
        for(Account acc : accList){
            Integer empCount = acc.Employees__r.size();
            acc.Present_Employee_Count__c = empCount;
            accountsToUpdate.add(acc);
        }
        
        if(!accountsToUpdate.isEmpty()){
            try{
                update accountsToUpdate;
            }catch(Exception e){
                System.debug('Error updating Accounts: ' + e.getMessage());
            }
        }
    }
    
    
    // DIY 4
    
    
    public static void validateClosedLost(List<Opportunity> newList){
        
        for(Opportunity opp : newList){
            
            if(opp.StageName == 'Closed Lost' &&
            String.isBlank(opp.Closed_Lost_Reason__c)){
                
                opp.addError('Please populate Closed Lost Reason');
            }
        }
    }
    
    
    
    // DIY 5
    
    public static void createPremiumCase(List<Contact> newList){
        
        Set<Id> accIds = new Set<Id>();
        
        for(Contact c : newList){
            
            if(c.AccountId != null && !processedContacts.contains(c.Id)){
                accIds.add(c.AccountId);
                processedContacts.add(c.Id);
            }
        }
        
        if(accIds.isEmpty()) return;
        
        Map<Id,Account> accMap = new Map<Id,Account>([
        SELECT Id,OwnerId,Type
        FROM Account
        WHERE Id IN :accIds And Type = 'Premium'
    ]);
        
        System.debug('Premium Accounts: ' + accMap.keySet());
        
        List<Case> casesToInsert = new List<Case>();
        
        for(Contact c : newList){
            
            Account acc = accMap.get(c.AccountId);
            
            if(acc != null){
                casesToInsert.add(new Case(
                    AccountId = acc.Id,
                OwnerId = acc.OwnerId,
                Description = 'Premium Account Contact added: ' + c.LastName,
                ContactId = c.Id,
                Status = 'New',
                Subject = 'Premium Account Contact added'
                    ));
            }
        }
        System.debug('Cases to Insert: ' + casesToInsert);
        if(!casesToInsert.isEmpty()){
            try{
                insert casesToInsert;
            }catch(Exception e){
                System.debug('Error inserting Cases: ' + e.getMessage());
            }
        }
    }
    
}