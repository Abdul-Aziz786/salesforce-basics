public class CaseTaskQueue implements Queueable {
    
    List<Case> cases;
    
    public CaseTaskQueue(List<Case> cases){
        this.cases = cases;
    }
    
    public void execute(QueueableContext qc){
        
        List<Task> tasks = new List<Task>();
        
        for(Case c : cases){
            
            tasks.add(new Task(
                Subject='Urgent Case Followup',
            WhatId=c.Id,
            OwnerId=c.OwnerId,
            Status='Not Started',
            Priority='High'
                ));
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