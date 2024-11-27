import { LightningElement,wire } from 'lwc';
import getContacts from '@salesforce/apex/learnsimpledatatable.allContacts';
 const columns=[
    {label:'Contact Name',fieldName: 'Name'},//in the place of fieldname give the column api names of the contact
    {label:'Contact Email',fieldName:'Email'},
    {label:'contact phone',fieldName:'Phone'}
];
export default class learnsimpledatatable extends LightningElement {
    columns=columns;
    contacts;
    @wire (getContacts) wireddata({data,error}){
        if(data){
           this.contacts=data;
        }
        else if(error){
            this.error=error;
          console.log('there are no contacts',error);
        }
    }
}