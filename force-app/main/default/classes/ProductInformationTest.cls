/**
 * @author  Kevin Pujol
 * @version 1.0
 * @description Test Class for the Product Information Controller and Repository logic and the ATM Fee, Monthly Cost and Replacement Cost duplication validations
 */
@isTest
public with sharing class ProductInformationTest {
    private static final String CONTACT_LAST_NAME = 'Andi';
    private static final String STANDARD_PRODUCT = 'Standard';
    private static final String BLACK_PRODUCT = 'Black';
    private static final String SPAIN = 'ES';
    
    @TestSetup public static void setUpData(){
        Contact contact = new Contact(
            LastName = CONTACT_LAST_NAME,
            Product__c = STANDARD_PRODUCT,
            Home_Country__c = SPAIN
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

    @isTest public static void testControllerForContactWithProductData(){
        Contact contact = ProductInformationRepository.getContactsByLastName(CONTACT_LAST_NAME).get(0);
        Test.startTest();
        ProductInformationHelper.ProductWrapper productInfo = ProductInformationController.getProductInformation(contact.Id);
        Test.stopTest();
        System.assertEquals('€ 1',productInfo.monthlyCost, 'The Cost per Calendar Month for this contact must be € 1');
        System.assertEquals('1%',productInfo.atmFee, 'The ATM Fee in other currencies for this contact must be 1%');
        System.assertEquals('£ 1',productInfo.replacementCost, 'The Cost per Card Replacement Cost for this contact must be £ 1');
    }

    @isTest public static void testInsertDuplicatedMonthlyCost(){
        Monthly_Cost__c monthlyCost = new Monthly_Cost__c(
            Product__c = STANDARD_PRODUCT,
            Home_Country__c = SPAIN,
            Value__c = '€ 2'        
        );
        Test.startTest();
        try{
            insert monthlyCost;
        } catch (exception e){
            Monthly_Cost__c standardESMonthlyCost = ProductInformationRepository.getMonthlyCost(STANDARD_PRODUCT, SPAIN);
            System.assertEquals('€ 1', standardESMonthlyCost.Value__c, 'Prevented an insert that would duplicate a record for the same product and country');      
        }
        Test.stopTest();
    }

    @isTest public static void testUpdateDuplicatedMonthlyCost(){
        Monthly_Cost__c monthlyCost = new Monthly_Cost__c(
            Product__c = BLACK_PRODUCT,
            Home_Country__c = SPAIN,
            Value__c = '€ 2'        
        );
        Test.startTest();
        insert monthlyCost;
        monthlyCost.Product__c = STANDARD_PRODUCT;
        try{
            update monthlyCost;
        } catch (exception e){
            Monthly_Cost__c standardESMonthlyCost = ProductInformationRepository.getMonthlyCost(STANDARD_PRODUCT, SPAIN);
            System.assertEquals('€ 1', standardESMonthlyCost.Value__c, 'Prevented an update that would duplicate a record for the same product and country');  
            Monthly_Cost__c blackESMonthlyCost = ProductInformationRepository.getMonthlyCost(BLACK_PRODUCT, SPAIN);
            System.assertEquals('€ 2', blackESMonthlyCost.Value__c, 'Prevented an update that would duplicate a record for the same product and country');   

        }
        Test.stopTest();
    }

    @isTest public static void testInsertDuplicatedATMFee(){
        ATM_Fee__c atmFee = new ATM_Fee__c(
            Product__c = STANDARD_PRODUCT,
            Home_Country__c = SPAIN,
            Value__c = '2%'        
        );
        Test.startTest();
        try{
            insert atmFee;
        } catch (exception e){
            ATM_Fee__c standardESATMFee = ProductInformationRepository.getATMFee(STANDARD_PRODUCT, SPAIN);
            System.assertEquals('1%', standardESATMFee.Value__c, 'Prevented an insert that would duplicate a record for the same product and country');      
        }
        Test.stopTest();
    }

    @isTest public static void testUpdateDuplicatedATMFee(){
        ATM_Fee__c atmFee = new ATM_Fee__c(
            Product__c = BLACK_PRODUCT,
            Home_Country__c = SPAIN,
            Value__c = '2%'        
        );
        Test.startTest();
        insert atmFee;
        atmFee.Product__c = STANDARD_PRODUCT;
        try{
            update atmFee;
        } catch (exception e){
            ATM_Fee__c standardESATMFee = ProductInformationRepository.getATMFee(STANDARD_PRODUCT, SPAIN);
            System.assertEquals('1%', standardESATMFee.Value__c, 'Prevented an update that would duplicate a record for the same product and country');  
            ATM_Fee__c blackESATMFee = ProductInformationRepository.getATMFee(BLACK_PRODUCT, SPAIN);
            System.assertEquals('2%', blackESATMFee.Value__c, 'Prevented an update that would duplicate a record for the same product and country');   

        }
        Test.stopTest();
    }

    @isTest public static void testInsertDuplicatedReplacementCost(){
        Replacement_Cost__c replacementCost = new Replacement_Cost__c(
            Product__c = STANDARD_PRODUCT,
            Home_Country__c = SPAIN,
            Value__c = '£ 2'        
        );
        Test.startTest();
        try{
            insert replacementCost;
        } catch (exception e){
            Replacement_Cost__c standardESReplacementCost = ProductInformationRepository.getReplacementCost(STANDARD_PRODUCT, SPAIN);
            System.assertEquals('£ 1', standardESReplacementCost.Value__c, 'Prevented an insert that would duplicate a record for the same product and country');      
        }
        Test.stopTest();
    }

    @isTest public static void testUpdateDuplicatedReplacementCost(){
        Replacement_Cost__c replacementCost = new Replacement_Cost__c(
            Product__c = BLACK_PRODUCT,
            Home_Country__c = SPAIN,
            Value__c = '£ 2'        
        );
        Test.startTest();
        insert replacementCost;
        replacementCost.Product__c = STANDARD_PRODUCT;
        try{
            update replacementCost;
        } catch (exception e){
            Replacement_Cost__c standardESReplacementCost = ProductInformationRepository.getReplacementCost(STANDARD_PRODUCT, SPAIN);
            System.assertEquals('£ 1', standardESReplacementCost.Value__c, 'Prevented an update that would duplicate a record for the same product and country');  
            Replacement_Cost__c blackESReplacementCost = ProductInformationRepository.getReplacementCost(BLACK_PRODUCT, SPAIN);
            System.assertEquals('£ 2', blackESReplacementCost.Value__c, 'Prevented an update that would duplicate a record for the same product and country');   

        }
        Test.stopTest();
    }


}
