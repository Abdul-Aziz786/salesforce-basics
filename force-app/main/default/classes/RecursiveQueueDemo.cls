public class RecursiveQueueDemo implements Queueable {
    
    Integer count;
    
    public RecursiveQueueDemo(Integer count){
        this.count = count;
    }
    
    public void execute(QueueableContext qc){
        
        System.debug('Current iteration: ' + count);
        System.debug('Current queueable stack depth: ' + AsyncInfo.getCurrentQueueableStackDepth());
        System.debug('Maximum queueable stack depth: ' + AsyncInfo.getMaximumQueueableStackDepth());
        Integer info = AsyncInfo.getMaximumQueueableStackDepth();
        
        if(count < info){
            System.enqueueJob(new RecursiveQueueDemo(count+1));
        }
        count++;
    }
}