import { LightningElement } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

import FIRST_NAME from "@salesforce/schema/Contact.FirstName";
import LAST_NAME from "@salesforce/schema/Contact.LastName";
import TITLE from "@salesforce/schema/Contact.Title";
import EMAIL from "@salesforce/schema/Contact.Email";
import PHONE from "@salesforce/schema/Contact.Phone";
import ACCOUNT_ID from "@salesforce/schema/Contact.AccountId";
import CONTACT_OBJECT from "@salesforce/schema/Contact";

export default class ContactCreationWizard extends LightningElement {
  currentStep = 1;
  objectApiName = CONTACT_OBJECT;

  isLoading = false;

  fieldData = {
    FirstName: "",
    LastName: "",
    Title: "",
    Email: "",
    Phone: "",
    AccountId: ""
  };

  fields = {
    firstName: FIRST_NAME,
    lastName: LAST_NAME,
    title: TITLE,
    email: EMAIL,
    phone: PHONE,
    accountId: ACCOUNT_ID
  };

  get step() {
    return this.currentStep.toString();
  }
  get isStep1() {
    return this.currentStep === 1;
  }
  get isStep2() {
    return this.currentStep === 2;
  }
  get isStep3() {
    return this.currentStep === 3;
  }

  get isPrevDisable() {
    return this.currentStep == 1;
  }
  get isNextDisable() {
    return this.currentStep == 3;
  }

  handleChange(event) {
    let value = event.detail.value;

    if (event.target.fieldName === "AccountId" && Array.isArray(value)) {
      value = value[0];
    }

    this.fieldData[event.target.fieldName] = value;
  }

  prev() {
    if (this.currentStep === 1) {
      return;
    }
    this.currentStep--;
  }
  next() {
    if (!this.validateCurrentStep()) {
      return;
    }
    if (this.currentStep === 3) {
      return;
    }
    this.currentStep++;
  }

  validateCurrentStep() {
    const fields = this.template.querySelectorAll("lightning-input-field");

    let isValid = true;

    fields.forEach((field) => {
      const valid = field.reportValidity();

      if (!valid) {
        isValid = false;
      }
    });

    return isValid;
  }
  handleSubmit() {
    this.isLoading = true;
  }
  handleSuccess() {
    this.isLoading = false;
    this.fieldData = {
      AccountId: "",
      Email: "",
      FirstName: "",
      LastName: "",
      Phone: "",
      Title: ""
    };
    this.currentStep = 1;

    this.dispatchEvent(
      new ShowToastEvent({
        title: "Contact",
        message: "Contact Created Successfully",
        varient: "success"
      })
    );
  }
  handleError(event) {
    console.log("Contact Log", event);
    this.isLoading = false;
    this.dispatchEvent(
      new ShowToastEvent({
        title: "Contact",
        message: "Contact Creation Failed",
        varient: "error"
      })
    );
  }
}
