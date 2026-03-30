trigger CustomerCTrigger on Customer__c (after insert) {
    CaseStudyHelper.addToAccountTeam(Trigger.new);
}