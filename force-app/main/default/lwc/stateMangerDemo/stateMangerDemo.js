import { LightningElement } from "lwc";

import counterManger from "c/counterManger";

export default class StateMangerDemo extends LightningElement {
  counterManger = counterManger(0);

  get count() {
    return this.counterManger.value.count;
  }

  handleIncrement() {
    this.counterManger.value.increment();
  }

  handleDecrement() {
    this.counterManger.value.decrement();
  }

  handleReset() {
    this.counterManger.value.reset();
  }
}
