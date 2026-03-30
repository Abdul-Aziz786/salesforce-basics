public with sharing class CaseController {
    @AuraEnabled(cacheable=true)
    public static Id cloneCase(Id caseId) {
        try {
            Case originalCase = [SELECT Subject, Description, Status FROM Case WHERE Id = :caseId];
            Case clonedCase = originalCase.clone(false, true, false, false);
            insert clonedCase;
            return clonedCase.Id;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}