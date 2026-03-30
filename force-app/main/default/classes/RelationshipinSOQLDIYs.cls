public class RelationshipinSOQLDIYs {
    public static void demo() {
        //1.
        Set<Id> ids = new Map<Id,Contact>([SELECT Id FROM Contact LIMIT 5]).keySet();
        System.debug('1.--- DIY----');
        System.debug(getContactAndAccounts(ids));
        
        // 2.
        Set<Id> oppIds = new Map<Id,Opportunity>([SELECT Id FROM Opportunity LIMIT 5]).keySet();
        System.debug('2.--- DIY----');
        System.debug(getOpportunity(oppIds));
        
        // 3
        System.debug('3.--- DIY----');
        System.debug(getCaseContactAndAccount('500dL00002qXgj3QAC'));
        
        // 4
        System.debug('4.--- DIY----');
        Set<Id> accIds = new Map<Id,Account>([SELECT Id From Account LIMIT 3]).keySet();
        System.debug(getAccountAndRelatedContacts(accIds));
        
        // 5
        System.debug('5.--- DIY----');
        System.debug(getOpenOpportunities(accIds));
        
        
        
    }
    
    // 1. Write a class method that accepts a List of Contact Ids and returns a Map<Id, String> of Contact Id → Account Name.
    
    public static Map<Id, String>  getContactAndAccounts(Set<Id> items) {
        Map<Id, String> result = new Map<Id, String>();
        List<Contact> arrContacts = [SELECT Id,LastName,Account.Name
                                     FROM Contact
                                     WHERE Id IN :items
                                    ];
        
        for(Contact e: arrContacts) {
            result.put(e.Id, e.Account.Name);
        }
        
        return result;
    }
    
    //2. Create a method that takes a List of Opportunity Ids and returns a Map<Id, String> of Opportunity Id → related Account Industry.
    
    public static Map<Id, String>  getOpportunity(Set<Id> items) {
        Map<Id, String> result = new Map<Id, String>();
        List<Opportunity> arr = [SELECT Id,Account.Industry
                                 FROM Opportunity
                                 WHERE Id IN :items
                                ];
        
        for(Opportunity e: arr) {
            result.put(e.Id, e.Account.Industry);
        }
        
        return result;
    }
    
    //3. Write a method that accepts a Case Id and returns a String in the format "ContactEmail - AccountName".
    
    public static String getCaseContactAndAccount(Id caseId) {
        
        if(caseId == null) {
            return null;
        }
        
        Case cs = [
            SELECT Contact.Email, Account.Name
            FROM Case
            WHERE Id = :caseId
            LIMIT 1
        ];
        
        String email = (cs.Contact != null) ? cs.Contact.Email : '';
        String accName = (cs.Account != null) ? cs.Account.Name : '';
        
        return email + ' - ' + accName;
    }
    
    //4. Write a method that accepts a List of Account Ids and returns a Map<Id, List<Contact>> (Account → Contacts).
    
    public static Map<Id, List<Contact>> getAccountAndRelatedContacts(Set<Id> input) {
        
        Map<Id, List<Contact>> result = new Map<Id, List<Contact>>();
        
        if(input == null || input.isEmpty()) {
            return result;
        }
        /* Method 1 P to C
        List<Account> arr = [
            SELECT Id, (SELECT Id, LastName FROM Contacts)
            FROM Account
            WHERE Id IN :input
        ];
        
        for(Account acc : arr) {
            result.put(acc.Id, acc.Contacts);
        }
        */
        
        for(Contact con : [
            SELECT Id, LastName, AccountId
            FROM Contact
            WHERE AccountId IN :input
        ]) {
            if(!result.containsKey(con.AccountId)) {
                result.put(con.AccountId, new List<Contact>());
            }
            result.get(con.AccountId).add(con);
        }
    
        
        return result;
    }
    
    //5. Write a class method that takes a List of Account Ids and returns a Map<Id, List<Opportunity>> of Account → related Open Opportunities.
    public static Map<Id, List<Opportunity>> getOpenOpportunities(Set<Id> accountIds) {
        
        Map<Id, List<Opportunity>> result = new Map<Id, List<Opportunity>>();
        
        if(accountIds == null || accountIds.isEmpty()) {
            return result;
        }
        
        for(Opportunity opp : [
            SELECT Id, Name, StageName, AccountId
            FROM Opportunity
            WHERE AccountId IN :accountIds
            AND IsClosed = FALSE
        ]) {
            if(!result.containsKey(opp.AccountId)) {
                result.put(opp.AccountId, new List<Opportunity>());
            }
            result.get(opp.AccountId).add(opp);
        }
        
        return result;
    }
}