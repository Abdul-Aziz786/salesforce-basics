public class SQOLVariableBindingDIYs {
    public static void demo() {
        
        System.debug('--- DIY 1 ---');
        System.debug(getOpportunitiesGreaterThan(5000));
        
        System.debug('--- DIY 2 ---');
        System.debug(getAccountsStartingWith('A'));
        
        System.debug('--- DIY 3 ---');
        System.debug(getOpportunitiesClosingAfter(Date.today()));
        
        System.debug('--- DIY 4 ---');
        System.debug(getOpportunitiesClosingOn(Date.today()));
        
        System.debug('--- DIY 5 ---');
        System.debug(
            getAccountsByIndustries(
                new List<String>{'Banking', 'Technology'}
            )
        );
        
        System.debug('--- DIY 6 ---');
        System.debug(getAccountsByTypeAndRevenue('Customer - Direct', 100000));
        
        System.debug('--- DIY 7 ---');
        System.debug(checkOddEven(1, 10));
        
        System.debug('--- DIY 8 ---');
        System.debug(searchFruit(
                new List<String>{'Apple','Banana','Orange'},
                'Banana'
            ));
        
        System.debug('--- DIY 9 ---');
        Map<String, Integer> studentMarks = new Map<String, Integer>{
                'John' => 75,
                'Mary' => 45,
                'David' => 82
                };
        System.debug(getPassedStudents(studentMarks, 50));
        
        System.debug('--- DIY 10 ---');
        Map<String, Integer> deptMap = new Map<String, Integer>{
                'IT' => 15,
                'HR' => 5,
                'Sales' => 20
                };
        System.debug(getDepartmentsAboveLimit(deptMap, 10));
    }
    
    // DIY 1 
    public static List<Opportunity> getOpportunitiesGreaterThan(Decimal minAmount) {
        return [
            SELECT Id, Name, Amount, CloseDate
            FROM Opportunity
            WHERE Amount > :minAmount
        ];
    }
    
    // DIY 2 
    public static List<Account> getAccountsStartingWith(String startingLetter) {
        return [
            SELECT Id, Name
            FROM Account
            WHERE Name LIKE :startingLetter + '%'
        ];
    }
    
    // DIY 3
    public static List<Opportunity> getOpportunitiesClosingAfter(Date todayDate) {
        return [
            SELECT Id, Name, CloseDate
            FROM Opportunity
            WHERE CloseDate > :todayDate
        ];
    }
    
    // DIY 4 
    public static List<Opportunity> getOpportunitiesClosingOn(Date specificDate) {
        return [
            SELECT Id, Name, CloseDate
            FROM Opportunity
            WHERE CloseDate = :specificDate
        ];
    }
    
    // DIY 5 
    public static List<Account> getAccountsByIndustries(List<String> industries) {
        return [
            SELECT Id, Name, Industry
            FROM Account
            WHERE Industry IN :industries
        ];
    }
    
    // DIY 6
    public static List<Account> getAccountsByTypeAndRevenue(String accType, Decimal revenueLimit) {
        return [
            SELECT Id, Name, Type, AnnualRevenue
            FROM Account
            WHERE Type = :accType
            AND AnnualRevenue > :revenueLimit
        ];
    }
    
    // DIY 7
    public static List<String> checkOddEven(Integer startNum, Integer endNum) {
        List<String> result = new List<String>();
        
        for (Integer i = startNum; i <= endNum; i++) {
            if (Math.mod(i, 2) == 0) {
                result.add(i + ' - Even');
            } else {
                result.add(i + ' - Odd');
            }
        }
        
        return result;
    }
    
    // DIY 8
    public static Boolean searchFruit(List<String> fruits, String fruitToFind) {
        return fruits.contains(fruitToFind);
    }
    
    // DIY 9
    public static List<String> getPassedStudents(Map<String, Integer> studentMarks, Integer passMark) {
        List<String> passed = new List<String>();
        
        for (String name : studentMarks.keySet()) {
            if (studentMarks.get(name) > passMark) {
                passed.add(name);
            }
        }
        
        return passed;
    }
    
    // DIY 10
    public static List<String> getDepartmentsAboveLimit(Map<String, Integer> deptMap, Integer count) {
        List<String> result = new List<String>();
        
        for (String dept : deptMap.keySet()) {
            if (deptMap.get(dept) > count) {
                result.add(dept);
            }
        }
        
        return result;
    }
    
}