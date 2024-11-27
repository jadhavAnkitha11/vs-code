import { LightningElement, track } from 'lwc';
export default class ParentComponent extends LightningElement {
    selectedCustomer = {
        name: 'John Doe',
        email: 'john.doe@example.com',
        phone: '123-456-7890'
    };
    handleSelectAnotherCustomer() {
        this.selectedCustomer = {
            name: 'Jane Smith',
            email: 'jane.smith@example.com',
            phone: '987-654-3210'
        };
    }
}