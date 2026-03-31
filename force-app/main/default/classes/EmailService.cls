public with sharing class EmailService {
    
    
    public class EmailRequest {
        @AuraEnabled public String toEmail { get; set; }
        @AuraEnabled public String subject { get; set; }
        @AuraEnabled public String body { get; set; }
        @AuraEnabled public String fromEmail { get; set; }
        @AuraEnabled public Id caseId { get; set; }
    }
    
    
    @AuraEnabled(cacheable=true)
    public static List<String> getFromEmails() {
        List<String> emails = new List<String>();
        
        User u = [SELECT Email FROM User WHERE Id = :UserInfo.getUserId()];
        emails.add(u.Email);
        
        for (OrgWideEmailAddress owe : [
            SELECT Address FROM OrgWideEmailAddress
        ]) {
            emails.add(owe.Address);
        }
        
        return emails;
    }
    
    
    @AuraEnabled
    public static void sendEmail(EmailRequest req) {
        System.debug('EmailRequest: ' + JSON.serialize(req));
        if (String.isBlank(req.toEmail)) {
            throw new AuraHandledException('Recipient email required');
        }
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        mail.setToAddresses(new List<String>{req.toEmail});
        mail.setSubject(req.subject);
        mail.setHtmlBody(req.body);
        
        
        mail.setWhatId(req.caseId);
        mail.setSaveAsActivity(true);
        
        
        List<OrgWideEmailAddress> oweList = [
            SELECT Id FROM OrgWideEmailAddress 
            WHERE Address = :req.fromEmail LIMIT 1
        ];
        
        if (!oweList.isEmpty()) {
            mail.setOrgWideEmailAddressId(oweList[0].Id);
        }
        
        Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{mail});
    }
}