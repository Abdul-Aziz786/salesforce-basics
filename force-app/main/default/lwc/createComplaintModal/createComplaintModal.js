import LightningModal from "lightning/modal";

import { api, wire } from "lwc";
import { createRecord } from "lightning/uiRecordApi";
import { getObjectInfo, getPicklistValues } from "lightning/uiObjectInfoApi";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

import COMPLAINT_OBJECT from "@salesforce/schema/Complaint__c";
import NAME_FIELD from "@salesforce/schema/Complaint__c.Name";
import TYPE_FIELD from "@salesforce/schema/Complaint__c.Complaint_Type__c";
import COMMENTS_FIELD from "@salesforce/schema/Complaint__c.Comments__c";
import RESOLUTION_FIELD from "@salesforce/schema/Complaint__c.Resolution__c";
import ACCOUNT_FIELD from "@salesforce/schema/Complaint__c.Account__c";
import CASE_FIELD from "@salesforce/schema/Complaint__c.Case__c";

export default class ComplaintModal extends LightningModal {
  @api recordId;
  @api objectApiName;
  @api accountId;
  @api accountName;

  complaintType;
  comments;
  resolution;
  typeOptions = [];

  isLoading = false;

  @wire(getObjectInfo, { objectApiName: COMPLAINT_OBJECT })
  objectInfo;

  @wire(getPicklistValues, {
    recordTypeId: "$objectInfo.data.defaultRecordTypeId",
    fieldApiName: TYPE_FIELD
  })
  wiredPicklist({ data, error }) {
    if (data) {
      this.typeOptions = data.values.map((item) => ({
        label: item.label,
        value: item.value
      }));
    } else if (error) {
      console.error(error);
    }
  }

  handleType(e) {
    this.complaintType = e.detail.value;
  }

  handleComments(e) {
    this.comments = e.target.value;
  }

  handleResolution(e) {
    this.resolution = e.target.value;
  }

  async handleSave() {
    try {
      if (!this.complaintType || !this.comments) {
        this.showToast("Error", "Required fields missing", "error");
        return;
      }

      if (this.objectApiName === "Case") {
        this.accountId = this.getCaseAccountId();
      } else {
        this.accountId = this.recordId;
      }

      const fields = {};

      fields[TYPE_FIELD.fieldApiName] = this.complaintType;
      fields[COMMENTS_FIELD.fieldApiName] = this.comments;
      fields[RESOLUTION_FIELD.fieldApiName] = this.resolution;
      fields[ACCOUNT_FIELD.fieldApiName] = this.accountId;

      if (this.objectApiName === "Case") {
        fields[CASE_FIELD.fieldApiName] = this.recordId;
      }

      fields[NAME_FIELD.fieldApiName] = this.complaintName();

      const recordInput = {
        apiName: COMPLAINT_OBJECT.objectApiName,
        fields: fields
      };
      this.isLoading = true;
      await createRecord(recordInput);

      this.showToast("Success", "Complaint Created", "success");

      this.close("save");
    } catch (error) {
      this.showToast("Error", error.body.message, "error");
    } finally {
      this.isLoading = false;
    }
  }
  complaintName() {
    let name = "";
    name = this.accountName ? this.accountName : "NA";
    name += ` - ${this.complaintType}`;
    name += ` - ${this.getRandom(1, 100)}`;
    return name;
  }

  showToast(title, message, variant) {
    this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
  }
  getRandom(min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
  }

  getCaseAccountId() {
    return this.accountId;
  }

  handleCancel() {
    this.close("cancel");
  }
}

// import LightningModal from "lightning/modal";
// import { api } from "lwc";

// export default class CreateComplaintModal extends LightningModal {
//   @api accountId;
//   objectApiName = "Complaint__c";
//   handleCancel() {
//     this.close("cancel");
//   }

//   handleSave() {
//     this.close("save");
//   }
// }
