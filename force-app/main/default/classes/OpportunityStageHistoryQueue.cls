public class OpportunityStageHistoryQueue implements Queueable {
    
    List<Opportunity_Stage_History__c> logs;
    
    public OpportunityStageHistoryQueue(List<Opportunity_Stage_History__c> logs){
        this.logs = logs;
    }
    
    public void execute(QueueableContext qc){
        if(!logs.isEmpty()){
            try {
                insert logs;
            } catch(Exception e) {
                System.debug('Error inserting opportunity stage history logs - ' + e.getMessage());
            }
        }
    }
}