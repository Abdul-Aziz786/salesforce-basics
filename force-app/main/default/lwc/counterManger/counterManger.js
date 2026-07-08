import { LightningElement } from "lwc";
import { defineState } from "@lwc/state";
const counterManger = defineState(
  ({ atom, setAtom, computed }, initialState = 0) => {
    const count = atom(initialState);

    const increment = () => {
      setAtom(count, count.value + 1);
    };

    const decrement = () => {
      setAtom(count, count.value - 1);
    };

    const reset = () => {
      setAtom(count, initialState);
    };

    return {
      count,
      increment,
      decrement,
      reset
    };
  }
);

export default counterManger;
