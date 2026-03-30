public  class QueueableUpdateInactiveContacts implements Queueable {
    public void execute(QueueableContext context) {
        Date cutOfDate = Date.today().addDays(-180);
        List<Contact> contactsToUpdate = [SELECT Id, Active__c FROM Contact WHERE LastModifiedDate < :cutOfDate AND Active__c = true];
        
        for (Contact contact : contactsToUpdate) {
            contact.Active__c = false;
        }
        
        if (!contactsToUpdate.isEmpty()) {
            try {
                update contactsToUpdate;
            } catch (DmlException e) {
                System.debug('Error updating contacts: ' + e.getMessage());
            }
        }
    }
    
}