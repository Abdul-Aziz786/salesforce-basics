public class DIYClassAndMap2 {
    
    public static void demo() {
        Map<String , Employee> empMap = new Map<String , Employee>{
            '101' => new Employee('101', 'Arun Kumar', 'IT', 'Chennai', 'Software Engineer', 550000),
                '102' =>  new Employee('102', 'Priya Sharma', 'HR', 'Bangalore', 'HR Manager', 750000),
                '103' => new Employee('103', 'Rahul Verma', 'Finance', 'Mumbai', 'Accountant', 600000),
                '104' => new Employee('104', 'Sneha Reddy', 'IT', 'Hyderabad', 'Senior Developer', 950000),
                '105' =>  new Employee('105', 'Vikram Singh', 'Sales', 'Delhi', 'Sales Executive', 480000),
                '106' => new Employee('106', 'Meena Iyer', 'IT', 'Chennai', 'Tech Lead', 1200000),
                '107' => new Employee('107', 'Karthik Raj', 'Operations', 'Coimbatore', 'Operations Manager', 850000),
                '108' => new Employee('108', 'Anjali Mehta', 'Marketing', 'Pune', 'Marketing Specialist', 650000),
                '109' => new Employee('109', 'Suresh Nair', 'Finance', 'Kochi', 'Finance Manager', 1100000),
                '110' =>new Employee('110', 'Divya Patel', 'IT', 'Bangalore', 'QA Engineer', 500000),
                '111' => new Employee('111', 'Kumar', 'IT', 'Chennai', 'Software Engineer', 40000)
                };
                    
                    EmployeeHelper empHelper = new EmployeeHelper();
        empHelper.getEmployeeByDepartment(empMap,'IT');
        empHelper.findLeastSalaryEmployee(empMap);
        empHelper.getEmployeeByLocation(empMap,'Bangalore');
        empHelper.groupByDesignation(empMap);
        
    }
    
    
    public class EmployeeHelper {
        public Integer getEmployeeByDepartment(Map<String,Employee> empMap, String dept) {
            List<Employee> temp = new List<Employee>();
            System.debug(dept);
            for(Employee emp : empMap.values()) {
                if(emp.department == dept) {
                    System.debug(emp.name + ' - ' + emp.department);
                    temp.add(emp);
                }
            }
            System.debug('Count - ' +temp.size());
            return temp.size();
        }
        
        public  void findLeastSalaryEmployee(Map<String,Employee> empMap) {
            Employee least;
            
            for (Employee e : empMap.values()) {
                if (least == null || e.salary < least.salary) {
                    least = e;
                }
            }
            
            System.debug('Highest Salary: ' + least.name + ' - ' + least.salary);
        }
        
        public List<Employee> getEmployeeByLocation(Map<String,Employee> empMap, String location) {
            List<Employee> temp = new List<Employee>();
            System.debug(location);
            for(Employee emp : empMap.values()) {
                if(emp.location == location) {
                    System.debug(emp.name + ' - ' + emp.location);
                    temp.add(emp);
                }
            }
            return temp;
        }
        
        public void groupByDesignation(Map<String,Employee> empMap) {
            
            Map<String,List<Employee>> groupMap = new Map<String,List<Employee>>();
            Map<String,Decimal> maxSalaryMap = new Map<String,Decimal>();
            for(Employee emp : empMap.values()) {
                if(groupMap.containsKey(emp.designation)) {
                    groupMap.get(emp.designation).add(emp);
                    
                    Decimal currentMaxSalary = maxSalaryMap.get(emp.designation);
                    
                    if(currentMaxSalary < emp.salary) {
                        maxSalaryMap.put(emp.designation,emp.salary);
                    }
                    
                } else {
                    groupMap.put(emp.designation,new List<Employee>{emp});
                    maxSalaryMap.put(emp.designation,emp.salary);
                }
                
            }
            
           System.debug(groupMap);
            for(String desig : maxSalaryMap.keySet()) {
                System.debug(desig + ': Max Salary = ' +  maxSalaryMap.get(desig));
            }
           

        }
    }
    
    public class Employee {
        public String department, location, employeeId, name, designation;
        Decimal salary;
        
        public Employee(String employeeId,String name,
                        String department,
                        String location,
                        String designation,
                        Decimal salary) {
                            this.department =department;
                            this.location = location;
                            this.employeeId= employeeId;
                            this.name = name;
                            this.designation = designation;
                            this.salary = salary;                 
                        }
    }
    
}