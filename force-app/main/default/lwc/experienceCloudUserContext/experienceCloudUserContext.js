import { LightningElement, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import USER_ID from '@salesforce/user/Id';
import CONTACT_ID_FIELD from '@salesforce/schema/User.ContactId';

const FIELDS = [CONTACT_ID_FIELD];

export default class ExperienceCloudUserContext extends LightningElement {
    contactId = '';

    @wire(getRecord, { recordId: USER_ID, fields: FIELDS })
    wiredUser({ data, error }) {
        if (data) {
            this.contactId = data?.fields?.ContactId?.value ?? '';
        } else if (error) {
            this.contactId = '';
        }
        this.registerPrechatHandler();
    }

    registerPrechatHandler() {
        window.addEventListener('onEmbeddedMessagingReady', () => {
            if (this.contactId && window.embeddedservice_bootstrap?.prechatAPI) {
                window.embeddedservice_bootstrap.prechatAPI.setHiddenPrechatFields({
                    Portal_Contact_Id: this.contactId
                });
            }
        });
    }
}