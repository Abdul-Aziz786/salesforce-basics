import { LightningElement, api } from "lwc";

export default class SliderChild extends LightningElement {
  sliderValue = 0;
  @api
  set value(val) {
    this.sliderValue = val;
  }
  get value() {
    return this.sliderValue;
  }

  @api maxValue;

  handleSliderChange(event) {
    const value = event.target.value;

    this.dispatchEvent(new CustomEvent("valuechange", { detail: value }));
  }

  @api
  reset() {
    this.sliderValue = 0;
  }

  connectedCallback() {
    console.log("SliderChild connected");
  }

  renderedCallback() {
    console.log("SliderChild rendered");
  }

  disconnectedCallback() {
    console.log("SliderChild disconnected");
  }
}
