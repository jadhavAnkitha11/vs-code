import { LightningElement,wire } from 'lwc';
import getContacts from "@salesforce/apex/ContactsFetching.contactsQuerying";
export default class parentContacts extends LightningElement {
// @api RecordId;
contacts;
error;
selectedContact;
searchTerm; 

@wire (getContacts)
wiredContacts({data,error}) {
    if(data){
        this.contacts=data;
        this.error=undefined;
    }
    else if(error){
        this.error=error;

    }
}
handleSelect(event) {
    const contactId = event.target.dataset.id;
    this.selectedContact = this.contacts.find(contact => contact.Id === contactId);
}




// handleInputChange(event) {
//     this.searchTerm = event.target.value;
//     if (this.searchTerm) {
//         searchContacts({ searchTerm: this.searchTerm }).then(result => {
//             this.contacts = result;
//         });
//     } else {
//         this.contacts = undefined;
//     }
// }
// }





