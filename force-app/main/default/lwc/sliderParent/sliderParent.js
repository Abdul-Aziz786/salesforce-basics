import { LightningElement, api } from "lwc";

export default class SliderParent extends LightningElement {
  @api maxValue;
  rangeValue = 0;
  handleChange(event) {
    const input = event.target;

    input.reportValidity();

    this.rangeValue = Number(input.value);
  }

  listChildChange(event) {
    this.rangeValue = event.detail;
  }

  resetSlider() {
    // this.refs.sliderChild.reset();
    this.rangeValue = 0;
  }
}
