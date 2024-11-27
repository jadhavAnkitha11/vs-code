import { LightningElement,wire } from 'lwc';
import getOpportunitydetails from '@salesforce/apex/AccountFormClass.getOpportunitydetails';
import getAccounts from '@salesforce/apex/AccountFormClass.getOpportunities';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class Opportunityform extends LightningElement {
    selectedObject = '';
    firstName = '';
    lastName = '';
    email = '';
    accountId = '';
    isModalOpen = true;
    Disable = false;
    accountOptions = [];

    @wire(getAccounts)
    wiredAccounts({ error, data }) {
        if (data) {
            console.log('Accounts data:', data);  
            this.accountOptions = data.map(account => ({
                label: account.Name,
                value: account.Id
            }));
        } else if (error) {
            console.error('Error fetching accounts:', error);
        }
    }
    

    handlechange(event) {
        const fieldName = event.target.name;
        if (fieldName === 'name') {
            this.firstName = event.target.value;
        } else if (fieldName === 'stageName') {
            this.lastName = event.target.value;
        } else if (fieldName === 'closeDate') {
            this.email = event.target.value;
        } else if (fieldName === 'accountId') {
            this.accountId = event.target.value;
        }
    }

    handlesave(event) {
        event.preventDefault();
        const accountIdToSend = this.accountId === '' ? null : this.accountId;
        getContactDetails({
            name: this.name,
            stageName: this.stageName,
            closeDate: this.closeDate,
            accountId: accountIdToSend
        })
        .then(result => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Contact details saved successfully.'+ result,
                    variant: 'success'
                })
            );
            this.handlecancel(); // Clear the form
            this.hideModalBox(); // Close the modal
        })
        .catch(error => {
            console.error('Error saving contact details:', error);
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: 'Error saving contact details.',
                    variant: 'error'
                })
            );
        });
    }

    handlecancel() {
        this.name = '';
        this.stageName = '';
        this.closeDate = '';
        this.accountId = '';
    } 

    hideModalBox() { 
        this.isModalOpen = false;
    }
}

