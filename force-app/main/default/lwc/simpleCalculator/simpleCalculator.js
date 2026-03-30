import { LightningElement } from "lwc";

export default class SimpleCalculator extends LightningElement {
  displayValue = "0";
  currentInput = "";
  previousValue = null;
  operator = null;

  buttons = [
    { label: "7", type: "number", value: "7" },
    { label: "8", type: "number", value: "8" },
    { label: "9", type: "number", value: "9" },
    { label: "/", type: "operator", value: "divide", variant: "brand" },

    { label: "4", type: "number", value: "4" },
    { label: "5", type: "number", value: "5" },
    { label: "6", type: "number", value: "6" },
    { label: "*", type: "operator", value: "multiply", variant: "brand" },

    { label: "1", type: "number", value: "1" },
    { label: "2", type: "number", value: "2" },
    { label: "3", type: "number", value: "3" },
    { label: "-", type: "operator", value: "subtract", variant: "brand" },

    { label: "0", type: "number", value: "0" },
    { label: "C", type: "action", value: "clear", variant: "destructive" },
    { label: "=", type: "action", value: "equals", variant: "success" },
    { label: "+", type: "operator", value: "add", variant: "brand" }
  ];

  handleClick(event) {
    const type = event.target.dataset.type;
    const value = event.target.dataset.value;

    if (type === "number") {
      this.handleNumber(value);
    } else if (type === "operator") {
      this.handleOperator(value);
    } else {
      this.handleAction(value);
    }

    this.updateDisplay();
  }

  handleNumber(value) {
    this.currentInput += value;
  }

  handleOperator(op) {
    this.compute();
    this.operator = op;
    this.previousValue = Number(this.currentInput || this.displayValue);
    this.currentInput = "";
  }

  handleAction(action) {
    if (action === "clear") {
      this.currentInput = "";
      this.previousValue = null;
      this.operator = null;
      this.displayValue = "0";
    }

    if (action === "equals") {
      this.compute();
      this.operator = null;
    }
  }

  compute() {
    if (this.previousValue === null || this.currentInput === "") return;

    const current = Number(this.currentInput);
    let result;

    console.log("Prev", this.previousValue);
    console.log("Curr", current);

    switch (this.operator) {
      case "add":
        result = this.previousValue + current;
        break;
      case "subtract":
        result = this.previousValue - current;
        break;
      case "multiply":
        result = this.previousValue * current;
        break;
      case "divide":
        result = current === 0 ? "Error" : this.previousValue / current;
        break;
      default:
        break;
    }

    if (!Number.isInteger(result)) {
      result = Number(result.toFixed(2));
    }

    this.displayValue = result.toString();
    this.currentInput = this.displayValue;
    this.previousValue = null;
  }

  updateDisplay() {
    this.displayValue = this.currentInput || this.displayValue;
  }
}
