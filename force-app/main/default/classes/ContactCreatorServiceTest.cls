@IsTest
private class ContactCreatorServiceTest {
    @IsTest
    static void testCreateContactSkipsInsertInTestContext() {
        Account acc = new Account(Name = 'Contact Creator Account');
        insert acc;
        
        Integer beforeCount = [SELECT COUNT() FROM Contact WHERE AccountId = :acc.Id];
        
        Contact returnedContact = ContactCreatorService.createContact('Skipped Contact', acc.Id);
        
        Integer afterCount = [SELECT COUNT() FROM Contact WHERE AccountId = :acc.Id];
        
        Assert.areEqual(beforeCount, afterCount, 'No Contact should be inserted in test context.');
        Assert.isNull(returnedContact.Id, 'Contact should not have an Id because insert is skipped.');
    }
}