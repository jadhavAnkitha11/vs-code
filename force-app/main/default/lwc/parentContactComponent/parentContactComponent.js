import { LightningElement,wire } from 'lwc';
import getContactValues from '@salesforce/apex/DisplayContacts.queryContacts';
export default class ParentContactComponent extends LightningElement {
    contacts;
    searchedData;
    contactNames=[];
    display=false;
    send;
    @wire (getContactValues) wiredContacts({data,error}){
       if(data){
        this.contacts=data;

        this.error=undefined;
        console.log('con' ,this.contacts);
        
       }
       else if(error){
           this.error=error;
       }
    }
    handlebuttonclick(){
          this.searchedData=this.template.querySelector("input").value; //it will store the searched values   
          console.log('con' , this.contacts);
          console.log('cons' , this.data);
          
          
          this.display=true;
          this.contactNames=this.contacts.filter(con => {
            return con.Name.toLowerCase().startsWith(this.searchedData.toLowerCase());
          });
          console.log("contact Names:",JSON.stringify(this.contactNames));
          this. =this.contactNames.map(con =>  con.Name)
          console.log('send',JSON.stringify(this.send));
    }
} 