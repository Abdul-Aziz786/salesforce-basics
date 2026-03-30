@IsTest
public class AccountTriggerTest {
    
    @testSetup
    static void makeData(){
        Account acc = new Account(Name='Test Account', Phone='1234567890');
        insert acc;
        Contact con1 = new Contact(FirstName='John', LastName='Doe', AccountId=acc.Id, Phone='1234567890');
        Contact con2 = new Contact(FirstName='Jane', LastName='Doe', AccountId=acc.Id, Phone='1234567890');
        insert new List<Contact>{con1, con2};
    }
    
    @isTest
    static void testPhoneNumberUpdate() {
        Test.startTest();
        Account acc = [SELECT Id, Phone FROM Account  LIMIT 1];
        acc.Phone = '0987654321';
        update acc;
        Test.stopTest();
        List<Contact> contacts = [SELECT Id, Phone FROM Contact WHERE AccountId = :acc.Id];
        for(Contact con : contacts) {
            System.assertEquals('0987654321', con.Phone, 'Contact phone number not Updated');
        }
    }
}