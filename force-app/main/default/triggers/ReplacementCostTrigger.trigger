trigger ReplacementCostTrigger on Replacement_Cost__c (after delete, after insert, after update, before delete, before insert, before update) {
    TriggerFactory.createAndExecuteHandler(ReplacementCostTriggerHandler.class);
}