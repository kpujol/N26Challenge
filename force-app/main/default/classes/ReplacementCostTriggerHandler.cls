/**
 * @author  Kevin Pujol
 * @version 1.0
 * @description Trigger Handler to handle the logic when a Replacement Cost is created, updated or deleted
 */
public with sharing class ReplacementCostTriggerHandler implements TriggerInterface{

    public ReplacementCostTriggerHandler() {
    }

    public void bulkBefore() {
    }

    public void bulkAfter() {
    }

    public void beforeInsert(SObject so) {
        Replacement_Cost__c cost = (Replacement_Cost__c) so;
        cost.Replacement_Cost_PK__c = cost.Product__c + cost.Home_Country__c;
    }

    public void beforeUpdate(SObject oldSo, SObject so) {
        Replacement_Cost__c cost = (Replacement_Cost__c) so;
        Replacement_Cost__c oldCost = (Replacement_Cost__c) oldSo;
        if(cost.Product__c != oldCost.Product__c || cost.Home_Country__c != oldCost.Home_Country__c){
            cost.Replacement_Cost_PK__c = cost.Product__c + cost.Home_Country__c;
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