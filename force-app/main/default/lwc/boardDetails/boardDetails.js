import { api, LightningElement, track, wire } from "lwc";
import { refreshApex } from "@salesforce/apex";
import getBoardDetails from "@salesforce/apex/BoardController.getBoardDetails";
import BOARD_ITEM_OBJECT from "@salesforce/schema/Board_Section_Item__c";
import {
  createRecord,
  updateRecord,
  deleteRecord
} from "lightning/uiRecordApi";

export default class BoardDetails extends LightningElement {
  @api recordId;

  wiredResult;

  @track sections = [];

  @wire(getBoardDetails, { boardId: "$recordId" })
  boardDetails(result) {
    this.wiredResult = result;
    console.log("BoardID", this.recordId);
    console.log("WireResult", JSON.stringify(result));
    if (result.data) {
      this.sections = JSON.parse(JSON.stringify(result.data));
    } else {
      console.error("Error fetching board details:", result.error);
    }
  }
  handleClick() {
    console.log("Id", this.recordId);
    console.log("Clicked", JSON.stringify(this.sections));
  }

  async addNewItemClickHandler(event) {
    try {
      let sectionId = event.target.dataset.sectionId;

      const fields = { Section__c: sectionId, LikeCount__c: 0 };
      const recordInput = {
        apiName: BOARD_ITEM_OBJECT.objectApiName,
        fields
      };
      const resp = await createRecord(recordInput);
      fields.Id = resp.id;

      let section = this.sections.find((a) => a.Id == sectionId);
      if (!section?.Board_Section_Items__r) {
        section.Board_Section_Items__r = [];
      }
      section.Board_Section_Items__r.push(fields);
    } catch (error) {
      console.error("Error adding new item:", error);
    }
  }
  async updateItemDescriptionHandler(event) {
    let itemId = event.target.dataset.sectionItemId,
      itemDescription = event.target.value;

    const fields = { Id: itemId, Description__c: itemDescription };
    await updateRecord({ fields });
  }
  async likeSectionItemHandler(event) {
    let itemId = event.target.dataset.sectionItemId,
      sectionId = event.target.dataset.sectionId;

    let sectionItemRow = this.sections
        .find((a) => a.Id == sectionId)
        ?.Board_Section_Items__r.find((a) => a.Id == itemId),
      likeCount = parseInt(sectionItemRow.LikeCount__c ?? 0) + 1;

    const fields = { Id: itemId, LikeCount__c: likeCount };
    await updateRecord({ fields });

    sectionItemRow.LikeCount__c = likeCount;
  }
  async deleteSectionItemHandler(event) {
    let itemId = event.target.dataset.sectionItemId;

    await deleteRecord(itemId);
    this.sections = this.sections.map((section) => ({
      ...section,

      Board_Section_Items__r:
        section.Board_Section_Items__r?.filter((item) => item.Id !== itemId) ||
        []
    }));
  }
}
