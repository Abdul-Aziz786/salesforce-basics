public class SOQLBasicsDIYs {
    
    public static void demo() {
        System.debug('getAccountsByIndustryAndCounty - ' +getAccountsByIndustryAndCounty());
        System.debug('getContactByTitle - ' +getContactByTitle());
        System.debug('getLeadsByWord - ' +getLeadsByWord());
        System.debug('getFiveAccountsByWord - ' +getFiveAccountsByWord()); 
        System.debug('getFirst10ContactByEmailDomain - ' +getFirst10ContactByEmailDomain()); 
        System.debug('getOpportunityByStageAndAmount - ' +getOpportunityByStageAndAmount()); 
        System.debug('getOpportunityByStages - ' +getOpportunityByStages()); 
        System.debug('getOpportunityByStages - ' +getAccountsWithoutIndustry()); 
        System.debug('getContactCountByCountry - ' +getContactCountByCountry()); 
        System.debug('get5RecentLeadsByStatus - ' +get5RecentLeadsByStatus());          
    }
    // 1
    public static List<Account> getAccountsByIndustryAndCounty() {
        List<Account> acc = new List<Account>();
        
        acc =  [SELECT Id,Name,Rating,Industry,BillingCountry 
                FROM Account 
                WHERE Industry = 'Energy' AND BillingCountry = 'United States'];
        
        return acc;
    }
    // 2
    public static List<Contact> getContactByTitle() {
        List<Contact> con = new List<Contact>();
        
        con =  [SELECT Id,Name,Title FROM Contact WHERE Title = 'CEO'];
       
        return con;
    }
    // 3
    public static List<Lead> getLeadsByWord() {
        List<Lead> lead = new List<Lead>();
        
        lead =  [SELECT Id,Name FROM Lead WHERE Name LIKE  'Bertha%'];
       
        return lead;
    }
     // 4
     public static List<Account> getFiveAccountsByWord() {
        List<Account> acc = new List<Account>();
        
        acc =  [SELECT Id,Name,Rating,Industry,BillingCountry 
                FROM Account 
                WHERE Name LIKE 'Test%'
                LIMIT 5
               ];
        
        return acc;
    }
    // 5
    public static List<Contact> getFirst10ContactByEmailDomain() {
        List<Contact> con = new List<Contact>();
        
        con =  [SELECT 
                Id,Name,Title,Email 
                FROM Contact 
                WHERE Email LIKE '%@uog.com' 
                LIMIT 10];
       
        return con;
    }
    // 6
    public static List<Opportunity> getOpportunityByStageAndAmount() {
        List<Opportunity> opp = [SELECT Id,Name,StageName,Amount,CloseDate 
                                 FROM Opportunity 
                                 WHERE StageName = 'Qualification' AND Amount > 12000 
                                 ORDER BY CloseDate];
        return opp;
       }
    // 7
    public static List<Opportunity> getOpportunityByStages() {
        List<Opportunity> opp = [SELECT Name,StageName,Amount 
                                 FROM Opportunity 
                                 WHERE StageName IN('Qualification','Prospecting') And Amount != NULL 
                                 ORDER BY Amount Desc];
        return opp;
       }
    // 8
    public static List<Account> getAccountsWithoutIndustry() {
        List<Account> acc = new List<Account>();
        
        acc =  [SELECT Name,Industry 
                From 
                Account WHERE Industry = NULL 
                ORDER BY Name];
        
        return acc;
    }
    // 9
    public static Integer getContactCountByCountry() {
        List<Contact> con = new List<Contact>();
        
        con =  [SELECT Name,MailingCountry From Contact WHERE MailingCountry = 'United States'];
       
        return con.size();
    }
    // 10
    public static List<Lead> get5RecentLeadsByStatus() {
        List<Lead> lead = new List<Lead>();
        
        lead =  [SELECT Name,Status,CreatedDate 
                 From Lead 
                 WHERE Status IN('Working - Contacted','Open - Not Contacted') 
                 ORDER BY CreatedDate Desc 
                 LIMIT 5];
       
        return lead;
    }
    
}