public class SetDIYs {
    
    public static void demo() {
        uniqueCustomerEmails();
        uniqueProductCategories();
        uniqueDepartmentsInCompany();
        unionOfTwoSets();
        removeDuplicatePhoneNumbers();
    }
    // 1: Unique Customer Emails
    public static void uniqueCustomerEmails() {
        
        Set<String> emails = new Set<String>();
        
        emails.add('a@gmail.com');
        emails.add('b@gmail.com');
        emails.add('c@gmail.com');
        emails.add('d@gmail.com');
        emails.add('e@gmail.com');
        emails.add('a@gmail.com'); // duplicate
        emails.add('c@gmail.com'); // duplicate
        
        System.debug('Total Unique Emails: ' + emails.size());
    }
    
    // 2: Unique Product Categories
    public static void uniqueProductCategories() {
        Set<String> categories = new Set<String>{
            'Electronics',
            'Furniture',
            'Electronics',
            'Stationery',
            'Furniture'
        };
        
        for(String cat : categories){
            System.debug(cat);
        }
        
        if(categories.contains('Clothing')){
            System.debug('Clothing exists');
        } else {
            System.debug('Clothing does not exist');
        }
    }
    
    // 3. Unique Departments in a Company
    
    public class Employee {
        public String name;
        public String department;
        
        public Employee(String name, String department){
            this.name = name;
            this.department = department;
        }
    }
    public static void uniqueDepartmentsInCompany() {
        List<Employee> employees = new List<Employee>{
            new Employee('Arjun', 'HR'),
            new Employee('Meera', 'IT'),
            new Employee('Ravi', 'HR'),
            new Employee('Kavya', 'Finance'),
            new Employee('Sanjay', 'IT'),
            new Employee('Nila', 'Finance')
        };
        
        Set<String> uniqueDepartments = new Set<String>();
        
        for(Employee e : employees){
            uniqueDepartments.add(e.department);
        }
        
        System.debug('Unique Departments: ' + uniqueDepartments);
    }
    
    // 4. Union of Two Sets (Event Participants)
    public static void unionOfTwoSets() {
        Set<String> setA = new Set<String>{'Ashok', 'Naga', 'Vijit'};
        Set<String> setB = new Set<String>{'Shobana', 'Naga', 'Ilakya'};
        
        Set<String> unionSet = new Set<String>();
        unionSet.addAll(setA);
        unionSet.addAll(setB);
        
        
        System.debug('Union: ' + unionSet);
        
        Set<String> intersectionSet = new Set<String>(setA);
        intersectionSet.retainAll(setB);
        
        System.debug('Intersection: ' + intersectionSet);
        
        Set<String> differenceSet = new Set<String>(setA);
        differenceSet.removeAll(setB);
        
        System.debug('Difference: ' + differenceSet);
    }
    
    // 5. Remove Duplicate Phone Numbers
    public static void removeDuplicatePhoneNumbers() {
        List<String> phoneNumbers = new List<String>{
            '9876543210',
            '9123456780',
            '9876543210',
            '9988776655',
            '9123456780'
        };
        
        Set<String> uniquePhones = new Set<String>(phoneNumbers);
        
        List<String> cleanPhoneList = new List<String>(uniquePhones);
        
        System.debug(cleanPhoneList);
    }
}