import { LightningElement, wire } from "lwc";
import getAllAccounts from "@salesforce/apex/IntegrationHome.getAllAccounts";

export default class IntegrationHome extends LightningElement {
  accounts;
  error;

  @wire(getAllAccounts)
  wiredAccounts({ error, data }) {
    if (data) {
      this.accounts = data;
      console.log("Accounts data:", this.accounts);
      // Reset error if data is successfully retrieved
      this.error = undefined;
    } else if (error) {
      this.error = error;
      console.log("Accounts error:", this.error);
      this.accounts = undefined;
    }
  }
}
