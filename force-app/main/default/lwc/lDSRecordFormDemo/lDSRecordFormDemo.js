import { LightningElement } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import ACCOUNT_OBJECT from "@salesforce/schema/Account";
import NAME_FIELD from "@salesforce/schema/Account.Name";
import INDUSTRY_FIELD from "@salesforce/schema/Account.Industry";
import ANNUAL_REVENUE_FIELD from "@salesforce/schema/Account.AnnualRevenue";

export default class LDSRecordFormDemo extends LightningElement {
  fieldList = [NAME_FIELD, INDUSTRY_FIELD, ANNUAL_REVENUE_FIELD];
  objectApiName = ACCOUNT_OBJECT;

  onSuccess(event) {
    console.log("On Success", event.target.dataset.state);

    const evt = new ShowToastEvent({
      title: "Success",
      message: `Account created: ${event.detail.id} - ${event.detail.fields.Name.value}`,
      variant: "success"
    });
    this.dispatchEvent(evt);
  }
}
