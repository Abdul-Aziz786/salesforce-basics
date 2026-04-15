@RestResource(urlMapping='/BloodDonor/*')
global with sharing class BloodDonorRestController {
    
    global with sharing class ResponseWrapper {
        public Boolean success;
        public String message;
        public List<Blood_Donor__c> data;
    }
    
    @HttpGet
    global static ResponseWrapper getBloodDonors() {
        
        final ResponseWrapper res = new ResponseWrapper();
        try {
            final RestRequest req = RestContext.request;
            final String bloodGroup = req.params.get('bloodGroup');
            final String location = req.params.get('location');
            System.debug('bloodGroup: ' + bloodGroup);
            System.debug('location: ' + location);
            System.debug(req);
            
            if(String.isBlank(bloodGroup) || String.isBlank(location)) {
                res.message = 'Please provide both bloodGroup and location parameters.';
                return res;
            }
            
            res.data = [SELECT Id, Name, Blood_Group__c, Last_Donated_Date__c,District__c
                FROM Blood_Donor__c 
                WHERE Blood_Group__c = :bloodGroup AND District__c = :location];
            res.message = 'Blood donors fetched successfully.';
        } catch (Exception e) {
            res.message = 'Error fetching blood donors: ' + e.getMessage();
            res.data = null;
        }
        
        return    res;
        
    }
    
    @HttpPost
    global static ResponseWrapper createBloodDonor(String name, String email, String bloodGroup,String state,String district) {
        ResponseWrapper res = new ResponseWrapper();
        if(email == null || !email.contains('@')) {
            res.success = false;
            res.message = 'Invalid email address.';
            return res;
        }
        try {
            Blood_Donor__c newDonor = new Blood_Donor__c(
                Name__c = name,
            Email__c = email,
            Blood_Group__c = bloodGroup,
            District__c = district,
            State__c = state
                );
            insert newDonor;
            
            res.success = true;
            res.message = 'Blood donor created successfully.';
            res.data = new List<Blood_Donor__c>{newDonor};
        } catch (Exception e) {
            res.success = false;
            res.message = 'Error creating blood donor: ' + e.getMessage();
            res.data = null;
        }
        return res;
    }
    
    @HttpPut
    global static ResponseWrapper updateBloodDonor(String email, String name, String bloodGroup,String state,String district) {
        ResponseWrapper res = new ResponseWrapper();
        if(email == null || !email.contains('@')) {
            res.success = false;
            res.message = 'Invalid email address.';
            return res;
        }
        try {
            List<Blood_Donor__c> donorsToUpdate = [SELECT Id FROM Blood_Donor__c WHERE Email__c = :email LIMIT 1];
            if(donorsToUpdate.isEmpty()) {
                res.success = false;
                res.message = 'No blood donor found with the provided email.';
                return res;
            }
            Blood_Donor__c donor = donorsToUpdate[0];
            donor.Name__c = name;
            donor.Blood_Group__c = bloodGroup;
            donor.District__c = district;
            donor.State__c = state;
            update donor;
            
            res.success = true;
            res.message = 'Blood donor updated successfully.';
            res.data = new List<Blood_Donor__c>{donor};
        } catch (Exception e) {
            res.success = false;
            res.message = 'Error updating blood donor: ' + e.getMessage();
            res.data = null;
        }
        return res;
    }
    
    @HttpDelete
    global static ResponseWrapper deleteBloodDonor() {
        ResponseWrapper res = new ResponseWrapper();
        final RestRequest req = RestContext.request;
        final String email = req.params.get('email');
        if(email == null || !email.contains('@')) {
            res.success = false;
            res.message = 'Invalid email address.';
            return res;
        }
        try {
            List<Blood_Donor__c> donorsToDelete = [SELECT Id FROM Blood_Donor__c WHERE Email__c = :email LIMIT 1];
            if(donorsToDelete.isEmpty()) {
                res.success = false;
                res.message = 'No blood donor found with the provided email.';
                return res;
            }
            delete donorsToDelete;
            
            res.success = true;
            res.message = 'Blood donor(s) deleted successfully.';
        } catch (Exception e) {
            res.success = false;
            res.message = 'Error deleting blood donor: ' + e.getMessage();
        }
        return res;
    }
    
}