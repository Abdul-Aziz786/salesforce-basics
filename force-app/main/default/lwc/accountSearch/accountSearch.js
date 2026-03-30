import { LightningElement } from "lwc";

export default class AccountSearch extends LightningElement {
  searchValue = "";

  handleSearchChange(event) {
    this.searchValue = event.target.value;
  }
  handleClick() {}
}
