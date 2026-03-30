public  class ConstructorDIY {
    public static void demo() {
        //1.Temperature Converter
        TemperatureConverter tempConverter = new TemperatureConverter(25);
        System.debug(tempConverter.getDetails());
        
        //2.Circle Calculator
        CircleCalculator circleCalc = new CircleCalculator(5);
        System.debug(circleCalc.getDetails());
        //3.Employee Bonus
        EmployeeBonus empBonus = new EmployeeBonus('John Doe', 60000);
        System.debug(empBonus.getDetails());
        
        //4.Marks Grade Finder
        MarksGradeFinder gradeFinder = new MarksGradeFinder('Anitha', 82);
        System.debug(gradeFinder.getDetails());
        
        //5.Bank Account
        BankAccount acc1 = new BankAccount('Vijay', 500);
        System.debug(acc1.getDetails());
        
        BankAccount acc2 = new BankAccount('Priya', 1500);
        System.debug(acc2.getDetails());
    }
    
    // 1.Temperature Converter
    public class TemperatureConverter {
        Decimal celsius;
        Decimal fahrenheit;
        
        public TemperatureConverter(Decimal celsius) {
            this.celsius = celsius;
            this.fahrenheit = (celsius * 9/5) + 32;
        }
        
        public String getDetails() {
            return 'Temperature in Celsius: ' + celsius +
                ', in Fahrenheit: ' + fahrenheit;
        }
    }
    
    // 2.Circle Calculator
    public class CircleCalculator {
        
        Decimal radius;
        Decimal area;
        Decimal circumference;
        
        public CircleCalculator(Decimal radius) {
            this.radius = radius;
            Decimal pi = 3.14;
            
            this.area = pi * radius * radius;
            this.circumference = 2 * pi * radius;
        }
        
        public String getDetails() {
            return 'Radius: ' + radius +
                ', Area: ' + area +
                ', Circumference: ' + circumference;
        }
    }
    
    // 3. Employee Bonus
    public class EmployeeBonus {
        
        String name;
        Decimal salary;
        Decimal bonus;
        
        public EmployeeBonus(String name, Decimal salary) {
            this.name = name;
            this.salary = salary;
            
            if (salary > 50000) {
                this.bonus = salary * 0.10;
            } else {
                this.bonus = salary * 0.05;
            }
        }
        
        public String getDetails() {
            return 'Employee: ' + name +
                ', Salary: ' + salary +
                ', Bonus: ' + bonus;
        }
    }
    
    // 4. Marks Grade Finder
    public class MarksGradeFinder {
        
        String studentName;
        Integer marks;
        String grade;
        
        public MarksGradeFinder(String studentName, Integer marks) {
            this.studentName = studentName;
            this.marks = marks;
            getGrade();
            
        }
        
        void getGrade() {
            if (marks >= 90) {
                grade = 'A';
            } else if (marks >= 75) {
                grade = 'B';
            } else if (marks >= 50) {
                grade = 'C';
            } else {
                grade = 'Fail';
            }
        }
        
        public String getDetails() {
            return 'Student: ' + studentName +
                ', Marks: ' + marks +
                ', Grade: ' + grade;
        }
    }
    
    // 5. Bank Account
    public class BankAccount {
        
        String accountHolder;
        Decimal balance;
        String statusMessage;
        
        public BankAccount(String accountHolder, Decimal balance) {
            this.accountHolder = accountHolder;
            this.balance = balance;
            
            if (balance < 1000) {
                statusMessage = 'Minimum balance not maintained';
            } else {
                statusMessage = 'Account created successfully';
            }
        }
        
        public String getDetails() {
            return 'Account Holder: ' + accountHolder +
                ', Balance: ' + balance +
                ' → ' + statusMessage;
        }
    }
    
}