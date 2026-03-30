import { LightningElement, api } from "lwc";
import cloneCase from "@salesforce/apex/CaseController.cloneCase";
import { NavigationMixin } from "lightning/navigation";

export default class CloneCaseAction extends NavigationMixin(LightningElement) {
  @api recordId;

  @api invoke() {
    console.log("Record Id - ", this.recordId);
    this.handleClone();
  }

  handleClone() {
    const caseId = this.recordId;

    cloneCase({ caseId })
      .then((clonedCaseId) => {
        this[NavigationMixin.Navigate]({
          type: "standard__recordPage",
          attributes: {
            recordId: clonedCaseId,
            objectApiName: "Case",
            actionName: "view"
          }
        });
      })
      .catch((error) => {
        console.error("Error cloning case:", error);
      });
  }
}
