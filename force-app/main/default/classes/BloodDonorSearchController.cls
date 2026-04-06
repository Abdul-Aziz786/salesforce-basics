public without sharing class BloodDonorSearchController {
    
    public Blood_Donor__c bloodDonor {get; set;}
    
    public List<Blood_Donor__c> donors {get; set;}
    
    public Integer limitSize = 10;
    public Integer offsetSize = 0;
    
    public BloodDonorSearchController() {
        bloodDonor = new Blood_Donor__c();
        donors = new List<Blood_Donor__c>();
    }
    
    public void searchDonors() {
        try {
            System.debug('Executing Query: ' + bloodDonor);
            
            String query = 'SELECT Name__c, Blood_Group__c, Phone__c, State__c, District__c ' +
                'FROM Blood_Donor__c WHERE Id != null';
            
            String selectedBloodGroup = bloodDonor.Blood_Group__c ;
            String selectedState = bloodDonor.State__c ;
            String selectedDistrict = bloodDonor.District__c ;
            
            if(String.isNotBlank(selectedBloodGroup)) {
                query += ' AND Blood_Group__c = :selectedBloodGroup';
            }
            
            if(String.isNotBlank(selectedState)) {
                query += ' AND State__c = :selectedState';
            }
            
            if(String.isNotBlank(selectedDistrict)) {
                query += ' AND District__c = :selectedDistrict';
            }
            
            query += ' LIMIT :limitSize OFFSET :offsetSize';
            
            donors = Database.query(query);
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            
        }
    }
    
    public void next() {
        offsetSize += limitSize;
        searchDonors();
    }
    
    public void previous() {
        offsetSize = Math.max(0, offsetSize - limitSize);
        searchDonors();
    }
    
    
}