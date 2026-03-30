public with sharing class ContactController {
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactsByAccountId(Id accountId) {
        try {
            return [SELECT Id, LastName, Email FROM Contact WHERE AccountId = :accountId];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}