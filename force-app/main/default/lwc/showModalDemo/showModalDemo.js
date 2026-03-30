import { LightningElement } from "lwc";
import Modal from "c/modal";

export default class ShowModalDemo extends LightningElement {
  result;
  async handleClick() {
    const result = await Modal.open({
      size: "large",
      description: "Modal Demo",
      content: "Details"
    });

    this.result = result;
    console.log(result);
  }
}
