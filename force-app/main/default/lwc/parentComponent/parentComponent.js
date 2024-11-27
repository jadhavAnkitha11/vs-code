import { LightningElement, track } from 'lwc';
export default class ParentComponent extends LightningElement {
    @track inputMessage = '';
    handleChange(event) {
        this.inputMessage = event.target.value;
    }
}
    
