/**
 * @author  Kevin Pujol
 * @version 1.0
 * @description This class includes rehusable methods and classes for both the ProductInformationController and the ProductInformationRestService
 */
global with sharing class ProductInformationHelper {
    global static void populateProductInformation(ProductWrapper productInfo, Contact contact){
        //All the following fields are required, they will never be null.
        productInfo.productName = contact.Product__c;
        productInfo.countryName = contact.Home_Country__c;
        Monthly_Cost__c monthlyCost = ProductInformationRepository.getMonthlyCost(contact.Product__c, contact.Home_Country__c);
        productInfo.monthlyCost = monthlyCost == null ? null : monthlyCost.Value__c;
        ATM_Fee__c atmFee = ProductInformationRepository.getATMFee(contact.Product__c, contact.Home_Country__c);
        productInfo.atmFee = atmFee == null ? null : atmFee.Value__c;
        Replacement_Cost__c replacementCost = ProductInformationRepository.getReplacementCost(contact.Product__c, contact.Home_Country__c);
        productInfo.replacementCost = replacementCost == null ? null : replacementCost.Value__c;
    }

    global class ProductWrapper{
        @AuraEnabled public String productName {get;set;}
        @AuraEnabled public String countryName {get;set;}
        @AuraEnabled public String monthlyCost {get;set;}
        @AuraEnabled public String atmFee {get;set;}
        @AuraEnabled public String replacementCost {get;set;}
    }
}
