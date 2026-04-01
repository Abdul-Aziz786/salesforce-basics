public with sharing class ComplaintController {
    @AuraEnabled(cacheable=true)
    public static List<Complaint__c> getComplaints( Id accountId) {
        return [SELECT Id, Name,Comments__c,Complaint_Type__c,Case__c,Resolution__c 
                FROM Complaint__c 
                WHERE Account__c = :accountId
                ORDER BY CreatedDate DESC];
    }
}