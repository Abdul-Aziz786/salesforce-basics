public class LeadFollowupQueue implements Queueable {
    
    public void execute(QueueableContext qc){
        
        List<Lead> leads = [SELECT Id,OwnerId,Status FROM Lead WHERE Status = 'Open'];
        
        List<Task> tasks = new List<Task>();
        
        for(Lead l : leads){
            
            if(l.Status == 'Open'){
                
                tasks.add(new Task(
                    Subject='Lead Followup',
                WhoId=l.Id,
                OwnerId=l.OwnerId,
                ActivityDate=Date.today().addDays(3),
                Status='Not Started'
                    ));
            }
        }
        
        if(!tasks.isEmpty()){
            try {
                insert tasks;
            } catch(Exception e) {
                System.debug('Error inserting tasks - ' + e.getMessage());
            }
        }
    }
}