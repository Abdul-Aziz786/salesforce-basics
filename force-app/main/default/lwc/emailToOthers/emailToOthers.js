import { LightningElement, api, track, wire } from "lwc";
import getFromEmails from "@salesforce/apex/EmailService.getFromEmails";
import sendEmail from "@salesforce/apex/EmailService.sendEmail";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { CloseActionScreenEvent } from "lightning/actions";
import { RefreshEvent } from "lightning/refresh";

export default class EmailToOthers extends LightningElement {
  @api recordId;

  @track fromOptions = [];
  selectedFrom = "test@gmail.com";

  toEmail = "";
  subject = "";
  body = "";
  isLoading = false;

  @wire(getFromEmails)
  wiredEmails({ data, error }) {
    if (data) {
      this.fromOptions = data.map((e) => ({ label: e, value: e }));

      if (!data.includes("test@gmail.com")) {
        this.fromOptions.unshift({
          label: "test@gmail.com",
          value: "test@gmail.com"
        });
      }
    } else if (error) {
      console.error(error);
    }
  }

  handleFromChange(e) {
    this.selectedFrom = e.detail.value;
  }

  handleToEmail(e) {
    this.toEmail = e.target.value;
  }

  handleSubject(e) {
    this.subject = e.target.value;
  }

  handleBody(e) {
    this.body = e.target.value;
  }

  validateEmail(email) {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
  }

  async handleSend() {
    if (!this.validateEmail(this.toEmail)) {
      this.showToast("Error", "Invalid Email", "error");
      return;
    }

    try {
      this.isLoading = true;

      const req = {
        toEmail: this.toEmail,
        subject: this.subject,
        body: this.body,
        fromEmail: this.selectedFrom,
        caseId: this.recordId
      };

      await sendEmail({
        req: req
      });

      this.dispatchEvent(new CloseActionScreenEvent());
      this.dispatchEvent(new RefreshEvent());

      this.showToast("Success", "Email Sent", "success");
      this.resetForm();
    } catch (error) {
      this.showToast("Error", error.body.message, "error");
    } finally {
      this.isLoading = false;
    }
  }

  showToast(title, message, variant) {
    this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
  }

  resetForm() {
    this.toEmail = "";
    this.subject = "";
    this.body = "";
  }
}
