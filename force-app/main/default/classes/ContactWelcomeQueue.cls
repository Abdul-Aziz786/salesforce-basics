public class ContactWelcomeQueue implements Queueable {
    
    public void execute(QueueableContext qc) {
        List<Contact> contacts = [
            SELECT Id, Email, FirstName
            FROM Contact
            WHERE CreatedDate = YESTERDAY
            AND Welcome_Email_Sent__c = false
        ];
        
        for(Contact c : contacts){
            c.Welcome_Email_Sent__c = true;
        }
        
        if(!contacts.isEmpty()){
            try {
                update contacts;
            } catch(Exception e) {
                System.debug('Error updating contacts - ' + e.getMessage());
            }
        }
        
        System.enqueueJob(new ContactEmailQueue(contacts));
    }
}