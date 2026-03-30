public  class CustomListDIYs {
    public static void demo() {
        studentRecords();
        productCatalog();
        libraryManagement();
        employeePayroll();
        onlineOrders();
    }
    
    // 1. Student Records
    public class Student {
        public String name;
        public String course;
        public Decimal marks;
        
        public Student(String name, String course, Decimal marks) {
            this.name = name;
            this.course = course;
            this.marks = marks;
        }
    }
    public static void studentRecords() {
        List<Student> students = new List<Student>{
            new Student('Arjun', 'Java Full Stack', 85),
            new Student('Meera', 'Python AI', 90),
            new Student('Ravi', 'Java Full Stack', 75),
            new Student('Kavya', 'Data Science', 88),
            new Student('Sanjay', 'Java Full Stack', 92)
        };
        
        Decimal totalMarks = 0;
        
        for(Student s : students){
            
            if(s.course == 'Java Full Stack'){
                System.debug('Java Student: ' + s.name);
            }
            
            totalMarks += s.marks;
        }
        
        Decimal avg = totalMarks / students.size();
        System.debug('Average Marks: ' + avg);
    }
    
    // 2. Product Catalog
    public class Product {
        public String productName;
        public String category;
        public Decimal price;
        
        public Product(String productName, String category, Decimal price){
            this.productName = productName;
            this.category = category;
            this.price = price;
        }
    }
    
    public static void productCatalog() {
        List<Product> products = new List<Product>{
            new Product('Laptop', 'Electronics', 50000),
            new Product('Phone', 'Electronics', 25000),
            new Product('Shoes', 'Fashion', 3000),
            new Product('TV', 'Electronics', 45000),
            new Product('Watch', 'Fashion', 5000),
            new Product('Headphones', 'Electronics', 800)
        };
        
        Integer electronicsCount = 0;
        
        for(Product p : products){
            
            if(p.price > 1000){
                System.debug('Expensive Product: ' + p.productName);
            }
            
            if(p.category == 'Electronics'){
                electronicsCount++;
            }
        }
        
        System.debug('Electronics Count: ' + electronicsCount);
    }
    
    
    // 3. Library Management
    public class Book {
        public String title;
        public String author;
        public String genre;
        
        public Book(String title, String author, String genre){
            this.title = title;
            this.author = author;
            this.genre = genre;
        }
    }
    public static void libraryManagement() {
        List<Book> books = new List<Book>{
            new Book('Dune', 'Frank Herbert', 'Science Fiction'),
            new Book('1984', 'George Orwell', 'Dystopian'),
            new Book('Foundation', 'Isaac Asimov', 'Science Fiction'),
            new Book('Hamlet', 'Shakespeare', 'Drama')
        };
        
        for(Book b : books){
            
            if(b.genre == 'Science Fiction'){
                System.debug('Sci-Fi Book: ' + b.title);
            }
            
            System.debug('Author: ' + b.author);
        }
    }
    
    // 4. Employee Payroll
    public class Employee {
        public String empName;
        public String department;
        public Decimal salary;
        
        public Employee(String empName, String department, Decimal salary){
            this.empName = empName;
            this.department = department;
            this.salary = salary;
        }
    }
    
    public static void employeePayroll() {
        List<Employee> employees = new List<Employee>{
            new Employee('Arjun', 'HR', 40000),
            new Employee('Meera', 'IT', 60000),
            new Employee('Ravi', 'HR', 45000),
            new Employee('Kavya', 'Finance', 70000),
            new Employee('Sanjay', 'IT', 55000)
        };
        
        Employee highestPaid;
        Decimal maxSalary = 0;
        
        for(Employee e : employees){
            
            if(e.department == 'HR'){
                System.debug('HR Employee: ' + e.empName);
            }
            
            if(e.salary > maxSalary){
                maxSalary = e.salary;
                highestPaid = e;
            }
        }
        
        System.debug('Highest Salary: ' + highestPaid.empName + ' - ' + highestPaid.salary);
    }
    
    // 5. Online Orders
    public class Order {
        public String orderId;
        public String customerName;
        public Decimal amount;
        
        public Order(String orderId, String customerName, Decimal amount){
            this.orderId = orderId;
            this.customerName = customerName;
            this.amount = amount;
        }
    }
    
    public static void onlineOrders() {
        List<Order> orders = new List<Order>{
            new Order('O1', 'John', 6000),
            new Order('O2', 'David', 3000),
            new Order('O3', 'John', 8000),
            new Order('O4', 'Arun', 2000),
            new Order('O5', 'John', 1000)
        };
        
        Integer johnCount = 0;
        
        for(Order o : orders){
            
            if(o.amount > 5008){
                System.debug('High Value Order: ' + o.orderId);
            }
            
            if(o.customerName == 'John'){
                johnCount++;
            }
        }
        
        System.debug('John Order Count: ' + johnCount);
    }
}