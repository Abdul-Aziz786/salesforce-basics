public  class CleanCodeDIY {
    
    public static void demo(){
        System.debug('--- DIY 1-----');
        UserInfoService userInfoService = new UserInfoService();
        userInfoService.printUserDetails();
        
        System.debug('--- DIY 2-----');
        AccountService accountService = new AccountService();
        accountService.createAndPrintAccount();
        
        System.debug('--- DIY 3-----');
        AccountContactService acService = new AccountContactService();
        acService.processData();
        
        System.debug('--- DIY 4-----');
        TemperatureConverter tempConverter = new TemperatureConverter();
        tempConverter.convertTemperature();
        
        System.debug('--- DIY 5-----');
        CalculatorService calculator = new CalculatorService();
        calculator.runCalculation();
        
        
    }
    
    // DIY 1
    
    public class UserInfoService {
        
        public  void printUserDetails() {
            
            String userName = 'Bob';
            Integer userAge = 40;
            String userCity = 'Delhi';
            
            System.debug('User Name: ' + userName);
            System.debug('User Age: ' + userAge);
            System.debug('User City: ' + userCity);
        }
    }
    
    // DIY 2
    
    public class AccountService {
        
        public  void createAndPrintAccount() {
            
            Account newAccount = new Account();
            newAccount.Name = 'Acme';
            newAccount.Rating = 'Hot';
            newAccount.Industry = 'Technology';
            
            System.debug('Account Name: ' + newAccount.Name);
            System.debug('Rating: ' + newAccount.Rating);
            System.debug('Industry: ' + newAccount.Industry);
            // insert newAccount;
        }
    }
    
    // DIY 3
    public class AccountContactService {
        
        public  void processData() {
            
            Account accountRecord = createAccount();
            printAccountDetails(accountRecord);
            evaluateAccountPriority(accountRecord);
            
            Contact contactRecord = createContact();
            printContactDetails(contactRecord);
            evaluateContactType(contactRecord);
            
            System.debug('Finished processing account and contact.');
        }
        
        private  Account createAccount() {
            return new Account(
                Name = 'Acme Corp',
            Rating = 'Hot',
            Industry = 'Technology'
                );
        }
        
        private  void printAccountDetails(Account acc) {
            System.debug('Account Name: ' + acc.Name);
            System.debug('Account Rating: ' + acc.Rating);
            System.debug('Account Industry: ' + acc.Industry);
        }
        
        private  void evaluateAccountPriority(Account acc) {
            
            if (acc.Rating == 'Hot') {
                System.debug('This account is high priority!');
            }
            else if (acc.Rating == 'Warm') {
                System.debug('This account is medium priority.');
            }
            else {
                System.debug('This account is low priority.');
            }
        }
        
        private  Contact createContact() {
            return new Contact(
                FirstName = 'Test',
            LastName = 'User',
            Email = 'test.user@example.com'
                );
        }
        
        private  void printContactDetails(Contact con) {
            System.debug('Contact First Name: ' + con.FirstName);
            System.debug('Contact Last Name: ' + con.LastName);
            System.debug('Contact Email: ' + con.Email);
        }
        
        private  void evaluateContactType(Contact con) {
            
            if (con.Email != null && con.Email.contains('example.com')) {
                System.debug('Internal contact');
            }
            else {
                System.debug('External contact');
            }
        }
    }
    // DIY 4
    
    public class TemperatureConverter {
        
        private  final Decimal CELSIUS_TO_FAHRENHEIT_RATIO = 9.0 / 5.0;
        private  final Integer FAHRENHEIT_OFFSET = 32;
        
        public  void convertTemperature() {
            Decimal celsiusValue = 25;
            
            Decimal fahrenheitValue = convertCelsiusToFahrenheit(celsiusValue);
            System.debug('Fahrenheit Value: ' + fahrenheitValue);
            
            Decimal convertedBackToCelsius = convertFahrenheitToCelsius(fahrenheitValue);
            System.debug('Celsius Value: ' + convertedBackToCelsius);
            
            System.debug('Temperature conversion completed successfully.');
        }
        
        private  Decimal convertCelsiusToFahrenheit(Decimal celsius) {
            return (celsius * CELSIUS_TO_FAHRENHEIT_RATIO) + FAHRENHEIT_OFFSET;
        }
        
        private  Decimal convertFahrenheitToCelsius(Decimal fahrenheit) {
            return (fahrenheit - FAHRENHEIT_OFFSET) / CELSIUS_TO_FAHRENHEIT_RATIO;
        }
    }
    
    // DIY 5
    public class CalculatorService {
        
        public  void runCalculation() {
            Integer firstNumber = 10;
            Integer secondNumber = 5;
            
            System.debug('Addition Result: ' + add(firstNumber, secondNumber));
            System.debug('Subtraction Result: ' + subtract(firstNumber, secondNumber));
            System.debug('Multiplication Result: ' + multiply(firstNumber, secondNumber));
            
            Decimal divisionResult = divide(firstNumber, secondNumber);
            if (divisionResult != null) {
                System.debug('Division Result: ' + divisionResult);
            }
            
            System.debug('Calculation completed successfully.');
        }
        
        private  Integer add(Integer num1, Integer num2) {
            return num1 + num2;
        }
        
        private  Integer subtract(Integer num1, Integer num2) {
            return num1 - num2;
        }
        
        private  Integer multiply(Integer num1, Integer num2) {
            return num1 * num2;
        }
        
        private  Decimal divide(Integer num1, Integer num2) {
            if (num2 == 0) {
                System.debug('Cannot divide by zero.');
                return null;
            }
            return Decimal.valueOf(num1) / Decimal.valueOf(num2);
        }
    }
}