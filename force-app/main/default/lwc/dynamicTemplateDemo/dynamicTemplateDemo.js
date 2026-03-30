import { LightningElement } from "lwc";
import accountTemplate from "./account.html";
import contactTemplate from "./contact.html";
import defaultTemplate from "./dynamicTemplateDemo.html";

export default class DynamicTemplateDemo extends LightningElement {
  templateName = "";
  selectedCity = "";
  city = [
    { label: "New York", value: "New York" },
    { label: "Los Angeles", value: "Los Angeles" },
    { label: "Chicago", value: "Chicago" },
    { label: "Houston", value: "Houston" },
    { label: "Phoenix", value: "Phoenix" }
  ];

  render() {
    if (this.templateName === "") {
      return defaultTemplate;
    }
    return this.templateName === "account" ? accountTemplate : contactTemplate;
  }
  onSelectCity(event) {
    this.selectedCity = event.target.value;
  }

  //   get isAccount() {
  //     return this.templateName === "account";
  //   }

  //   get isContact() {
  //     return this.templateName === "contact";
  //   }

  onClickContact() {
    this.templateName = "contact";
  }

  onClickAccount() {
    this.templateName = "account";
  }
}
