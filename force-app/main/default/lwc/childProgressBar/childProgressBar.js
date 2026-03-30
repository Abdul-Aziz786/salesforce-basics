import { LightningElement, api } from "lwc";

export default class ChildProgressBar extends LightningElement {
  progressValue = 10;

  @api
  startProgress() {
    // eslint-disable-next-line @lwc/lwc/no-async-operation
    const intervel = setInterval(() => {
      this.progressValue += 10;
      if (this.progressValue > 100) {
        this.progressValue = 0;
        this.dispatchEvent(new CustomEvent("progresscomplete"));
        clearInterval(intervel);
      }
    }, 300);
  }
}
