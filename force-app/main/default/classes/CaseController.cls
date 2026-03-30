public with sharing class CaseController {
    @AuraEnabled
    public static Id cloneCase(Id caseId) {
        try {
            Case originalCase = [SELECT Subject, Description, Status FROM Case WHERE Id = :caseId LIMIT 1];
            Case clonedCase = originalCase.clone(false, true, false, false);
            
            insert clonedCase;
            return clonedCase.Id;
        } catch(Exception e) {
            System.debug('Error cloning case: ' + e.getMessage());
            System.debug(Limits.getLimitDmlStatements() + ' DML statements used.');
            throw new AuraHandledException(e.getMessage());
        }
    }
}