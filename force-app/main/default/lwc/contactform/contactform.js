// import { LightningElement, wire} from 'lwc';
// import getContactDetails from '@salesforce/apex/AccountFormClass.getContactdetails';
// import { ShowToastEvent } from 'lightning/platformShowToastEvent';

// export default class Contactform extends LightningElement {
//     selectedobject = '';
//     firstName = '';
//     lastName= '';
//     email = '';
//     account='';
//     isModalOpen = true;
//     Disable = false;
//     accountOptions=[];
//     @wire(getContactDetails)
//     wiredAccounts({ error, data }) {
//         if (data) {
//             this.accountOptions = data.map(account => ({
//                 label: account.Name,
//                 value: account.Id
//             }));
//         } else if (error) {
//             console.error('Error fetching accounts:', error);
//         }
//     }
    
//     handlesave(event) {
//         event.preventDefault(); // Prevent default form submission
//         const accountIdToSend = this.account === '' ? null : this.account;
//         getContactDetails({
//             firstName: this.firstName,
//             lastName: this.lastName,
//             email: this.email,
//             account:accountIdToSend
//         }).then(result => {
//             console.log('result:', result);
//             this.dispatchEvent(
//                 new ShowToastEvent({
//                     title: 'Success',
//                     message: 'Contact details saved successfully: ' + result,
//                     variant: 'success'
//                 })
//             );
//             this.handlecancel(); // Reset the form after successful save
//             this.hideModalBox();
//         }).catch(error => {
//             console.log('error:', error);
//             this.dispatchEvent(
//                 new ShowToastEvent({
//                     title: 'Error',
//                     message: 'Error saving account details',
//                     variant: 'error',
//                     Disable:true
//                 })
//             );
//         });
//     }

//     handlechange(event) {
//         const fieldName = event.target.name;
//         if (fieldName === 'firstName') {
//             this.accountName = event.target.value;
//         } else if (fieldName === 'lastName') {
//             this.phone = event.target.value;
//         } else if (fieldName === 'email') {
//             this.annualRevenue = event.target.value;
//         } else if(fieldName === 'account'){
//             this.account=event.target.value;
//         }
//     }

//     handlecancel() {
//         this.firstName = '';
//         this.lastName = '';
//         this.email= '';
//         this.account='';
//     }

//     hideModalBox() {
//         this.isModalOpen = false;
//     }
   
// }

import { LightningElement, wire } from 'lwc';
import getContactDetails from '@salesforce/apex/AccountFormClass.getContactdetails';
import getAccounts from '@salesforce/apex/AccountFormClass.getAccounts';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ContactForm extends LightningElement {
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
        if (fieldName === 'firstName') {
            this.firstName = event.target.value;
        } else if (fieldName === 'lastName') {
            this.lastName = event.target.value;
        } else if (fieldName === 'email') {
            this.email = event.target.value;
        } else if (fieldName === 'accountId') {
            this.accountId = event.target.value;
        }
    }

    handlesave(event) {
        event.preventDefault();
        const accountIdToSend = this.accountId === '' ? null : this.accountId;
        getContactDetails({
            firstName: this.firstName,
            lastName: this.lastName,
            email: this.email,
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
        this.firstName = '';
        this.lastName = '';
        this.email = '';
        this.accountId = '';
    }

    hideModalBox() {
        this.isModalOpen = false;
    }
}
