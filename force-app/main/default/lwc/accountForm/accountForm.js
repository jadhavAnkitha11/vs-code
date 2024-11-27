import { LightningElement } from 'lwc';
import getAccountDetails from '@salesforce/apex/AccountFormClass.getAccountDetails';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class AccountForm extends LightningElement {
    selectedobject = '';
    accountName = '';
    phone = '';
    annualRevenue = '';
    isModalOpen = true;
    handlesave(event) {
        event.preventDefault(); // Prevent default form submission
        getAccountDetails({
            accountName: this.accountName,
            phone: this.phone,
            annualRevenue: this.annualRevenue
        }).then(result => {
            console.log('result:', result);
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Account details saved successfully: ' + result,
                    variant: 'success'
                })
            );
            this.handlecancel(); // Reset the form after successful save
            this.hideModalBox();
        }).catch(error => {
            console.log('error:', error);
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: 'Error saving account details',
                    variant: 'error'
                })
            );
        });
    }

    handlechange(event) {
        const fieldName = event.target.name;
        if (fieldName === 'accountName') {
            this.accountName = event.target.value;
        } else if (fieldName === 'phone') {
            this.phone = event.target.value;
        } else if (fieldName === 'annualRevenue') {
            this.annualRevenue = event.target.value;
        }
    }

    handlecancel() {
        this.accountName = '';
        this.phone = '';
        this.annualRevenue = '';
    }

    hideModalBox() {
        this.isModalOpen = false;
    }
   
}
