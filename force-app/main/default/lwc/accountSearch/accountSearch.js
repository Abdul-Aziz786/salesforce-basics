import { LightningElement } from "lwc";
import searchAccounts from "@salesforce/apex/AccountController.searchAccounts";

export default class AccountSearch extends LightningElement {
  searchKey = "";
  accounts = [];
  isLoading = false;
  hasSearched = false;

  lastName = null;
  lastId = null;

  limitSize = 20;
  hasMoreData = true;

  delayTimeout;

  columns = [
    { label: "Account ID", fieldName: "Id" },
    { label: "Name", fieldName: "Name" },
    { label: "Account Number", fieldName: "AccountNumber" },
    { label: "Billing State", fieldName: "BillingState" }
  ];

  handleChange(event) {
    this.searchKey = event.target.value;

    clearTimeout(this.delayTimeout);

    this.delayTimeout = setTimeout(() => {
      this.resetSearch();
      this.hasSearched = this.searchKey.length > 0;
    }, 500);
  }

  resetSearch() {
    this.accounts = [];
    this.lastName = null;
    this.lastId = null;
    this.hasMoreData = true;

    this.fetchAccounts();
  }

  fetchAccounts() {
    if (!this.searchKey || !this.hasMoreData) return;

    this.isLoading = true;

    searchAccounts({
      searchKey: this.searchKey,
      limitSize: this.limitSize,
      lastName: this.lastName,
      lastId: this.lastId
    })
      .then((result) => {
        if (result.length > 0) {
          this.accounts = [...this.accounts, ...result];

          const lastRecord = result[result.length - 1];
          this.lastName = lastRecord.Name;
          this.lastId = lastRecord.Id;
        }

        if (result.length < this.limitSize) {
          this.hasMoreData = false;
        }

        this.isLoading = false;
      })
      .catch(() => {
        this.isLoading = false;
      });
  }

  loadMoreData() {
    if (this.isLoading || !this.hasMoreData) return;

    this.fetchAccounts();
  }
}
