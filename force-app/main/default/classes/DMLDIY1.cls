public class DMLDIY1 {
    
    public static void demo() {
        
        // System.debug('--- DIY 1 ---');
        // List<Account> accs = createAccounts(5);
        // System.debug(accs);
        
        // System.debug('--- DIY 2 ---');
        // Set<Id> accIds = new Map<Id, Account>(accs).keySet();
        // List<Contact> contacts = createContactsForAccounts(new List<Id>(accIds));
        // System.debug(contacts);
        
        // System.debug('--- DIY 3 ---');
        // List<Account> updatedAccs = updateAccountRatings('Technology', 'Hot');
        // System.debug(updatedAccs);
        
        // System.debug('--- DIY 4 ---');
        // List<Contact> renamedContacts = renameContacts('Dummy', 'Renamed Contact');
        // System.debug(renamedContacts);
        
        System.debug('--- DIY 5 ---');
        List<Account> finalAccs = insertAndUpdateAccounts(3, 'Finance', 'Technology');
        System.debug(finalAccs);
        
        
    }
    
    // 1. Insert Accounts in Loop
    public static List<Account> createAccounts(Integer count) {
        List<Account> accs = new List<Account>();
        
        for(Integer i=0; i<count; i++) {
            accs.add(new Account(Name = 'Account ' + (i+1)));
        }
        insert accs;
        return accs;
    }
    
    
    // 2. Insert Related Contacts
    public static List<Contact> createContactsForAccounts(List<Id> accountIds) {
        List<Contact> contacts = new List<Contact>();
        
        for(Id accId : accountIds) {
            contacts.add(new Contact(LastName = 'Contact for ' + accId, AccountId = accId));
        }
        insert contacts;
        return contacts;
    }
    
    // 3. Update Accounts by Condition
    public static List<Account>  updateAccountRatings(String industry, String rating) {
        List<Account> accsToUpdate = [SELECT Id, Name, Industry, Rating FROM Account WHERE Industry = :industry AND Rating = null];
        
        for(Account acc : accsToUpdate) {
            acc.Rating = rating;
        }
        update accsToUpdate;
        return accsToUpdate;
    }
    // 4. Update Contact Names
    public static List<Contact> renameContacts(String oldLastName, String newLastName) {
        List<Contact> contactsToUpdate = [SELECT Id, FirstName, LastName FROM Contact WHERE LastName = :oldLastName];
        
        for(Contact con : contactsToUpdate) {
            con.LastName = newLastName;
        }
        update contactsToUpdate;
        return contactsToUpdate;
    }
    
    // 5. Insert + Update Flow
    // Create a class with a method insertAndUpdateAccounts (Integer count,
    // String industry, String newIndustry) that:
    // Inserts count number of Accounts with the given Industry.
    // • Updates those same Accounts to the new Industry.
    // • Returns the final list of updated Accounts.
    
    public static List<Account> insertAndUpdateAccounts(Integer count, String industry, String newIndustry) {
        
        List<Account> accs = new List<Account>();
        
        for(Integer i=0; i<count; i++) {
            accs.add(new Account(Name = 'Account ' + Datetime.now().getTime(), Industry = industry));
        }
        insert accs;
        
        System.debug('Inserted Accounts: ' + accs);
        
        for(Account acc : accs) {
            acc.Industry = newIndustry;
        }
        update accs;
        
        System.debug('Updated Accounts: ' + accs);
        return accs;
    }
}