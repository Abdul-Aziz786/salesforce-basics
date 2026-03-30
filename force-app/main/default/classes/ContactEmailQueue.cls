public class ContactEmailQueue implements Queueable {
    
    List<Contact> contacts;
    
    public ContactEmailQueue(List<Contact> contacts){
        this.contacts = contacts;
    }
    
    public void execute(QueueableContext qc){
        
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        
        for(Contact c : contacts){
            
            if(c.Email == null) continue;
            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            
            mail.setToAddresses(new List<String>{c.Email});
            mail.setSubject('Welcome');
            mail.setPlainTextBody('Welcome ' + c.FirstName);
            
            emails.add(mail);
        }
        
        if(!emails.isEmpty()){
            Messaging.sendEmail(emails);
        }
    }
}