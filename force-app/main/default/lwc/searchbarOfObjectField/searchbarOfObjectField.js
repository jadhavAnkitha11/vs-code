import { LightningElement } from 'lwc';

export default class searchbarOfObjectField extends LightningElement {
    searchTerm = '';
    handleInputChange(event){
        this.searchTerm=event.target.value;
        const searchEvent=new CustomEvent('search',{detail: this.searchTerm});
        this.dispatchEvent(searchEvent);
    }
}