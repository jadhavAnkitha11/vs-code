import { LightningElement } from 'lwc';
export default class ParentToChildByApiMethod extends LightningElement {
    resetChildForm() {
        this.template.querySelector('c-child-to-parent-by-api-method').resetChildForm(); // Call the child's @api method
    }
}