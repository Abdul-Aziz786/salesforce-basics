public with sharing class AccountController {
    @AuraEnabled(cacheable=true)
    public static List<Account> searchAccounts(
        String searchKey,
    Integer limitSize,
    String lastName,
    Id lastId
    ) {
        
        if (String.isBlank(searchKey)) {
            return new List<Account>();
        }
        
        String likeKey = '%' + searchKey + '%';
        
        if (lastName == null || lastId == null) {
            // First page
            return [
                SELECT Id, Name, AccountNumber, BillingState
                FROM Account
                WHERE Name LIKE :likeKey
                ORDER BY Name, Id
                LIMIT :limitSize
            ];
        } else {
            // Next pages
            return [
                SELECT Id, Name, AccountNumber, BillingState
                FROM Account
                WHERE Name LIKE :likeKey
                AND (
                    Name > :lastName OR
                    (Name = :lastName AND Id > :lastId)
                )
                ORDER BY Name, Id
                LIMIT :limitSize
            ];
        }
    }
}