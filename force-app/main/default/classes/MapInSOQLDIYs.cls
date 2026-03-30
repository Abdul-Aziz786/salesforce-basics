public class MapInSOQLDIYs {
    
    public static void demo() {
        // DIY 1 - Contact → Account Lookup
        System.debug('DIY - 1');
        List< Contact > contacts = [SELECT Id,Name,AccountId FROM Contact]; 
        System.debug('getContactsRelatedAccounts' + getContactsRelatedAccounts(contacts));
        
        
        System.debug('DIY - 2');
        List< Opportunity > opps = [SELECT Id,Name,StageName FROM Opportunity]; 
        System.debug('groupOpportunityByStage' + groupOpportunityByStage(opps));
        
        System.debug('DIY - 3');
        List< Employee__c > emps = [SELECT Id,Full_Name__c ,Net_Salary__c FROM Employee__c]; 
        System.debug('findHighSalaryEmployee' + findHighSalaryEmployee(emps));
        
        System.debug('DIY - 4');
        List< Case > cases = [SELECT Id,CaseNumber,Priority FROM Case]; 
        System.debug('casesMessages' + casesMessages(cases));
        
        System.debug('DIY - 5');
        Map<String, List<String>> deptEmployees = new Map<String, List<String>>();
        
        deptEmployees = addOrUpdateValue(deptEmployees, 'IT', 'John');
        deptEmployees = addOrUpdateValue(deptEmployees, 'IT', 'Mary');
        deptEmployees = addOrUpdateValue(deptEmployees, 'HR', 'David');
        
        System.debug(deptEmployees);
       
    }
    

    // DIY 1 - Contact → Account Lookup
    public static Map<Id,String>  getContactsRelatedAccounts(List<Contact> cons) {
        Map<Id,String> result = new Map<Id,String>();
        
        Set<Id> accountIds = new Set<Id>();
        for (Contact c : cons) {
            if (c.AccountId != null) {
                accountIds.add(c.AccountId);
            }
        }
        
        Map<Id,Account> accMap = new Map<Id,Account>([
            SELECT Id,Name
            FROM Account 
            WHERE Id IN :accountIds 
        ]);
            
        for(Contact contactRec : cons) {
            Account acc =  accMap.get(contactRec.AccountId);
            if(acc != null) {
                result.put(contactRec.Id,acc.Name);
            } else {
                result.put(contactRec.Id,'No Account');
            }
        }
        return result;
    }
    // DIY 2 - Opportunity Grouping by Stage
    public static Map<String,List<Opportunity>> groupOpportunityByStage(List<Opportunity> opps) {
        Map<String,List<Opportunity>> result = new Map<String,List<Opportunity>>();
        for(Opportunity oppRec: opps) {
            if(result.containsKey(oppRec.StageName)) {
                result.get(oppRec.StageName).add(oppRec);
            } else {
                result.put(oppRec.StageName, new List<Opportunity>{oppRec});
            }
        }
        return result;
    }
    // DIY 3 - Employee Salary Comparison
    public static Employee__c findHighSalaryEmployee(List< Employee__c > emps) {
        Employee__c result;
        
        for(Employee__c e: emps) {
            if(result == null || e.Net_Salary__c > result.Net_Salary__c) {
                result = e;
            }
        }
        
        return result;
    }  
    
    // DIY 4 - Case Priority Messages
    public static List<String> casesMessages(List<Case> cases) {
        List<String> result = new List<String>();
        for(Case c : cases) {
            String message;            
            switch on c.Priority {               
                when 'High' {
                    message = 'Immediate attention required for Case: ' + c.CaseNumber;
                }                
                when 'Medium' {
                    message = 'Monitor this Case: ' + c.CaseNumber;
                }              
                when 'Low' {
                    message = 'Low priority Case: ' + c.CaseNumber;
                }                
                when else {
                    message = 'Priority not defined for Case: ' + c.CaseNumber;
                }
            }
            
            result.add(message);
        }
        return  result;
    }
    // DIY 5 - Map Add/Update Pattern
    public static Map<String, List<String>> addOrUpdateValue(
        Map<String, List<String>> inputMap,
        String key,
        String value
    ) {
        if (!inputMap.containsKey(key)) {
            inputMap.put(key, new List<String>());
        }

        inputMap.get(key).add(value);

        return inputMap;
    }
    
}