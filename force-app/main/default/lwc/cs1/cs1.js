import { LightningElement } from "lwc";

export default class Cs1 extends LightningElement {
  value;
  style = "style1";
  get count() {
    return Array.from({ length: 3 }, (_, i) => ({
      index: i + 1,
      name: `Format ${i + 1}`
    }));
  }

  onClick(event) {
    const index = event.target.dataset.index;
    this.style = `style${index}`;
  }

  handleChange(event) {
    this.value = event.target.value;
  }
}
