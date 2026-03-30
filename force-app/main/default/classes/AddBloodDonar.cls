public class AddBloodDonar {
    public static void main() {
        Blood_Donor__c bd = new Blood_Donor__c();
        bd.Name__c = 'Donar 1';
        bd.Email__c = 'test2@email.com';
        bd.Blood_Group__c = 'A+';
        bd.Phone__c = '1234512341';
        
        insert bd;
        
        System.debug(bd.id);
    }
}