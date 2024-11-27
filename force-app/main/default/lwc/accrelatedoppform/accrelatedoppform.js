import { LightningElement, api } from 'lwc';
import opportunities from '@salesforce/apex/AccountRelatedOpportunityClass.opportunities';
import updateOpps from '@salesforce/apex/AccountRelatedOpportunityClass.updateOpps';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class Accrelatedoppform extends LightningElement {

    @api opportunityData;
    
    editClick = '';
    opportunityName = '';
    description = '';
    amount = '';
    closedate='';
    stagename='';
    isModalOpen = false;
    // obj = {opportunityName:this.opportunityName,description:this.description,amount:this.amount,closedate:this.closedate,stagename:this.stagename};

    get opportunityData() {
        return this._opportunityData;
    }
    set opportunityData(value) {
        console.log('data in child',JSON.stringify(value));
        this._opportunityData = value;
        if (value) {
            this.opportunityName = value.Name;
            this.description = value.Description;
            this.amount = value.Amount;
            this.closedate = value.CloseDate;
            this.stagename = value.StageName;
            console.log(value);
        }
    }

    handlechange(event) {
        const fieldName = event.target.name;
    }
   

    handlesave(event) {
        event.preventDefault(); // Prevent default form submission
        const updatedOpportunity = {
            Id: this._opportunityData.Id,
            Name: this.opportunityName,
            Description: this.description,
            Amount: parseFloat(this.amount), 
            CloseDate: this.closedate,
            StageName: this.stagename
        };
        

        updateOpps({ opp: updatedOpportunity })
            .then(result => {
                console.log('returned---'+result);
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Opportunity updated successfully.',
                        variant: 'success'
                    })
                );
                this.closeModal(); // Close the modal after saving
            })
            .catch(error => {
                console.error('Error updating Opportunity:', error);
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: 'Failed to update the Opportunity.',
                        variant: 'error'
                    })
                );
            });
            
        }

    handlechange(event) {
        const fieldName = event.target.name;
        if (fieldName === 'opportunityName') {
            this.opportunityName = event.target.value;
        } else if (fieldName === 'description') {
            this.description = event.target.value;
        } else if (fieldName === 'amount') {
            this.amount = event.target.value;
        } else if (fieldName === 'closedate'){
            this.closedate = event.target.value;
        } else if (fieldName === 'stagename'){
            this.stagename = event.target.value;
        }
    }
    
    handlecancel() {
       this.opportunityName = '';
        this.description = '';
        this.amount = '';
        this.closedate = '';
        this.stagename = '';
        
    }
    hideModalBox() {
        this.isModalOpen = false;
        this.closeModal();
    }

    closeModal() {
        this.dispatchEvent(new CustomEvent('close')); // Notify parent to close the modal
    }
}

