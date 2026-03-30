import { LightningElement, api, wire } from "lwc";

import { ShowToastEvent } from "lightning/platformShowToastEvent";
// import { RefreshEvent } from "lightning/refresh";
import { publish, MessageContext } from "lightning/messageService";
import RECEIPT_CHANNEL from "@salesforce/messageChannel/receiptRefresh__c";
export default class CreateRecipt extends LightningElement {
  @api recordId;
  @wire(MessageContext)
  messageContext;

  defaultValues = {
    modeOfPay: "Cash",
    paymentDate: new Date().toISOString().split("T")[0]
  };

  isModalOpen = false;
  isLoading = false;

  openModal() {
    this.isModalOpen = true;
  }

  closeModal() {
    this.isModalOpen = false;
  }

  handleSubmit(event) {
    event.preventDefault();

    this.isLoading = true;

    const fields = event.detail.fields;

    fields.Contact__c = this.recordId;

    this.template.querySelector("lightning-record-edit-form").submit(fields);
  }

  handleSuccess() {
    this.isLoading = false;

    this.dispatchEvent(
      new ShowToastEvent({
        title: "Success",
        message: "Receipt created successfully",
        variant: "success"
      })
    );

    this.closeModal();
    // this.dispatchEvent(new RefreshEvent());
    publish(this.messageContext, RECEIPT_CHANNEL, {
      recordId: this.recordId,
      refresh: true
    });
  }
}
