import { LightningElement } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
export default class ParentProgressBar extends LightningElement {
  onClickStart() {
    this.refs.start.disabled = true;
    this.template.querySelector("c-child-progress-bar").startProgress();
  }
  onProgressComplete() {
    this.refs.start.disabled = false;
    this.dispatchEvent(
      new ShowToastEvent({
        title: "Success",
        message: "Progress Completed",
        variant: "success"
      })
    );
  }
}
