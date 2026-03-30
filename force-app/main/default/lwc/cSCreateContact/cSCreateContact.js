import { LightningElement } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class CSCreateContact extends LightningElement {
  isLoading = false;

  resetForm() {
    const inputFields = this.template.querySelectorAll("lightning-input-field");
    if (inputFields) {
      inputFields.forEach((field) => {
        field.reset();
      });
    }
  }

  handleSubmit(event) {
    this.isLoading = true;
  }

  handleSuccess() {
    this.isLoading = false;
    this.resetForm();
    this.dispatchEvent(
      new ShowToastEvent({
        title: "Success",
        message: "Contact created successfully",
        variant: "success"
      })
    );
  }

  handleError(event) {
    this.isLoading = false;

    this.dispatchEvent(
      new ShowToastEvent({
        title: "Error",
        message: event.detail.message,
        variant: "error"
      })
    );
  }
}
