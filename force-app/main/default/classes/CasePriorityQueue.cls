public class CasePriorityQueue implements Queueable {
    
    List<Case> cases;
    
    public CasePriorityQueue(List<Case> cases){
        this.cases = cases;
    }
    
    public void execute(QueueableContext qc){
        
        List<Case> toUpdate = new List<Case>();
        List<Case> highPriority = new List<Case>();
        
        for(Case c : cases){
            
            if(c.SLA__c > 48){
                c.Priority = 'Low';
            }
            else{
                c.Priority = 'High';
                highPriority.add(c);
            }
            
            toUpdate.add(c);
        }
        
        if(!toUpdate.isEmpty()){
            try {
                update toUpdate;
            } catch(Exception e) {
                System.debug('Error updating cases - ' + e.getMessage());
            }
        }
        
        if(!highPriority.isEmpty()){
            System.enqueueJob(new CaseTaskQueue(highPriority));
        }
    }
}