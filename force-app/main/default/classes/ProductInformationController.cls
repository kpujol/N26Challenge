/**
 * @author  Kevin Pujol
 * @version 1.0
 * @description Controller layer for the Product Information LWC
 */
public with sharing class ProductInformationController {
    public ProductInformationController() {
    }

    @AuraEnabled(cacheable=true)
    public static ProductInformationHelper.ProductWrapper getProductInformation(Id contactId) {
        ProductInformationHelper.ProductWrapper productInfo;
        try{
            if(contactId != null){
                Contact contact = ProductInformationRepository.getContactById(contactId);
                if(contact != null){
                    productInfo = new ProductInformationHelper.ProductWrapper();
                    ProductInformationHelper.populateProductInformation(productInfo, contact);
                }
            }
        } catch (Exception e){
            System.debug('An exception has ocurred retrieving the product information: ' + e.getMessage());
            //To-do: send email with the error message
        }
        return productInfo;
    }
}
