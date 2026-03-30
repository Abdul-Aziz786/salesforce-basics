trigger OpportunityLineItemTrigger on OpportunityLineItem (after insert,
after update,
after delete) {
    
    if (Trigger.isInsert) {
        CaseStudyHelper.updateOpportunityWithProductCodes(Trigger.new);
    } else if (Trigger.isUpdate) {
        CaseStudyHelper.updateOpportunityWithProductCodes(Trigger.new);
    } else if (Trigger.isDelete) {
        CaseStudyHelper.updateOpportunityWithProductCodes(Trigger.old);
    }
    
}