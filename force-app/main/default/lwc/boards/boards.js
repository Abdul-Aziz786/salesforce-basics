import { LightningElement, wire } from "lwc";
import BOARD_OBJECT from "@salesforce/schema/Board__c";
import NAME_FIELD from "@salesforce/schema/Board__c.Name";
import NO_OF_SECTIONS_FIELD from "@salesforce/schema/Board__c.NoOfSections__c";
import DESCRIPTION_FIELD from "@salesforce/schema/Board__c.Description__c";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { NavigationMixin } from "lightning/navigation";

import saveBoard from "@salesforce/apex/BoardController.saveBoard";
import getBoards from "@salesforce/apex/BoardController.getBoards";

const COLUMNS = [
  { label: "Name", fieldName: "Name" },
  { label: "Description", fieldName: "Description__c" },
  { label: "Number of Sections", fieldName: "NoOfSections__c" },
  {
    type: "button",
    typeAttributes: {
      label: "Open Board",
      name: "openBoard",
      title: "Open Board",
      value: "openBoard"
    }
  }
];

export default class Boards extends NavigationMixin(LightningElement) {
  columns = COLUMNS;
  objectApiName = BOARD_OBJECT;
  nameField = NAME_FIELD;
  noOfSectionsField = NO_OF_SECTIONS_FIELD;
  descriptionField = DESCRIPTION_FIELD;

  isLoading = false;
  isModalOpen = false;
  noOfSections = 0;

  sections = [];
  boards = [];
  wireBoardResult;
  @wire(getBoards)
  getBoards(result) {
    if (result.data) {
      this.boards = result.data;
    }
    this.wireBoardResult = result;
  }

  rowAction(event) {
    const actionName = event.detail.action.name;
    const row = event.detail.row;
    if (actionName === "openBoard") {
      this.navigateToBoard(row.Id);
    }
  }

  navigateToBoard(recordId) {
    console.log("Navigating to Board with Id:", recordId);
    this[NavigationMixin.Navigate]({
      type: "standard__recordPage",
      attributes: {
        recordId: recordId,
        objectApiName: this.objectApiName,
        actionName: "view"
      }
    });
  }
  handleAddBoard() {
    this.isModalOpen = true;
  }

  handleCloseModal() {
    this.isModalOpen = false;
  }
  async handleSubmit(event) {
    event.preventDefault();
    const fields = event.detail.fields;

    const sectionControls = this.template.querySelectorAll(
      "[data-section-control]"
    );

    let sectionsList = [];
    sectionControls.forEach((control) => {
      sectionsList.push({
        Name: control.value,
        Items_Backgroud_Theme__c: `${this.getRandomTheme()} slds-p-around_xx-small`
      });
    });

    if (!this.validateSections(fields, sectionsList)) return;

    this.isLoading = true;
    try {
      const boardId = await saveBoard({
        board: fields,
        sections: sectionsList
      });
      this.navigateToBoard(boardId);
      this.handleCloseModal();
      this.showToast("Success", "Board created successfully!", "success");
    } catch (error) {
      this.showToast("Error", "Failed to create board.", "error");
    } finally {
      this.isLoading = false;
    }
  }

  handleSectionChange(event) {
    const value = Number(event.target.value);
    if (value >= 1 && value <= 10) {
      this.noOfSections = value;
    } else {
      this.noOfSections = 0;
    }

    this.sections = [];
    for (let i = 1; i <= this.noOfSections; i++) {
      this.sections.push({
        label: `Section ${i} Title`,
        id: i
      });
    }
  }

  validateSections(fields, sectionList) {
    const noOfSections = fields.NoOfSections__c;
    if (noOfSections < 1 || noOfSections > 10) {
      this.showToast(
        "Error",
        "Number of Sections must be between 1 and 10.",
        "error"
      );
      return false;
    }

    if (sectionList.filter((section) => !section.Name).length > 0) {
      this.showToast("Error", "All sections must have a title.", "error");
      return false;
    }

    return true;
  }

  showToast(title, message, variant) {
    this.dispatchEvent(
      new ShowToastEvent({
        title,
        message,
        variant
      })
    );
  }
  getRandomTheme() {
    let themes = [
      "slds-theme_alert-texture",
      "slds-theme_warning",
      "slds-theme_alt-inverse",
      "slds-theme_inverse",
      "slds-theme_shade"
    ];
    return themes[Math.floor(Math.random() * themes.length)];
  }
}
