public  class ContactController {
    public Contact con { get; set; }
    public ContactController() {
        con = new Contact();
    }
    
    public PageReference saveContact() {
        try {
            insert con;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Contact saved successfully.'));
            con = new Contact();
            // PageReference pr = new PageReference('/' + con.Id);
            // pr.setRedirect(true);
            // return pr;
            return null;
        }
        catch (DmlException e) {
            ApexPages.addMessages(e);
            return null;
        }
        
        catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error saving contact: ' + e.getMessage()));
            return null;
        }
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactsByAccountId(Id accountId) {
        try {
            return [SELECT Id, LastName, Email FROM Contact WHERE AccountId = :accountId];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}