import { LightningElement, wire, api } from 'lwc';
import getOpportunities from '@salesforce/apex/AccountRelatedOpportunityClass.opportunities';
import deleteOpps from '@salesforce/apex/AccountRelatedOpportunityClass.deleteOpps';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class AccountRelatedOpportunities extends LightningElement {
    @api recordId; 
    oppdata=[];
    selectedOpportunity = null;
    isModalOpen = false;
    isDeleteAllModalOpen = false;
    selectedOppIds=[];

    @wire(getOpportunities, { accId: '$recordId' })
    wiredOpportunities({ error, data }) {
        if (data) {
            this.oppdata = data;
            console.log('Opportunities:', this.oppdata);
            
        } else if (error) {
            console.error('Error:', error);
        }
    }
    editOpportunity(event) {
        console.log('click');
        const button = event.composedPath().find(element => element.dataset.id);
        if (button) {
            const opportunityId = button.dataset.id;
            console.log('Edit Opportunity ID:', opportunityId);
            this.selectedOpportunity = this.oppdata.find(opp => opp.Id === opportunityId);
            console.log('this.selected data',JSON.stringify(this.selectedOpportunity));
            this.isModalOpen = true;
            console.log('Edit opportunity:', JSON.stringify(opportunityId));
        }
    }

   
    

    handleModalClose() {
        this.isModalOpen = false; 
        this.selectedOpportunity = null; 
        
    }



handleSelectAll(event) {
    const isChecked = event.target.checked;
    this.oppdata = this.oppdata.map(opportunity => ({
        ...opportunity,
        selected: isChecked,
    }));

    
    this.updateSelectedOppIds();
}

handleRowSelection(event) {
    const recordId = event.target.dataset.id;
    const isChecked = event.target.checked;

   
    this.oppdata = this.oppdata.map(opportunity => {
        if (opportunity.Id === recordId) {
            return { ...opportunity, selected: isChecked };
        }
        return opportunity;
    });

    this.updateSelectedOppIds();
}

updateSelectedOppIds() {
    this.selectedOppIds = this.oppdata
        .filter(opportunity => opportunity.selected)
        .map(opportunity => opportunity.Id);
}

        
        deleteOpportunity(event) {
            const button = event.composedPath().find(element => element.dataset.id);
        if (button) {
            const opportunityId = button.dataset.id;
            console.log('Delete Opportunity ID:', opportunityId);      
            deleteOpps({ oppId: opportunityId })
                .then(result => {
                    console.log('Returned result:', result);
                    this.oppdata = this.oppdata.filter(opp => opp.Id !== opportunityId); 
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: result,
                            variant: 'success',
                        })
                    );
                })
                .catch(error => {
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error',
                            message: 'Error deleting Opportunity: ' + error.body.message,
                            variant: 'error',
                        })
                    );
                });
        }
    }
    deleteAllOpportunity(event){
        if (this.selectedOppIds.length > 0) {
            this.isDeleteAllModalOpen = true; 
        } else {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Warning',
                    message: 'No opportunities selected for deletion.',
                    variant: 'warning',
                })
            );
        }
    }
    
    handleDeleteAllModalClose(event){
        
        this.isDeleteAllModalOpen = false;
    }

   
    handleDeleteAllConfirmed(event) {
        console.log('Delete all confirmed'); 
    
    deleteOpps({ oppIds: this.selectedOppIds })
    .then(() => {
        this.oppdata = this.oppdata.filter(
            opportunity => !this.selectedOppIds.includes(opportunity.Id)
        );
        this.selectedOppIds = []; 

       
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: 'Selected opportunities deleted successfully.',
                variant: 'success',
            })
        );
    })
    .catch(error => {
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Error',
                message: `Error deleting opportunities: ${error.body.message}`,
                variant: 'error',
            })
        );
    })
    .finally(() => {
        this.isDeleteAllModalOpen = false; 
        
    });
}
}
    
