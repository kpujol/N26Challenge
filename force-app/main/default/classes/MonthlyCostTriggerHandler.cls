/**
 * @author  Kevin Pujol
 * @version 1.0
 * @description Trigger Handler to handle the logic when a Monthly Cost is created, updated or deleted
 */
public with sharing class MonthlyCostTriggerHandler implements TriggerInterface{

    public MonthlyCostTriggerHandler() {
    }

    public void bulkBefore() {
    }

    public void bulkAfter() {
    }

    public void beforeInsert(SObject so) {
        Monthly_Cost__c cost = (Monthly_Cost__c) so;
        cost.Monthly_Cost_PK__c = cost.Product__c + cost.Home_Country__c;
    }

    public void beforeUpdate(SObject oldSo, SObject so) {
        Monthly_Cost__c cost = (Monthly_Cost__c) so;
        Monthly_Cost__c oldCost = (Monthly_Cost__c) oldSo;
        if(cost.Product__c != oldCost.Product__c || cost.Home_Country__c != oldCost.Home_Country__c){
            cost.Monthly_Cost_PK__c = cost.Product__c + cost.Home_Country__c;
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