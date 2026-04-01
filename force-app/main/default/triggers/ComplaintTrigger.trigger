trigger ComplaintTrigger on Complaint__c (before insert) {
    
    
    // for (Complaint__c complaint : Trigger.new) {
        //     if (complaint.Account__c != null) {
            //         complaint.Name = complaint.Account__c + ' - ' + complaint.Complaint_Type__c + ' - ' + Datetime.now().format('yyyy-MM-dd HH:mm:ss');
        //     }
    // }
    
}