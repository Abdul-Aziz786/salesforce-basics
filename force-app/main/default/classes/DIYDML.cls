public class DIYDML {
    public static void demoDepartment() {
        Department dept = new Department();
        dept.insertDepartment('HR');
        dept.insertDepartment('Finance');
        dept.insertDepartment('HR');
        dept.insertDepartment('IT');
        dept.insertDepartment('Sales');
        dept.updateDepartment('Finance', 'Financial Services');
        dept.deleteDepartment('IT');
        dept.deleteDepartment('Marketing');
        dept.getEmployeeCountByDeptName('HR');
        List<Department__c> searchResults = dept.searchDepartments('S');
        System.debug('Search Results: ' + searchResults);
        dept.findDepartmentWithLeastEmployees();
    }
    
    public static void demoEmployee() {
        Employee emp = new Employee();
        emp.insertEmployee('John Doe', 'Developer', 75000, 'HR');
        emp.insertEmployee('Jane Smith', 'Head Department', 90000, 'Sales');
        emp.insertEmployee('John Doe', 'Tester', 60000, 'HR');
        emp.insertEmployee('Alice Johnson', null, 50000, 'Sales');
        emp.insertEmployee('Bob Brown', 'Developer', 85000, 'Finance');
        emp.updateEmployee('John Doe', 'Senior Developer', 80000, 'HR');
        emp.deleteEmployee('Alice Johnson');
        emp.deleteEmployee('Charlie Davis');
        emp.findMaxSalaryByPosition('Senior Developer');
        emp.displayPositionSalaryInfo();
        List<Employee__c> searchResults = emp.searchEmployees('Jane');
        System.debug('Search Results: ' + searchResults);
    }
    
    public class Department {
        public  void insertDepartment(String name) {
            Department__c dept = new Department__c(DepartmentName__c = name,Location__c = 'Chennai');
            if([SELECT COUNT() FROM Department__c WHERE DepartmentName__c = :name] > 0) {
                System.debug('Department with this name already exists. - '+name);
                return;
            }
            insert dept;
            
            System.debug('Department inserted successfully. Id: ' + dept);
        }
        
        public  void updateDepartment(String name, String newName) {
            try {
                List<Department__c> dept = [SELECT Id FROM Department__c WHERE DepartmentName__c = :name LIMIT 1];
                if(dept.isEmpty()) {
                    System.debug('No department found with this name. - ' + name);
                    return;
                }
                Department__c d= dept[0];
                d.DepartmentName__c = newName;
                update d;
                System.debug('Department updated successfully. Id: ' + dept);
            }
            catch (QueryException e) {
                System.debug('No department found with this name. - ' + name);
            } catch (DmlException e) {
                System.debug('Duplicate department name not allowed.');
            }
        }
        
        public  void deleteDepartment(String name) {
            List<Department__c> dept = [SELECT Id FROM Department__c WHERE DepartmentName__c = :name LIMIT 1];
            if(dept.isEmpty()) {
                System.debug('No department found with this name. - ' + name);
                return;
            }
            delete dept;
            System.debug('Department deleted successfully. Id: ' + dept);
        }
        
        public Integer getEmployeeCountByDeptName(String deptName) {
            
            List<AggregateResult> result = [ SELECT COUNT(Id) empCount
                                       FROM Employee__c
                                       WHERE Department__r.DepartmentName__c = :deptName];
            
            if(result.isEmpty()) return 0;
            
            return (Integer) result[0].get('empCount');
        }
        
        public  List<Department__c> searchDepartments(String searchTerm) {
            searchTerm = '%' + searchTerm + '%';
            List<Department__c> depts = [SELECT Id, DepartmentName__c, Location__c 
                                         FROM Department__c 
                                         WHERE DepartmentName__c LIKE :searchTerm];
            if(depts.isEmpty()) {
                System.debug('No departments found matching the search term. - ' + searchTerm);
                return new List<Department__c>();
            }
            return depts;
        }
        
        public  void findDepartmentWithLeastEmployees() {
            List<AggregateResult> result = [SELECT Department__r.DepartmentName__c deptName, COUNT(Id) empCount
                                       FROM Employee__c
                                       GROUP BY Department__r.DepartmentName__c
                                       ORDER BY COUNT(Id) ASC
                                       LIMIT 1];
            
            if(result.isEmpty()) {
                System.debug('No departments found.');
                return;
            }
            
            String deptName = (String) result[0].get('deptName');
            Integer empCount = (Integer) result[0].get('empCount');
            System.debug('Department with least employees: ' + deptName + ' with ' + empCount + ' employees.');
        }
        
        
    }
    
    public class Employee {
        public void insertEmployee(String name, String position, Decimal salary, String deptName) {
            
            if(position != 'Head Department' && salary > 80000) {
                System.debug('Salary cannot be more than 80,000 for this position. - ' + position);
                return;
            }
            
            if([SELECT COUNT() FROM Employee__c WHERE FirstName__c = :name] > 0) {
                System.debug('Employee with this name already exists. - ' + name);
                return;
            }
            
            Employee__c emp = new Employee__c();
            emp.FirstName__c = name;
            emp.Salary__c = salary;
            emp.Adhar_Number__c = '1234567890';
            emp.Employee_Email__c = name.toLowerCase().replace(' ', '.') + '@example.com';
            emp.Position__c = position == null? 'Other' : position;
            
            List<Department__c> dept = [SELECT Id FROM Department__c WHERE DepartmentName__c = :deptName LIMIT 1];
            
            if(dept.isEmpty()) {
                System.debug('No department found with this name. - ' + deptName);
                return;
            }
            emp.Department__c = dept[0].Id;
            insert emp;
            System.debug('Employee inserted successfully. Id: ' + emp);
        }
        
        public  void updateEmployee(String name, String newPosition, Decimal newSalary,String deptName) {
            try {
                List<Employee__c> emp = [SELECT Id FROM Employee__c WHERE FirstName__c = :name LIMIT 1];
                if(emp.isEmpty()) {
                    System.debug('No employee found with this name. - ' + name);
                    return;
                }
                Employee__c e= emp[0];
                e.Position__c = newPosition;
                e.Salary__c = newSalary;
                List<Department__c> dept = [SELECT Id FROM Department__c WHERE DepartmentName__c = :deptName LIMIT 1];
                if(dept.isEmpty()) {
                    System.debug('No department found with this name. - ' + deptName);
                    return;
                }
                e.Department__c = dept[0].Id;
                update e;
                System.debug('Employee updated successfully. Id: ' + e);
            }
            catch (QueryException e) {
                System.debug('No employee found with this name. - ' + name);
            }
        }
        
        public  void deleteEmployee(String name) {
            List<Employee__c> emp = [SELECT Id FROM Employee__c WHERE FirstName__c = :name LIMIT 1];
            if(emp.isEmpty()) {
                System.debug('No employee found with this name. - ' + name);
                return;
            }
            delete emp;
            System.debug('Employee deleted successfully. Id: ' + emp);
        }
        
        
        public  void findMaxSalaryByPosition(String position) {
            List<AggregateResult> result = [SELECT MAX(Salary__c) maxSalary
                                       FROM Employee__c
                                       WHERE Position__c = :position];
            
            if(result.isEmpty()) {
                System.debug('No employees found for this position. - ' + position);
                return;
            }
            
            Decimal maxSalary = (Decimal) result[0].get('maxSalary');
            System.debug('Maximum salary for position ' + position + ' is: ' + maxSalary);
        }
        
        public  void displayPositionSalaryInfo() {
            List<AggregateResult> result = [SELECT Position__c, MAX(Salary__c) maxSalary, MIN(Salary__c) minSalary
                                       FROM Employee__c
                                       GROUP BY Position__c];
            
            if(result.isEmpty()) {
                System.debug('No employees found.');
                return;
            }
            
            for(AggregateResult ar : result) {
                String position = (String) ar.get('Position__c');
                Decimal maxSalary = (Decimal) ar.get('maxSalary');
                Decimal minSalary = (Decimal) ar.get('minSalary');
                System.debug('Position: ' + position + ', Max Salary: ' + maxSalary + ', Min Salary: ' + minSalary);
            }
        }
        
        public  List<Employee__c> searchEmployees(String searchTerm) {
            searchTerm = '%' + searchTerm + '%';
            List<Employee__c> emps = [SELECT Id, FirstName__c, Position__c, Salary__c 
                                         FROM Employee__c 
                                         WHERE FirstName__c LIKE :searchTerm];
            if(emps.isEmpty()) {
                System.debug('No employees found matching the search term. - ' + searchTerm);
                return new List<Employee__c>();
            }
            return emps;
        }
    }
}