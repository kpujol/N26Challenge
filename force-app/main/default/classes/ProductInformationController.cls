/**
 * @author  Kevin Pujol
 * @version 1.0
 * @description Controller layer for the Product Information LWC
 */
public with sharing class ProductInformationController {
    public ProductInformationController() {
    }

    @AuraEnabled(cacheable=true)
    public static ProductWrapper getProductInformation(Id contactId) {
        ProductWrapper productInfo;
        try{
            
            if(contactId != null){
                Contact contact = ProductInformationRepository.getContact(contactId);
                if(contact != null){
                    productInfo = new ProductWrapper();
                    populateProductInfo(productInfo, contact);
                }
            }
        } catch (Exception e){
            System.debug('An exception has ocurred retrieving the product information: ' + e.getMessage());
            //To-do: send email with the error message
        }
        return productInfo;
    }

    private static void populateProductInfo(ProductWrapper productInfo, Contact contact){
        //All the following fields are required, no need to check if they are null.
        productInfo.productName = contact.Product__c;
        productInfo.countryName = contact.Home_Country__c;
        Monthly_Cost__c monthlyCost = ProductInformationRepository.getMonthlyCost(contact.Product__c, contact.Home_Country__c);
        productInfo.monthlyCost = monthlyCost == null ? null : monthlyCost.Value__c;
        ATM_Fee__c atmFee = ProductInformationRepository.getATMFee(contact.Product__c, contact.Home_Country__c);
        productInfo.atmFee = atmFee == null ? null : atmFee.Value__c;
        Replacement_Cost__c replacementCost = ProductInformationRepository.getReplacementCost(contact.Product__c, contact.Home_Country__c);
        productInfo.replacementCost = replacementCost == null ? null : replacementCost.Value__c;
    }

    public class ProductWrapper{
        @AuraEnabled public String productName;
        @AuraEnabled public String countryName;
        @AuraEnabled public String monthlyCost;
        @AuraEnabled public String atmFee;
        @AuraEnabled public String replacementCost;
    }
}
