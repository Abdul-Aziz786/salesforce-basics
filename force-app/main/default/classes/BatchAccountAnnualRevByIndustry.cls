public class BatchAccountAnnualRevByIndustry implements Database.Batchable<sObject>, Database.Stateful {
    
    Map<String, Decimal> industryRevenueMap = new Map<String, Decimal>();
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT Id, Name, AnnualRevenue, Industry FROM Account WHERE Industry != null]);
    }
    
    public void execute(Database.BatchableContext bc, List<Account> scope) {
        for (Account acc : scope) {
            if (acc.AnnualRevenue == null) {
                acc.AnnualRevenue = 0;
            }
            if (industryRevenueMap.containsKey(acc.Industry)) {
                industryRevenueMap.put(acc.Industry, industryRevenueMap.get(acc.Industry) + acc.AnnualRevenue);
            } else {
                industryRevenueMap.put(acc.Industry, acc.AnnualRevenue);
            }
        }
    }
    
    
    public void finish(Database.BatchableContext bc) {
        for (String industry : industryRevenueMap.keySet()) {
            System.debug('Industry: ' + industry + ', Total Annual Revenue: ' + industryRevenueMap.get(industry));
        }
    }
    
}