public  class TestClassAssingnment2 {
    // DIY 1:
    public static List<Opportunity> fetchOpportunitiesByStage(String stageName) {
        return [SELECT Id, Name, Amount, StageName FROM Opportunity WHERE StageName = :stageName];
    }
    
    // DIY 2:
    public static List<Opportunity> fetchOpportunitiesByAmount() {
        return [SELECT Id, Name, Amount FROM Opportunity WHERE Amount > 10000];
    }
    
    // DIY 3:
    
    public static void updateOpportunitiesToQualification() {
        List<Opportunity> opportunitiesToUpdate = [SELECT Id, StageName FROM Opportunity WHERE Amount < 50000 AND StageName NOT IN ('Closed Won', 'Closed Lost')];
        
        for (Opportunity opp : opportunitiesToUpdate) {
            opp.StageName = 'Qualification';
        }
        
        if (!opportunitiesToUpdate.isEmpty()) {
            update opportunitiesToUpdate;
        }
    }
    
    // DIY 4:
    public static List<Opportunity> fetchOpportunitiesClosingSoon() {
        Date today = Date.today();
        Date next30Days = today.addDays(30);
        
        return [SELECT Id, Name, CloseDate FROM Opportunity WHERE CloseDate >= :today AND CloseDate <= :next30Days];
    }
    
    // DIY 5:
    public static List<Opportunity> fetchOpportunitiesByAccountName(String accountName) {
        return [SELECT Id, Name, Amount FROM Opportunity WHERE Account.Name = :accountName];
    }
}