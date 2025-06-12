import { LightningElement, track } from "lwc";

export default class MyTabs extends LightningElement {
  @track activeTab = "tab1";
  @track isTab1 = true;
  @track isTab2 = false;
  @track isTab3 = false;

  handleTabClick(event) {
    this.activeTab = event.currentTarget.dataset.tab;
    console.log("this.activeTab = ", this.activeTab);

    if (this.activeTab === "tab1") {
      this.isTab1 = true;
      this.isTab2 = false;
      this.isTab3 = false;
    } else if (this.activeTab === "tab2") {
      this.isTab1 = false;
      this.isTab2 = true;
      this.isTab3 = false;
    } else {
      this.isTab1 = false;
      this.isTab2 = false;
      this.isTab3 = true;
    }
  }
}
