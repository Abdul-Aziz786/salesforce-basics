import { LightningElement } from "lwc";
import { fromContext } from "@lwc/state";
import counterManger from "c/counterManger";

export default class StateManagerChildDemo extends LightningElement {
  counterManger = fromContext(counterManger);

  get count() {
    return this.counterManger.value.count;
  }

  handleIncrement() {
    this.counterManger.value.increment();
  }

  handleDecrement() {
    this.counterManger.value.decrement();
  }
}
