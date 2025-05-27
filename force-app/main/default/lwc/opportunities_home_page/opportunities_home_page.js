import { LightningElement, wire, track } from 'lwc';
import getAllOpportunities from '@salesforce/apex/OpportunitiesController.getAllOpportunities';

const columns =[
    { label: 'Opportunity Name', fieldName: 'oppName' },
    { label: 'Description', fieldName: 'oppDescription' },
    { label: 'Close Date', fieldName: 'closeDate', type: 'date' },
    { label: 'Account Name', fieldName: 'accountName' },
    { label: 'Contact Name', fieldName: 'contactName' },
    { label: 'Email', fieldName: 'email' },
    { label: 'Phone', fieldName: 'phone' }
];

export default class Opportunities_home_page extends LightningElement {
    @track opportunities;
    opportunitiesOnLoad;
    columns = columns;
    searchText = '';

    @wire(getAllOpportunities)
    wiredOpportunities({ error, data }) {
        if (data) {
            this.opportunities = data;
            this.opportunities = JSON.parse(JSON.stringify(this.opportunities));
            
            console.log('this.opportunities',this.opportunities);

            for(let opportunity of this.opportunities){
                opportunity.id= opportunity.opp.Id || 'N/A';
                opportunity.oppName= opportunity.opp.Name || 'N/A';
                opportunity.oppDescription= opportunity.opp.Description || 'N/A'; // handle missing description
                opportunity.closeDate= opportunity.opp.CloseDate || 'N/A';
                opportunity.accountName= opportunity.opp?.Account?.Name || 'N/A';
                opportunity.contactName= opportunity.con.Name || 'N/A';
                opportunity.email= opportunity.con.Email || 'N/A';
                opportunity.phone= opportunity.con.Phone || 'N/A';
                opportunity.stageName = opportunity.opp.StageName || 'N/A';
            }
            this.opportunitiesOnLoad = this.opportunities;
            console.log('this.opportunities',this.opportunities);
        } else if (error) {
            console.error('Error retrieving opportunities:', error);
        }
    }

    searchOpportunities(e) {
        let searchTerm = e.target.value;
        if (!searchTerm) {
            this.opportunities = this.opportunitiesOnLoad;
            return this.opportunities;
        }

        searchTerm = searchTerm.toLowerCase();
        let tempOpportunities = []
        this.opportunities.filter(opportunity => {
            console.log('opportunity',opportunity);
            console.log('Opportunity Stage', opportunity.stageName.toLowerCase());
            console.log('Account Name', opportunity.accountName.toLowerCase());
            console.log('Contact Name', opportunity.contactName.toLowerCase());
            console.log('SearchText', searchTerm);
            if(opportunity.stageName.toLowerCase().includes(searchTerm) ||
                opportunity.accountName.toLowerCase().includes(searchTerm) ||
                opportunity.contactName.toLowerCase().includes(searchTerm)){
                    tempOpportunities.push(opportunity);
                    console.log('If');
            } else {
                console.log('Else');
            }
        });
        console.log(tempOpportunities);
        this.opportunities = tempOpportunities;
}
}