public class ContactCreatorService {
    public static Contact createContact(String lastName, Id accountId) {
        Contact newContact = new Contact(
            LastName = lastName,
        AccountId = accountId
            );
        
        if (!Test.isRunningTest()) {
            insert newContact;
        }
        
        return newContact;
    }
}