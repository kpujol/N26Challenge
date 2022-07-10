/**
 * @author  Kevin Pujol
 * @version 1.0
 * @description Data access layer for the Product Information LWC
 */
public with sharing class ProductInformationRepository {
    public static Contact getContactById (Id contactId){
        Contact contact = null;
        List<Contact> contacts = [SELECT Id, Product__c, Home_Country__c FROM Contact WHERE Id =: contactId];
        if(!contacts.isEmpty()){
            contact = contacts.get(0);
        }
        return contact;
    }

    public static Contact getContactByExternalId (String externalId){
        Contact contact = null;
        List<Contact> contacts = [SELECT Id, Product__c, Home_Country__c FROM Contact WHERE External_ID__c =: externalId];
        if(!contacts.isEmpty()){
            contact = contacts.get(0);
        }
        return contact;
    }

    public static List<Contact> getContactsByLastName (String lastName){
        List<Contact> contacts = new List<Contact>();
        return [SELECT Id FROM Contact WHERE LastName =: lastName];
    }

    public static Monthly_Cost__c getMonthlyCost (String product, String country){
        Monthly_Cost__c monthlyCost = null;
        List<Monthly_Cost__c> monthlyCosts = [SELECT Id, Value__c FROM Monthly_Cost__c WHERE Product__c =: product AND Home_Country__c =: country];
        if(!monthlyCosts.isEmpty()){
            monthlyCost = monthlyCosts.get(0);
        }
        return monthlyCost;
    }

    public static ATM_Fee__c getATMFee (String product, String country){
        ATM_Fee__c atmFee = null;
        List<ATM_Fee__c> atmFees = [SELECT Id, Value__c FROM ATM_Fee__c WHERE Product__c =: product AND Home_Country__c =: country];
        if(!atmFees.isEmpty()){
            atmFee = atmFees.get(0);
        }
        return atmFee;
    }

    public static Replacement_Cost__c getReplacementCost (String product, String country){
        Replacement_Cost__c replacementCost = null;
        List<Replacement_Cost__c> replacementCosts = [SELECT Id, Value__c FROM Replacement_Cost__c WHERE Product__c =: product AND Home_Country__c =: country];
        if(!replacementCosts.isEmpty()){
            replacementCost = replacementCosts.get(0);
        }
        return replacementCost;
    }
}
