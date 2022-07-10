/**
 * @author  Kevin Pujol
 * @version 1.0
 * @description Rest Service class to obtain a customer's related Product Information
 */
@RestResource(urlMapping='/ProductInformation/*')
global with sharing class ProductInformationRestService {

    @HttpGet
    global static ProductInformationHelper.ProductWrapper getProductInformation() {
        RestRequest request = RestContext.request;
        String contactExternalID = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        ProductInformationHelper.ProductWrapper productInfo;
        try{
            if(contactExternalID != null && contactExternalID != ''){
                Contact contact = ProductInformationRepository.getContactByExternalId(contactExternalID);
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
