import { api, LightningElement, wire } from "lwc";
import ComplaintModal from "c/createComplaintModal";
import { getRecord } from "lightning/uiRecordApi";
import AccountIDFIELD from "@salesforce/schema/Case.AccountId";
import AccountNameFIELD from "@salesforce/schema/Case.Account.Name";
import ACCOUNT_NAME from "@salesforce/schema/Account.Name";

export default class CreateComplaint extends LightningElement {
  @api recordId;
  @api objectApiName;
  accountId;
  accountName;
  get recordIdForWire() {
    return this.recordId;
  }
  get fields() {
    return this.objectApiName === "Case"
      ? [AccountIDFIELD, AccountNameFIELD]
      : [ACCOUNT_NAME];
  }

  @wire(getRecord, {
    recordId: "$recordIdForWire",
    fields: "$fields"
  })
  wiredCase({ data, error }) {
    console.log("Case Data", data);

    if (data) {
      if (this.objectApiName === "Case") {
        this.accountId = data.fields.AccountId.value;
        this.accountName = data.fields.Account.displayValue;
      } else if (this.objectApiName === "Account") {
        this.accountName = data.fields.Name.value;
      }
    } else if (error) {
      console.error("Error fetching record data", error);
    }
  }

  async handleClick() {
    const result = await ComplaintModal.open({
      size: "small",
      accountId: this.accountId,
      accountName: this.accountName,
      recordId: this.recordId,
      objectApiName: this.objectApiName
    });
    if (result === "save") {
      this.dispatchEvent(new CustomEvent("complaintcreated"));
    } else if (result === "cancel") {
      console.log("Cancel button clicked");
    }
  }
}
