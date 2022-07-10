# N26 Programming Challenge

Scratch org details:
* URL: https://customer-app-786-dev-ed.lightning.force.com/
* username: k.pujol.g@n26.com
* password: -4lRnwuewbehs

To load the costs and fees records follow these steps:
  1. Prepare three differen CSV files with the columns Product__c, Home_Country__c and Value__c (one for each type of cost/fee)
  2. Make sure to clean duplicates (same Product__c and Home_Country__c) for each object, otherwise the import will fail.
  3. Open an import tool such as Data Loader or the Salesforce Inspector Chrome extension and login to the org
  4. Select as destination object the Monthly_Cost__c, ATM_Fee__c or Replacement_Cost__c
  5. Paste the CSV rows and iport.

To test the **Product Information LWC** component follow these steps:

  1. Open the Case Lightning Record Page editor
  2. Drag and drop the productInformation custom component into the page. 
  3. Save and activate the page.
  4. Create or Update an existing Contact's Product__c and Home_Country__c fields
  5. Creat or open and existing Case
  6. Update the case Contact. Test scenatios: leave it empty, select a contact with product and country populated, select a countact without product and country

To test the **Product Information Rest Service** follow these steps:

  1. Open a Sandbox and deploy the metadata
  2. Create a Connected App with "Relax IP restrictions". Assign it to your profile. Add al IP ranges to your profiles (from 0.0.0.0 to 255.255.255.255).
  3. Create or Update a contact with an External_ID__c
  5. Open an API client (like Swagger or Postman) or the Terminal (with curl)
  6. Use your credentials and the client and secret from the Connected App.
  7. Send a request to the following endpoind, using your instance URL and appending the External_ID__c that you have used for the contact https://[your instance url]/services/apexrest/ProductInformation/[ExternalID]
  8. Test it for different contacts with different product and country information
