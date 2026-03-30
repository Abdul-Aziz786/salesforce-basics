trigger ContactRelationshipTrigger on Contact_Relationship__c (before update) {
    CaseStudyHelper.updateContactRelationshipOwner(Trigger.new, Trigger.oldMap);
}