import { LightningElement } from 'lwc';

export default class AccountObjectFromcombobox extends LightningElement {
    selectedObject='';
    handleParent(event){
this.selectedObject=event.detail;
    }
    get isAccount(){
        return this.selectedObject==='Account';
    }
    get isContact(){
        return this.selectedObject==='Contact';
    }
    get isOpportunity(){
        return this.selectedObject==='Opportunity';
    }
}