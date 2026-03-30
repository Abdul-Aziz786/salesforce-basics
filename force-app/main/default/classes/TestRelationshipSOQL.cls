public class TestRelationshipSOQL {
    public static void demo() {
       // getAccountsAndRelatedContacts();
       // getDepartmentandItsRelatedEmpoloyees();
        //getContactsAndAccount();
        getEmployeeAndDepartmet();
    }
    // Parent to Child 1.Account and Its Related Contacts
    public static void getAccountsAndRelatedContacts() {
        List< Account > accList = [SELECT Name, 
                                   (SELECT LastName FROM Contacts ) 
                                   FROM Account];
        
        for(Account acc :accList) {
             System.debug('Account Name: ' + acc.Name);
            
            for(Contact con : acc.Contacts) {
                System.debug('Related Contact - ' + con.LastName);
            }
        }
    } 
    
    // Parent to Child Custom Objects 1.Department and Its Related Empoloyees
    public static void getDepartmentandItsRelatedEmpoloyees() {
        List< Department__c  > deptList = [SELECT Name, 
                                   (SELECT Full_Name__c FROM Employees__r ) 
                                   FROM Department__c ];
        
        for(Department__c dept :deptList) {
             System.debug('Department Name: ' + dept.Name);
            
            for(Employee__c  emp : dept.Employees__r) {
                System.debug('Related Contact - ' + emp.Full_Name__c);
            }
        }
    } 
    
    // Child To Parent - Standard Contact With Account
    public static void getContactsAndAccount() {
        List<Contact> contactsList = [SELECT LastName ,Account.Name,Account.Owner.Name FROM Contact];
        
        for(Contact cont : contactsList) {
            System.debug('Name: ' + cont.LastName);
            System.debug('Account Name: ' + cont.Account.Name);
            System.debug('Owner Name: ' + Account.Owner.Name);
        }
    }
    
    // Child To Parent - Employee and Departmet 
    public static void getEmployeeAndDepartmet () {
        List<Employee__c> lst = [SELECT Name,FirstName__c ,Department__r.DepartmentName__c FROM Employee__c];
        
        for(Employee__c emp : lst) {
            System.debug('Name: ' + emp.FirstName__c);
            System.debug('Dept Name: ' + emp.Department__r.DepartmentName__c);
        }
    }
    
}