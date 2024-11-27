import { LightningElement } from 'lwc';

export default class Deleteallcomponent extends LightningElement {
    hideModalBox() {
        this.dispatchEvent(new CustomEvent('close'));
    }
    clickYes(event){
        console.log('clicked yes');
        this.dispatchEvent(new CustomEvent('confirm'));
    }
    clickNo(event){
     this.hideModalBox();
    }
}