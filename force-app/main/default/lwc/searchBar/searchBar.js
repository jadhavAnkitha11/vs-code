import { LightningElement } from 'lwc';

export default class searchBar extends LightningElement {
    searchTerm = '';
    handleInputChange(event){
        this.searchTerm=event.target.value;
        const searchEvent=new CustomEvent('searching',{detail: this.searchTerm});
        this.dispatchEvent(searchEvent);
    }
} 
         