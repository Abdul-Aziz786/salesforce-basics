import { LightningElement, api } from "lwc";
import cloneCase from "@salesforce/apex/CaseController.cloneCase";
import { NavigationMixin } from "lightning/navigation";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class CloneCaseAction extends NavigationMixin(LightningElement) {
  @api recordId;

  @api invoke() {
    console.log("Record Id - ", this.recordId);
    this.handleClone();
  }

  async handleClone() {
    const caseId = this.recordId;
    console.log("Case Id - ", caseId);
    try {
      const clonedCaseId = await cloneCase({ caseId });
      this[NavigationMixin.Navigate]({
        type: "standard__recordPage",
        attributes: {
          recordId: clonedCaseId,
          objectApiName: "Case",
          actionName: "view"
        }
      });
      this.dispatchEvent(
        new ShowToastEvent({
          title: "Success",
          message: "Case cloned successfully.",
          variant: "success"
        })
      );
    } catch (error) {
      console.error("Error cloning case:", error);
      this.dispatchEvent(
        new ShowToastEvent({
          title: "Error",
          message: "Error cloning case: " + error.body.message,
          variant: "error"
        })
      );
    }
  }
}
