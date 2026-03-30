public with sharing class ReceiptController {
    
    @AuraEnabled(cacheable=true)
    public static List<Receipt__c> getReceipts(Id contactId) {
        return [
            SELECT Id, Name, Amount__c, Mode_Of_Pay__c, Amount_Paid_Date__c
            FROM Receipt__c
            WHERE Contact__c = :contactId
            ORDER BY CreatedDate DESC
        ];
    }
}