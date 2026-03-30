import { LightningElement, api, wire } from "lwc";
import getContactsByAccountId from "@salesforce/apex/ContactController.getContactsByAccountId";

export default class AccountRelatedContacts extends LightningElement {
  columns = [
    { label: "Id", fieldName: "Id" },
    { label: "Last Name", fieldName: "LastName" },
    { label: "Email", fieldName: "Email" }
  ];

  @api recordId;
  contacts;

  get hasContacts() {
    return this.contacts && this.contacts.length > 0;
  }

  @wire(getContactsByAccountId, { accountId: "$recordId" })
  wiredContacts({ error, data }) {
    console.log("Wired Contacts - ", data);
    console.log("Wired Error - ", error);

    if (data) {
      this.contacts = data;
    } else if (error) {
    }
  }
}
