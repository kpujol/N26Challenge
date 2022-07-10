import { LightningElement, api, wire, track } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import CONTACT_FIELD from '@salesforce/schema/Case.ContactId';
import getProductInformation from '@salesforce/apex/ProductInformationController.getProductInformation';

export default class ProductInformation extends LightningElement {
    @api recordId;
    @track error;
    @track contactId;
    @track hasProductInfo;
    @track productInfo;

    @wire(getRecord, { recordId: '$recordId', fields: [CONTACT_FIELD] })
    getCaseRecord({ error, data }) {
        if (data) {
            this.contactId = data.fields.ContactId.value;
            this.error = undefined;
        } else if (error) {
            this.contactId = undefined;
            this.error = error;
        }
    }
    
    @wire(getProductInformation, {contactId: '$contactId'})
    getProductInfo({ error, data }) {
        if (data) {
            this.hasProductInfo = true;
            this.productInfo = data;
            this.error = undefined;
        } else if (error) {
            let message;
            if (Array.isArray(error.body)) {
                message = error.body.map(e => e.message).join(', ');
            } else if (typeof error.body.message === 'string') {
                message = error.body.message;
            }
            this.hasProductInfo = false;
            this.productInfo = undefined;
            this.error = message;
        } else { //When there's no contact associate nor data or error returned
            this.hasProductInfo = false;
            this.productInfo = undefined;
            this.error = undefined;
        }
    }

    get hasProductInfo(){
        return this.hasProductInfo;
    }
}