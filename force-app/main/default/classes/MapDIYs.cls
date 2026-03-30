public  class MapDIYs {
    
    public static void demo() {
        //1
        studentRollNumberMap();
        //2
        EmployeeDept empDept = new EmployeeDept();
        System.debug('Department of E102: ' + empDept.getDepartment('E102'));
        //3
        ProductPrice pp = new ProductPrice();
        System.debug(pp.getDiscountedPrice('Mobile', 10));
        //4
        CourseEnrollment ce = new CourseEnrollment();
        ce.printEnrolledStudents('Salesforce');
        ce.printEnrolledStudents('Python');
        // 5
        BankAccount bank = new BankAccount();
        
        bank.deposit('A1001', 2000);
        System.debug(bank.withdraw('A1001', 3000));
        System.debug(bank.withdraw('A1003', 5000));
    }
    
    // 1: Student Roll Number Map
    public static void studentRollNumberMap() {
        Map<Integer, String> rollToName = new Map<Integer, String>{
            101 => 'Arjun',
            102 => 'Meera',
            103 => 'Ravi',
            104 => 'Kavya',
            105 => 'Sanjay'
        };
        
        rollToName.put(106, 'Anitha');
        
        if(rollToName.containsKey(102)){
            System.debug(rollToName.get(102));
        } else {
            System.debug('Roll Number 102 does not exist');
        }
        
        for (Integer rollNo : rollToName.keySet()) {
            System.debug('Roll No: ' + rollNo + ', Name: ' + rollToName.get(rollNo));
        }
    }
    
    //2: Employee Department Finder
    
    public class EmployeeDept {
        
        Map<String, String> empDeptMap;
        
        public EmployeeDept(){
            empDeptMap = new Map<String, String> {
                'E101' => 'HR',
                'E102' => 'IT',
                'E103' => 'Sales'
            };
        }
        
        public String getDepartment(String empId){
            if(empDeptMap.containsKey(empId)){
                return empDeptMap.get(empId);
            }
            return 'Employee not found';
        }
    }
    
    // 3: Product Price Calculator
    public class ProductPrice {
        
        Map<String, Decimal> productMap;
        
        public ProductPrice(){
            productMap = new Map<String, Decimal>{
                'Laptop' => 55000,
                'Mobile' => 25000,
                'Tablet' => 15000
            };
        }
        
        public Decimal getDiscountedPrice(String productName, Decimal discountPercent){
            
            if(productMap.containsKey(productName)){
                Decimal price = productMap.get(productName);
                Decimal finalPrice = price - (price * discountPercent / 100);
                return finalPrice;
            }
            
            return 0;
        }
    }
    
    // 4: Course Enrollment System
    public class CourseEnrollment {
        
        Map<String, List<String>> courseMap;
        
        public CourseEnrollment(){
            courseMap = new Map<String, List<String>>();
            
            courseMap.put('Salesforce', new List<String>{'John', 'Mary'});
            courseMap.put('Java', new List<String>{'David', 'Sara'});
        }
        
        public void printEnrolledStudents(String courseName){
            
            if(courseMap.containsKey(courseName)){
                
                System.debug('Students in ' + courseName + ':');
                
                for(String student : courseMap.get(courseName)){
                    System.debug(student);
                }
            }
            else{
                System.debug('Course not found');
            }
        }
    }
    
    // 5: Bank Account Balance Tracker
    public class BankAccount {
        
        Map<String, Decimal> accountMap;
        
        public BankAccount(){
            accountMap = new Map<String, Decimal>{
                'A1001' => 5000,
                'A1002' => 10000,
                'A1003' => 2000
            };
        }
        
        public void deposit(String accNo, Decimal amount){
            
            if(accountMap.containsKey(accNo)){
                accountMap.put(accNo, accountMap.get(accNo) + amount);
            }
        }
        
        public String withdraw(String accNo, Decimal amount){
            
            if(accountMap.containsKey(accNo)){
                
                Decimal currentBalance = accountMap.get(accNo);
                
                if(currentBalance >= amount){
                    Decimal newBalance = currentBalance - amount;
                    accountMap.put(accNo, newBalance);
                    return 'New Balance: ' + newBalance;
                }
            }
            
            return 'Insufficient balance or account not found';
        }
    }
}