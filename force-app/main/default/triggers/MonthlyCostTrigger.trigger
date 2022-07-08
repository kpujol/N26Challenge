trigger MonthlyCostTrigger on Monthly_Cost__c (after delete, after insert, after update, before delete, before insert, before update) {
    TriggerFactory.createAndExecuteHandler(MonthlyCostTriggerHandler.class);
}