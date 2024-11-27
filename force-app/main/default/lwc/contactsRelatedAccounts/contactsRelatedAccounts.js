import {LightningElement,wire,api} from 'lwc';
import getContactList from '@salesforce/apex/ContactsRelatedAccount.getContactList';
export default class ContactsRelatedaccount extends LightningElement{
    @api recordId;

    @wire(getContactlist) contacts({data,error}){
    if(data){
        this.contacts=data;
        this.error=undefined;
    }
    else{
        this.contacts=undefined;
        this.error=error;
    }

      var currentPage;
      var pageSize;
      var offsetCalculation;
       public static void callingOffset( var currentPage, var pageSize, var offsetCalculation)
         {
             
             this.pageSize = 5;
              this.currentPage = 1;
             this.offsetCalculation = (offset + pageSize);
             var offset = pageSize * currentPage;
              
    }
}
