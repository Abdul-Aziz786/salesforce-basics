import { api, LightningElement, wire } from "lwc";
import getComplaints from "@salesforce/apex/ComplaintController.getComplaints";
import { refreshApex } from "@salesforce/apex";

export default class AccountRelatedComplaintList extends LightningElement {
  @api recordId;
  @api objectApiName;
  wireComplaints;
  complaints = [];

  columns = [
    { label: "Name", fieldName: "Name" },
    { label: "Comments", fieldName: "Comments__c" },
    { label: "Complaint Type", fieldName: "Complaint_Type__c" },
    { label: "Case", fieldName: "Case__c" },
    { label: "Resolution", fieldName: "Resolution__c" }
  ];

  @wire(getComplaints, { accountId: "$recordId" })
  wiredComplaints(response) {
    this.wireComplaints = response;
    if (response.data) {
      this.complaints = response.data;
    } else if (response.error) {
      this.complaints = [];
    }
  }
  handleComplaintCreated() {
    return refreshApex(this.wireComplaints);
  }
}
