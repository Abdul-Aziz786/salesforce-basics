trigger TestOpportunityTrigger on Opportunity (after delete) {
   
}

/*
try {
    List<Opportunity> cons = new List<Opportunity>();
    
    cons.add(new Opportunity(Name = 'Test 1',CloseDate = Date.today().addDays(5)),Amount = 5000,StageName='Qualification');
    cons.add(new Opportunity(Name = 'Test 2',CloseDate = Date.today().addDays(5)),Amount = 50000,StageName='Qualification');
    cons.add(new Opportunity(Name = 'Test 2',CloseDate = Date.today().addDays(5)),Amount = 150000,StageName='Closed Won');
    
    insert cons;
} catch(Exception e) {
    System.debug(e.getMessage());
}
*/