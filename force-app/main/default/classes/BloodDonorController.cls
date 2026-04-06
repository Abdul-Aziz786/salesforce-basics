public  class BloodDonorController {
    
    public Blood_Donor__c bloodDonor { get; set; }
    
    public BloodDonorController() {
        bloodDonor = new Blood_Donor__c();
    }
    
    public PageReference saveBloodDonor() {
        
        ApexPages.getMessages().clear();
        
        try {
            
            // final Integer age = Date.today().year() - bloodDonor.DOB__c.year();
            // if (bloodDonor.DOB__c != null &&
            // age < 18) {
                
                //     ApexPages.addMessage(new ApexPages.Message(
                //         ApexPages.Severity.ERROR,
                //     'You must be at least 18 years old.'
                //         ));
                //     return null;
            // }
            
            
            // if ([SELECT COUNT() FROM Blood_Donor__c 
            //      WHERE Email__c = :bloodDonor.Email__c] > 0) {
                
                //     ApexPages.addMessage(new ApexPages.Message(
                //         ApexPages.Severity.ERROR,
                //     'This email is already registered.'
                //         ));
                //     return null;
            // }
            
            insert bloodDonor;
            
            sendEmailAsync(bloodDonor.Email__c, bloodDonor.Name__c);
            
            ApexPages.addMessage(new ApexPages.Message(
                ApexPages.Severity.CONFIRM,
            'Registration successful! Confirmation email sent.'
                ));
            
            bloodDonor = new Blood_Donor__c();
            
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(
                ApexPages.Severity.ERROR,
            e.getMessage()
                ));
        }
        
        return null;
    }
    
    @future
    public static void sendEmailAsync(String email, String name) {
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        mail.setToAddresses(new String[]{email});
        mail.setSubject('Blood Donor Registration');
        
        mail.setPlainTextBody(
            'Hello ' + name + ',\n\n' +
            'Thank you for registering as a blood donor.\n\n' +
            'We will contact you when needed.'
            );
        
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}