public class BatchCloseOverdueOpportunities implements Database.Batchable<SObject>, Database.Stateful {
    
    Integer updatedCount = 0;
    
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT Id, StageName FROM Opportunity ' +
            'WHERE IsClosed = FALSE AND CloseDate < TODAY'
            );
    }
    
    public void execute(Database.BatchableContext bc, List<Opportunity> scope) {
        
        for (Opportunity opp : scope) {
            opp.StageName = 'Closed Lost';
        }
        
        if (!scope.isEmpty()) {
            update scope;
            updatedCount += scope.size();
        }
    }
    
    public void finish(Database.BatchableContext bc) {
        
        String toEmail = System.Label.Automation_Email;
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        mail.setToAddresses(new String[] { toEmail });
        mail.setSubject('Batch Job Completed - Overdue Opportunities Closed');
        mail.setPlainTextBody(
            'Batch completed successfully.\n\n' +
            'Total Opportunities Closed: ' + updatedCount
            );
        
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}