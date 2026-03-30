import { LightningElement, api, wire } from "lwc";
import getReceipts from "@salesforce/apex/ReceiptController.getReceipts";
import { refreshApex } from "@salesforce/apex";
import { updateRecord } from "lightning/uiRecordApi";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

// LMS
import {
  subscribe,
  unsubscribe,
  MessageContext
} from "lightning/messageService";
import RECEIPT_CHANNEL from "@salesforce/messageChannel/receiptRefresh__c";

export default class ReceiptsContactRelated extends LightningElement {
  @api recordId;

  receipts = [];
  wiredResult;
  isLoading = false;

  subscription;
  draftValues = [];

  columns = [
    {
      label: "Receipt ID",
      fieldName: "recordUrl",
      type: "url",
      typeAttributes: {
        label: { fieldName: "Name" }, //  clickable text
        target: "_blank" //_self same tab (like standard UI)
      }
    },
    {
      label: "Amount",
      fieldName: "Amount__c",
      type: "currency",
      editable: true
    },
    {
      label: "Mode",
      fieldName: "Mode_Of_Pay__c",
      editable: true
    },
    {
      label: "Paid Date",
      fieldName: "Amount_Paid_Date__c",
      type: "date",
      editable: true
    }
  ];

  @wire(MessageContext)
  messageContext;

  @wire(getReceipts, { contactId: "$recordId" })
  wiredReceipts(result) {
    this.wiredResult = result;

    if (result.data) {
      this.receipts = result.data;
      this.receipts = this.receipts.map((receipt) => {
        return {
          ...receipt,
          recordUrl: `/${receipt.Id}`
        };
      });
    }
  }

  connectedCallback() {
    this.subscription = subscribe(
      this.messageContext,
      RECEIPT_CHANNEL,
      (message) => {
        console.log("LMS Event", message);

        if (message.refresh) {
          this.refreshList();
        }
      }
    );
  }

  refreshList() {
    this.isLoading = true;

    refreshApex(this.wiredResult).then(() => {
      this.isLoading = false;
    });
  }

  handleSave(event) {
    const records = event.detail.draftValues;
    console.log("Edited Records", records);

    const recordInputs = records.map((draft) => {
      return { fields: { ...draft } };
    });
    this.isLoading = true;
    Promise.all(recordInputs.map((record) => updateRecord(record)))
      .then(() => {
        this.dispatchEvent(
          new ShowToastEvent({
            title: "Success",
            message: "Records updated",
            variant: "success"
          })
        );

        this.draftValues = [];

        return refreshApex(this.wiredResult);
      })
      .catch((error) => {
        this.dispatchEvent(
          new ShowToastEvent({
            title: "Error",
            message: error.body.message,
            variant: "error"
          })
        );
      })
      .finally(() => {
        this.isLoading = false;
      });
  }
  disconnectedCallback() {
    if (this.subscription) {
      unsubscribe(this.subscription);
      this.subscription = null;
    }
  }
}
