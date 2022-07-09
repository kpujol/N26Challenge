trigger ATMFeeTrigger on ATM_Fee__c (after delete, after insert, after update, before delete, before insert, before update) {
    TriggerFactory.createAndExecuteHandler(ATMFeeTriggerHandler.class);
}