import { LightningElement , api} from 'lwc';
export default class childToParentByApiMethod extends LightningElement {
    name = '';
    email = '';
    @api resetChildForm() { 
        this.name = '';
        this.email = '';
    }
    handleNameChange(event) {
        this.name = event.target.value;
    }
    handleEmailChange(event) {
        this.email = event.target.value;
    }
}