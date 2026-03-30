public class VariablesDIY {
    
    public static void run() {
        // 1.Total Price Calculation
        Integer quantity = 5;
        Decimal unitPrice = 200.50;
        
        Decimal totalPrice = quantity * unitPrice;
        
        System.debug('Total Price: ' + totalPrice);
        
        // 2. Area of a Rectangle
        
        Decimal length = 10;
        Decimal breadth = 5;
        
        Decimal areaOfRectangle = length * breadth;
        
        System.debug('Area of Rectangle: ' + areaOfRectangle);
        
        // 3.Area of a Square
        
        Decimal side = 4;
        
        Decimal area = side * side;
        
        System.debug('Area of Square: ' + area);
        
        //4. Student Marks Summary
        String studentName = 'Ajees';
        
        Integer mark1 = 80;
        Integer mark2 = 85;
        Integer mark3 = 90;
        
        Integer total = mark1 + mark2 + mark3;
        Decimal average = total / 3.0;
        
        System.debug('Student ' + studentName + ' scored total ' + total + ' marks');
        System.debug('Average: ' + average);
        
        // 5. Salary Breakdown
        String employeeName = 'Arsath';
        
        Decimal basicPay = 20000;
        Decimal hra = 3000;
        Decimal bonus = 2000;
        
        Decimal totalSalary = basicPay + hra + bonus;
        
        System.debug('Employee ' + employeeName + ' received Salary of INR ' + totalSalary);
        
        // 6. Email ID Generator
        String firstName = 'abdul';
        String lastName = 'ajees';
        String company = 'abccompany';
        
        String email = firstName + '.' + lastName + '@' + company + '.com';
        
        System.debug('Generated Email: ' + email);
        
        // 7. Price After Discount
        Decimal price = 1000;
        Decimal discountPercent = 10;
        
        Decimal discountAmount = (price * discountPercent) / 100;
        Decimal finalPrice = price - discountAmount;
        
        System.debug('Final Price after Discount: ' + finalPrice);
        
        // 8. Address Builder
        String doorNo = '12A';
        String street = 'MG Road';
        String myCity = 'Chennai';
        
        String fullAddress = doorNo + ', ' + street + ', ' + myCity;
        
        System.debug('Address: ' + fullAddress);
        
        // 9 .Monthly EMI (Simple Formula)
        //Simple interest formula:
        //Total Interest = (Principal × Rate × Time) / 100
        //Total Amount = Principal + Interest
        //EMI = Total Amount / (Years × 12)
        Decimal loanAmount = 500000;
        Decimal interestRate = 10;  // yearly %
        Integer tenureYears = 5;
        
        Decimal totalInterest = (loanAmount * interestRate * tenureYears) / 100;
        Decimal totalAmount = loanAmount + totalInterest;
        Decimal monthlyEMI = totalAmount / (tenureYears * 12);
        System.debug('Monthly EMI: ' + monthlyEMI);
        
        //10. Print Your Introduction
        String name = 'Abdul Ajees';
        Integer age = 25;
        String city = 'Chennai';
        System.debug('My name is ' + name + ', I am ' + age + ' years old, and I live in ' + city);
        
    }
    
}