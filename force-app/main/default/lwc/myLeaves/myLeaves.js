import { LightningElement } from "lwc";
import { wire } from "lwc";
import getMyLeaves from "@salesforce/apex/LeaveRequestController.getMyLeaves";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { refreshApex } from "@salesforce/apex";
import Id from "@salesforce/user/Id";

const COLUMNS = [
  {
    label: "Request Id",
    fieldName: "Name",
    cellAttributes: { class: { fieldName: "cellClass" } }
  },
  {
    label: "From Date",
    fieldName: "From_Date__c",
    cellAttributes: { class: { fieldName: "cellClass" } }
  },
  {
    label: "To Date",
    fieldName: "To_Date__c",
    cellAttributes: { class: { fieldName: "cellClass" } }
  },
  {
    label: "Reason",
    fieldName: "Reason__c",
    cellAttributes: { class: { fieldName: "cellClass" } }
  },
  {
    label: "Status",
    fieldName: "Status__c",
    cellAttributes: { class: { fieldName: "cellClass" } }
  },
  {
    label: "Manager Comment",
    fieldName: "Manager_Comment__c",
    cellAttributes: { class: { fieldName: "cellClass" } }
  },
  {
    type: "button",
    typeAttributes: {
      label: "Edit",
      name: "Edit",
      title: "Edit",
      value: "edit",
      disabled: { fieldName: "isEditDisabled" }
    },
    cellAttributes: { class: { fieldName: "cellClass" } }
  }
];
export default class MyLeaves extends LightningElement {
  showModalPopup = false;
  recordId = "";
  objectApiName = "LeaveRequest__c";
  currentUserId = Id;

  columns = COLUMNS;
  myLeavesWireResult;
  myLeaves = [];
  @wire(getMyLeaves)
  wiredMyLeaves(result) {
    this.myLeavesWireResult = result;
    if (result.data) {
      this.myLeaves = result.data.map((a) => ({
        ...a,
        cellClass:
          a.Status__c == "Approved"
            ? "slds-theme_success"
            : a.Status__c == "Rejected"
              ? "slds-theme_warning"
              : "",
        isEditDisabled: a.Status__c != "Pending"
      }));
    }
    if (result.error) {
      console.log("Error occured while fetching my leaves- ", result.error);
    }
  }

  get noRecordsFound() {
    return this.myLeaves.length == 0;
  }

  rowActionHandler(event) {
    this.recordId = event.detail.row.Id;
    this.showModalPopup = true;
  }
  newRequestClickHandler() {
    this.showModalPopup = true;
    this.recordId = "";
  }
  popupCloseHandler() {
    this.showModalPopup = false;
  }

  successHandler(event) {
    this.showModalPopup = false;
    this.showToast("Data saved successfully");
    refreshApex(this.myLeavesWireResult);

    const refreshEvent = new CustomEvent("refreshleaverequests");
    this.dispatchEvent(refreshEvent);
  }

  submitHandler(event) {
    event.preventDefault();

    const fields = { ...event.detail.fields };
    fields.Status__c = "Pending";
    console.log("fields- ", fields);

    const fromDate = new Date(fields.From_Date__c);
    const toDate = new Date(fields.To_Date__c);
    const today = new Date();

    if (fromDate > toDate) {
      this.showToast(
        "From date should not be grater then to date",
        "Error",
        "error"
      );
    } else if (today > fromDate) {
      this.showToast(
        "From date should not be less then Today",
        "Error",
        "error"
      );
    } else {
      this.refs.leaveRequestForm.submit(fields);
    }
  }

  showToast(message, title = "success", variant = "success") {
    const event = new ShowToastEvent({
      title,
      message,
      variant
    });
    this.dispatchEvent(event);
  }
}
