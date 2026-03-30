public class CaseStudyHelper {
    
    // CS - 1
    public static void preventDeleteAccount(List<Account> oldList, Map<Id, Account> oldMap) {
        for (Account acc : oldList) {
            acc.addError('You cannot delete an account.');
        }
    }
    
    // CS - 2
    public static void updateAccountContactCount(List<Contact> newList,
    Map<Id, Contact> newMap,
    List<Contact> oldList,
    Map<Id, Contact> oldMap) {
        Set<Id> accIds = new Set<Id>();
        // INSERT
        if(newList != null && oldList == null) {
            for (Contact con : newList) {
                if(con.AccountId != null)
                    accIds.add(con.AccountId);
            }
        }
        // DELETE
        else if(oldList != null && newList == null) {
            for (Contact con : oldList) {
                if(con.AccountId != null)
                    accIds.add(con.AccountId);
            }
        }
        // UPDATE
        else {
            for (Integer i = 0; i < newList.size(); i++) {
                Contact newCon = newList[i];
                Contact oldCon = oldList[i];
                if(newCon.AccountId != oldCon.AccountId) {
                    if(newCon.AccountId != null) accIds.add(newCon.AccountId);
                    if(oldCon.AccountId != null) accIds.add(oldCon.AccountId);
                }
            }
        }
        
        
        if(accIds.isEmpty()) return;
        List<AggregateResult> aggResults = [SELECT AccountId, COUNT(Id) contactCount 
                                            FROM Contact 
                                            WHERE AccountId IN :accIds 
                                            GROUP BY AccountId];
        
        Map<Id, Integer> accIdWithContactCountMap = new Map<Id, Integer>();
        for (AggregateResult ar : aggResults) {
            accIdWithContactCountMap.put((Id)ar.get('AccountId'), (Integer)ar.get('contactCount'));
        }
        List<Account> accountsToUpdate = new List<Account>();
        for (Id accId : accIds) {
            Account acc = new Account(Id = accId);
            acc.Number_of_Contacts__c = accIdWithContactCountMap.containsKey(accId) ? accIdWithContactCountMap.get(accId) : 0;
            accountsToUpdate.add(acc);
        }
        if (!accountsToUpdate.isEmpty()) {
            try {
                update accountsToUpdate;
            } catch (Exception e) {
                System.debug('Error updating accounts: ' + e.getMessage());
            }
        }
    }
    
    // CS - 3
    public static void createContactsBasedOnNumberOfLocations(List<Account> newList,
    Map<Id, Account> newMap,
    List<Account> oldList,
    Map<Id, Account> oldMap) {
        List<Contact> contactsToInsert = new List<Contact>();
        
        for(Account acc : newList) {
            Decimal newLocationsCount = acc.NumberofLocations__c != null ? acc.NumberofLocations__c  : 0;
            
            Decimal oldLocationsCount = 0;
            if(oldMap != null && oldMap.containsKey(acc.Id)) {
                oldLocationsCount = oldMap.get(acc.Id).NumberofLocations__c != null ? oldMap.get(acc.Id).NumberofLocations__c : 0;
            }
            
            if(newLocationsCount != oldLocationsCount) {
                Decimal diff = newLocationsCount - oldLocationsCount;
                
                for(Integer i = 0; i < diff; i++) {
                    Contact con = new Contact(LastName = 'Location ' + (i+1), AccountId = acc.Id);
                    contactsToInsert.add(con);
                }
            }
            
        }
        
        if (!contactsToInsert.isEmpty()) {
            try {
                insert contactsToInsert;
            } catch (Exception e) {
                System.debug('Error inserting contacts: ' + e.getMessage());
            }
        }
    }
    // CS - 4
    
    public static void updateActiveCustomerProjectCheckbox(List<Customer_Project__c> newList) {
        
        Set<Id> oppIds = new Set<Id>();
        for(Customer_Project__c cp : newList) {
            if(cp.Status__c == 'Active' && cp.OpportunityId__c != null) {
                oppIds.add(cp.OpportunityId__c);
            }
        }
        
        List<Opportunity> oppList = [SELECT Id, Active_Customer_Project__c FROM Opportunity WHERE Id IN :oppIds];
        
        for(Opportunity opp : oppList) {
            opp.Active_Customer_Project__c = true;
        }
        
        if (!oppList.isEmpty()) {
            try {
                update oppList;
            } catch (Exception e) {
                System.debug('Error updating opportunities: ' + e.getMessage());
            }
            
        }
    }
    
    // CS - 5 - a)
    public static void createContactRelationship(List<Contact> newList) {
        List<Contact_Relationship__c> crToInsert = new List<Contact_Relationship__c>();
        
        for(Contact con : newList) {
            if(con.Contact_Relationship__c) {
                Contact_Relationship__c cr = new Contact_Relationship__c(Name = con.LastName + ' - ' + con.OwnerId,
                Contact__c = con.Id);
                crToInsert.add(cr);
            }
        }
        
        if (!crToInsert.isEmpty()) {
            try {
                insert crToInsert;
            } catch (Exception e) {
                System.debug('Error inserting contact relationships: ' + e.getMessage());
            }
        }
    }
    
    // CS - 5 - b)
    public static void updateContactRelationshipOwner(List<Contact_Relationship__c> newList, Map<Id, Contact_Relationship__c> oldMap) {
        List<Contact_Relationship__c> crToUpdate = new List<Contact_Relationship__c>();
        
        Set<Id> ownerIds = new Set<Id>();
        for(Contact_Relationship__c conRS : newList) {
            Contact_Relationship__c oldConRS = oldMap.get(conRS.Id);
            if(conRS.OwnerId != oldConRS.OwnerId) {
                ownerIds.add(conRS.OwnerId);
            }
        }
        
        Map<Id,User> userMap = new Map<Id,User>([
            SELECT Id, FirstName, LastName
            FROM User 
            WHERE Id IN :ownerIds
        ]);
        if(userMap.isEmpty()) {
            return;
        }
        
        
        for(Contact_Relationship__c conRS : newList) {
            Contact_Relationship__c oldConRS = oldMap.get(conRS.Id);
            if(conRS.OwnerId != oldConRS.OwnerId) {
                String name =userMap.get(conRS.OwnerId).FirstName + ' ' + userMap.get(conRS.OwnerId).LastName;
                conRS.Name = name;
                crToUpdate.add(conRS);
            }
        }
        
        if (!crToUpdate.isEmpty()) {
            try {
                update crToUpdate;
            } catch (Exception e) {
                System.debug('Error updating contact relationships: ' + e.getMessage());
            }
        }
    }
    
    // CS - 5 - c)
    public static void deleteContactRelationship(Map<Id, Contact> oldMap) {
        List<Contact_Relationship__c> crToDelete = [
            SELECT Id FROM Contact_Relationship__c WHERE Contact__c IN :oldMap.keySet()
        ];
        
        
        if (!crToDelete.isEmpty()) {
            try {
                delete crToDelete;
            } catch (Exception e) {
                System.debug('Error deleting contact relationships: ' + e.getMessage());
            }
        }
        
    }
    
    // CS - 5 - d)
    public static void undeleteContactRelationship(Map<Id, Contact> newMap) {
        List<Contact_Relationship__c> crToUndelete = [
            SELECT Id FROM Contact_Relationship__c WHERE Contact__c IN :newMap.keySet() ALL ROWS
        ];
        if (!crToUndelete.isEmpty()) {
            try {
                undelete crToUndelete;
            } catch (Exception e) {
                System.debug('Error undeleting contact relationships: ' + e.getMessage());
            }
        }
    }
    
    
    // CS - 6
    public static void  addToAccountTeam(List<Customer__c> newList) {
        List<AccountTeamMember> teamMembersToInsert = new List<AccountTeamMember>();
        
        for(Customer__c cust : newList) {
            if(cust.userId__c != null ) {
                AccountTeamMember atm = new AccountTeamMember(
                    TeamMemberRole = 'Account Manager',
                UserId = cust.userId__c,
                AccountId = cust.AccountId__c);
                teamMembersToInsert.add(atm);
            }
        }
        
        if (!teamMembersToInsert.isEmpty()) {
            try {
                insert teamMembersToInsert;
            } catch (Exception e) {
                System.debug('Error inserting account team members: ' + e.getMessage());
            }
        }
    }
    
    // CS - 7
    
    public static void updateOpportunityWithProductCodes(List<OpportunityLineItem> newList) {
        
        Set<Id> oppIds = new Set<Id>();
        for(OpportunityLineItem oli : newList) {
            if(oli.OpportunityId != null) {
                oppIds.add(oli.OpportunityId);
            }
        }
        
        
        List<Opportunity> oppList = [SELECT Id,Oppr_Lineltems_ProductCode__c ,
                                    (SELECT Id,ProductCode FROM OpportunityLineItems)
                                     FROM Opportunity WHERE Id IN :oppIds];
        
        
        
        List<Opportunity> oppsToUpdate = new List<Opportunity>();
        
        for(Opportunity opp : oppList) {
            Opportunity updateOpp = new Opportunity(Id = opp.Id);
            updateOpp.Oppr_Lineltems_ProductCode__c = '';
            for(OpportunityLineItem oli : opp.OpportunityLineItems) {
                updateOpp.Oppr_Lineltems_ProductCode__c += (oli.ProductCode != null ? oli.ProductCode : ' ') + ',';
            }
            oppsToUpdate.add(updateOpp);
        }
        
        if (!oppsToUpdate.isEmpty()) {
            try {
                update oppsToUpdate;
            } catch (Exception e) {
                System.debug('Error updating opportunities: ' + e.getMessage());
            }
        }
    }
}