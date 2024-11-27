import { LightningElement, api } from 'lwc';
export default class ChildComponent extends LightningElement {
    @api customer; // This is exposed to the parent
    get customerInfo() {
        return this.customer ? `${this.customer.name}, ${this.customer.email}, ${this.customer.phone}` : 'No customer selected';
    }
}