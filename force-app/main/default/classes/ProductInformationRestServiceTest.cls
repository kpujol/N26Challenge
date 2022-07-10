/**
 * @author  Kevin Pujol
 * @version 1.0
 * @description Test class for the ProductInformationRestService
 */
@isTest
public with sharing class ProductInformationRestServiceTest {
    private static final String CONTACT_LAST_NAME = 'Andi';
    private static final String CONTACT_EXTERNAL_ID = '482625235';
    private static final String STANDARD_PRODUCT = 'Standard';
    private static final String BLACK_PRODUCT = 'Black';
    private static final String SPAIN = 'ES';
    
    @TestSetup public static void setUpData(){
        Contact contact = new Contact(
            LastName = CONTACT_LAST_NAME,
            Product__c = STANDARD_PRODUCT,
            Home_Country__c = SPAIN,
            External_ID__c = CONTACT_EXTERNAL_ID
        );
        insert contact;
        Case caseRecord = new Case(
            origin = Case.Origin.getDescribe().getPicklistValues().get(0).getValue(),
            status = 'New'
        );
        insert caseRecord;
        Monthly_Cost__c monthlyCost = new Monthly_Cost__c(
            Product__c = STANDARD_PRODUCT,
            Home_Country__c = SPAIN,
            Value__c = '€ 1'        
        );
        insert monthlyCost;
        ATM_Fee__c atmFee = new ATM_Fee__c(
            Product__c = STANDARD_PRODUCT,
            Home_Country__c = SPAIN,
            Value__c = '1%'        
        );
        insert atmFee;
        Replacement_Cost__c replacementCost = new Replacement_Cost__c(
            Product__c = STANDARD_PRODUCT,
            Home_Country__c = SPAIN,
            Value__c = '£ 1'        
        );
        insert replacementCost;
    }

    @isTest static void retriveCustomerProductInformation(){
        Test.startTest();
        RestRequest request = new RestRequest();
        request.requestURI = '/services/apexrest/ProductInformation/'+CONTACT_EXTERNAL_ID; 
        request.httpMethod = 'GET';
        RestContext.request = request;
        ProductInformationHelper.ProductWrapper productInfo = ProductInformationRestService.getProductInformation();
        Test.stopTest();
        System.assertEquals('€ 1',productInfo.monthlyCost, 'The Cost per Calendar Month for this contact must be € 1');
        System.assertEquals('1%',productInfo.atmFee, 'The ATM Fee in other currencies for this contact must be 1%');
        System.assertEquals('£ 1',productInfo.replacementCost, 'The Cost per Card Replacement Cost for this contact must be £ 1');
    }

    @isTest static void retriveNullCustomerProductInformation(){
        Test.startTest();
        RestRequest request = new RestRequest();
        request.requestURI = '/services/apexrest/ProductInformation/'+'1234'; 
        request.httpMethod = 'GET';
        RestContext.request = request;
        ProductInformationHelper.ProductWrapper productInfo = ProductInformationRestService.getProductInformation();
        Test.stopTest();
        System.assertEquals(null,productInfo,'The ProductInfo is null for the given External ID');
    }
}