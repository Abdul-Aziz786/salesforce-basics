@isTest
private class CaseServiceTest {
    @isTest
    static void testGetCasesCreatedInLast3Days() {
        
        Case recentCase = new Case(
            Subject = 'Recent Case',
        Status = 'New',
        Origin = 'Phone' );
        insert recentCase;
        
        Case oldCase = new Case(
            Subject = 'Old Case',
        Status = 'New',
        Origin = 'Phone');
        insert oldCase;
        
        Test.setCreatedDate(oldCase.Id, Datetime.now().addDays(-5));
        
        Test.startTest();
        List<Case> recentCases = CaseService.getCasesCreatedInLast3Days();
        Test.stopTest();
        
        Set<Id> returnedCaseIds = new Set<Id>();
        for (Case c : recentCases) {
            returnedCaseIds.add(c.Id);
        }
        
        Assert.isTrue(returnedCaseIds.contains(recentCase.Id), 'Recent case should be returned.');
        Assert.isFalse(returnedCaseIds.contains(oldCase.Id), 'Old case should not be returned.');
    }
}