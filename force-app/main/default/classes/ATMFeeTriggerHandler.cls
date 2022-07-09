/**
 * @author  Kevin Pujol
 * @version 1.0
 * @description Trigger Handler to handle the logic when a ATM Fee is created, updated or deleted
 */
public with sharing class ATMFeeTriggerHandler implements TriggerInterface{

    public ATMFeeTriggerHandler() {
    }

    public void bulkBefore() {
    }

    public void bulkAfter() {
    }

    public void beforeInsert(SObject so) {
        ATM_Fee__c fee = (ATM_Fee__c) so;
        fee.ATM_Fee_PK__c = fee.Product__c + fee.Home_Country__c;
    }

    public void beforeUpdate(SObject oldSo, SObject so) {
        ATM_Fee__c fee = (ATM_Fee__c) so;
        ATM_Fee__c oldFee = (ATM_Fee__c) oldSo;
        if(fee.Product__c != oldFee.Product__c || fee.Home_Country__c != oldFee.Home_Country__c){
            fee.ATM_Fee_PK__c = fee.Product__c + oldFee.Home_Country__c;
        }
    }

    public void beforeDelete(SObject so) {
    }

    public void afterInsert(SObject so) {
    }
    
    public void afterUpdate(SObject oldSo, SObject so) {
    }

    public void afterDelete(SObject so) {
    }
 
    public void andFinally() {
    }

}