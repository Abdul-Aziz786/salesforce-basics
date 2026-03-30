public  class WrapperClassDIY {
    
    public static void demo() {
        System.debug('--- DIY 1-----');
        ProductWrapper pw = wrapProduct();
        System.debug('Product Name: ' + pw.productName);
        System.debug('Price: ' + pw.price);
        System.debug('Is Expensive: ' + pw.isExpensive);
        
        System.debug('--- DIY 2-----');
        List<AccountWrapper> wrappedAccounts = getWrappedAccounts();
        for(AccountWrapper aw : wrappedAccounts) {
            System.debug('Account Name: ' + aw.acc.Name);
            System.debug('Is Selected: ' + aw.isSelected);
        }
        
        System.debug('--- DIY 3-----');
        List<StudentWrapper> students = getWrappedStudents();
        for(StudentWrapper sw : students) {
            System.debug('Student Name: ' + sw.studentName);
            System.debug('Marks: ' + sw.marks);
            System.debug('Is Passed: ' + sw.isPassed);
        }
        
        System.debug('--- DIY 4-----');
        List<BookWrapper> books = getBooks();
        for(BookWrapper bw : books) {
            System.debug('Book Name: ' + bw.bookName);
            System.debug('Pages: ' + bw.pages);
            System.debug('Is Long Book: ' + bw.isLongBook);
        }
        
        System.debug('--- DIY 5-----');
        List<AccountWrapper2> bigAccounts = wrapAccounts();
        for(AccountWrapper2 aw : bigAccounts) {
            System.debug('Account Name: ' + aw.acc.Name);
            System.debug('Is Big Account: ' + aw.isBigAccount);
        }
    }
    
    // DIY 1
    public class ProductWrapper {
        public String productName;
        public Decimal price;
        public Boolean isExpensive;
    }
    public static ProductWrapper wrapProduct() {
        String name = 'Laptop';
        Decimal price = 1500;
        
        ProductWrapper wrapper = new ProductWrapper();
        wrapper.productName = name;
        wrapper.price = price;
        wrapper.isExpensive = price > 1000;
        
        return wrapper;
    }
    // DIY 2
    
    public class AccountWrapper {
        public Account acc;
        public Boolean isSelected;
    }
    
    public static List<AccountWrapper> getWrappedAccounts() {
        
        List<Account> accounts = [SELECT Id, Name FROM Account LIMIT 3];
        List<AccountWrapper> wrappedList = new List<AccountWrapper>();
        
        for(Account a : accounts) {
            AccountWrapper wrapper = new AccountWrapper();
            wrapper.acc = a;
            wrapper.isSelected = true;
            wrappedList.add(wrapper);
        }
        
        return wrappedList;
    }
    
    // DIY 3
    public class StudentWrapper {
        public String studentName;
        public Integer marks;
        public Boolean isPassed;
    }
    
    public static List<StudentWrapper> getWrappedStudents() {
        
        List<StudentWrapper> listStudents = new List<StudentWrapper>();
        
        Map<String, Integer> sampleData = new Map<String, Integer>{
            'Arun' => 75,
            'Kumar' => 35,
            'Rahul' => 50,
            'Ajees' => 20
        };
        
        for(String name : sampleData.keySet()) {
            
            StudentWrapper wrapper = new StudentWrapper();
            wrapper.studentName = name;
            wrapper.marks = sampleData.get(name);
            wrapper.isPassed = wrapper.marks >= 40;
            
            listStudents.add(wrapper);
        }
        
        return listStudents;
    }
    // DIY 4
    
    public class BookWrapper {
        public String bookName;
        public Integer pages;
        public Boolean isLongBook;
    }
    
    public static List<BookWrapper> getBooks() {
        
        List<BookWrapper> books = new List<BookWrapper>();
        
        BookWrapper b1 = new BookWrapper();
        b1.bookName = 'Salesforce Guide';
        b1.pages = 450;
        b1.isLongBook = b1.pages > 300;
        
        BookWrapper b2 = new BookWrapper();
        b2.bookName = 'Apex Guide';
        b2.pages = 300;
        b2.isLongBook = b2.pages > 300;
        
        BookWrapper b3 = new BookWrapper();
        b3.bookName = 'Flutter Guide';
        b3.pages = 200;
        b3.isLongBook = b3.pages > 300;
        
        books.add(b1);
        books.add(b2);
        books.add(b3);
        return books;
    }
    
    // DIY 5
    public class AccountWrapper2 {
        public Account acc;
        public Boolean isBigAccount;
    }
    
    public static List<AccountWrapper2> wrapAccounts() {
        
        List<Account> accounts =
            [SELECT Id, Name, AnnualRevenue FROM Account LIMIT 5];
        
        List<AccountWrapper2> wrappedAccounts =
            new List<AccountWrapper2>();
        
        for(Account a : accounts) {
            
            AccountWrapper2 wrapper = new AccountWrapper2();
            wrapper.acc = a;
            
            if(a.AnnualRevenue != null && a.AnnualRevenue > 1000000) {
                wrapper.isBigAccount = true;
            } else {
                wrapper.isBigAccount = false;
            }
            
            wrappedAccounts.add(wrapper);
        }
        
        return wrappedAccounts;
    }
}