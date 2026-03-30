public class ClassAndMethodsDIY {
    
    public static void demo() {
        //1
        Calculator calc = new Calculator();
        System.debug('Addition - ' + calc.add(10, 5));
        System.debug('Subtraction - ' + calc.subtract(10, 5));
        System.debug('Multiplication - ' + calc.multiply(10, 5));
        System.debug('Division - ' + calc.divide(10, 5));
        //2
        StudentResult sr = new StudentResult(80, 75, 90);
        System.debug('Total = ' + sr.getTotal());
        System.debug('Average = ' + sr.getAverage());
        System.debug('Grade : '+ sr.getGrade());
        //3
        BankAccount bankAccount = new BankAccount();
        System.debug('Deposit - '+ bankAccount.deposit(50000,10000));
        System.debug('Withdraw - ' + bankAccount.withdraw(50000,5000));
        // 4
        Inventory inventory =  new Inventory();
        System.debug('Add Stock - '+ inventory.addStock(10,5));
        System.debug('Sell - ' + inventory.sellProduct(15,7));
        // 5
        EmployeeBonus emp = new EmployeeBonus();
        
        System.debug('Yearly Salary - ' + emp.yearlySalary(5000));
        System.debug('Bonus - ' + emp.calculateBonus(5000, 10));
        
        // 6
        Car car = new Car('Toyota', 'Innova');
        System.debug(car.start());
        
        // 7
        Hotel hotel = new Hotel(20);
        System.debug(hotel.reserveRoom(5));
        System.debug(hotel.cancelRoom(2));
        // 8
        Library library = new Library();
        System.debug('Issue Book - ' + library.issueBook(100, 10));
        System.debug('Return Book - ' + library.returnBook(90, 5));
        
        // 9
        Order order = new Order();
        System.debug(order.placeOrder('ORD123', 250.75));
        System.debug(order.cancelOrder('ORD123'));
        
        // 10
        UserProfile userProfile = new UserProfile();
        System.debug(userProfile.createProfile('john_doe', 'john_doe@example.com'));
        System.debug(userProfile.updateProfile('john_doe', 'john_doe_new@example.com'));
        System.debug(userProfile.deleteProfile('john_doe'));
        
        
    }
    // 1| Calculator Program
    
    public class Calculator {
        
        public Decimal add(Decimal a, Decimal b) {
            return a + b;
        }
        
        public Decimal subtract(Decimal a, Decimal b) {
            return a - b;
        }
        
        public Decimal multiply(Decimal a, Decimal b) {
            return a * b;
        }
        
        public Decimal divide(Decimal a, Decimal b) {
            return a / b;
        }
    }
    
    // 2| Student Result & Grade System
    // Create a class to accept three subject marks as input and return the total, average, and grade of the student using methods.
    
    public class StudentResult {
        Integer m1, m2, m3;
        public StudentResult(Integer m1, Integer m2, Integer m3) {
            this.m1 = m1;
            this.m2 = m2;
            this.m3 = m3;
        }
        
        public Integer getTotal() {
            return m1 + m2 + m3;
        }
        
        public Decimal getAverage() {
            return getTotal() / 3.0;
        }
        
        public String getGrade() {
            Decimal avg = getAverage();
            
            if (avg >= 90) return 'S';
            else if (avg >= 80) return 'A';
            else if (avg >= 70) return 'B';
            else if (avg >= 50) return 'C';
            else return 'Fail';
        }
    }
    
    
    // 3] Banking Operations
    // Create a class that has methods to deposit and withdraw money by accepting balance and transaction amount. Return the updated balance after each transaction.
    public class BankAccount {
        
        public Decimal deposit(Decimal balance, Decimal amount) {
            return balance + amount;
        }
        
        public Decimal withdraw(Decimal balance, Decimal amount) {
            return balance - amount;
        }
    }
    
    // 4] Inventory Management
    // Design a product inventory class with methods to add stock and sell products. Accept current stock and quantity as parameters and return the updated stock.
    
    
    public class Inventory {
        
        public Integer addStock(Integer currentStock, Integer quantity) {
            return currentStock + quantity;
        }
        
        public Integer sellProduct(Integer currentStock, Integer quantity) {
            return currentStock - quantity;
        }
    }
    
    // 5|Employee Bonus Calculator
    // Create a class with methods to calculate an employee's yearly salary and bonus based on monthly salary and a percentage-based bonus.
    
    public class EmployeeBonus {
        
        public Decimal yearlySalary(Decimal monthlySalary) {
            return monthlySalary * 12;
        }
        
        public Decimal calculateBonus(Decimal monthlySalary, Decimal percentage) {
            Decimal yearly = yearlySalary(monthlySalary);
            return (yearly * percentage) / 100;
        }
    }
    
    // 6 Car Controller (with Constructor)
    // Create a class for a car with brand and model passed via constructor. Add methods to return messages when the car starts or stops.
    
    public class Car {
        
        String brand;
        String model;
        
        public Car(String brand, String model) {
            this.brand = brand;
            this.model = model;
        }
        
        public String start() {
            return brand + ' ' + model + ' is starting.';
        }
        
        public String stop() {
            return brand + ' ' + model + ' is stopping.';
        }
    }
    
    // 7 Hotel Room Booking System (with Constructor)
    // Create a class to track available rooms. Use a constructor to initialize room count. Add methods to reserve and cancel rooms, updating the available room count accordingly.
    
    public class Hotel {
        
        Integer availableRooms;
        
        public Hotel(Integer availableRooms) {
            this.availableRooms = availableRooms;
        }
        
        public String reserveRoom(Integer quantity) {
            if (quantity <= availableRooms) {
                availableRooms -= quantity;
                return quantity + ' room(s) reserved. ' + availableRooms + ' room(s) left.';
            } else {
                return 'Not enough rooms available. Only ' + availableRooms + ' room(s) left.';
            }
        }
        
        public String cancelRoom(Integer quantity) {
            availableRooms += quantity;
            return quantity + ' room(s) cancelled. ' + availableRooms + ' room(s) now available.';
        }
    }
    
    
    // 8 Library Book Tracker
    // Create a class for a library system with methods to issue and return books. Pass current book count and quantity as parameters and return the updated count.
    
    public class Library {
        
        public Integer issueBook(Integer currentCount, Integer quantity) {
            return currentCount - quantity;
        }
        
        public Integer returnBook(Integer currentCount, Integer quantity) {
            return currentCount + quantity;
        }
    }
    
    // 9|Online Order Handling
    // Create a class with methods to place and cancel an order. Each method should accept order details like ID and amount, and return a confirmation message.
    
    public class Order {
        
        public String placeOrder(String orderId, Decimal amount) {
            return 'Order ' + orderId + ' placed successfully for amount $' + amount;
        }
        
        public String cancelOrder(String orderId) {
            return 'Order ' + orderId + ' has been cancelled.';
        }
    }
    
    // 10| User Profile Manager
    // Create a class to handle user profile creation, update, and deletion. Pass user data as parameters and return confirmation messages for each action.
    
    public class UserProfile {
        
        public String createProfile(String username, String email) {
            return 'User profile for ' + username + ' created with email ' + email;
        }
        
        public String updateProfile(String username, String newEmail) {
            return 'User profile for ' + username + ' updated with new email ' + newEmail;
        }
        
        public String deleteProfile(String username) {
            return 'User profile for ' + username + ' has been deleted.';
        }
    }
    
}