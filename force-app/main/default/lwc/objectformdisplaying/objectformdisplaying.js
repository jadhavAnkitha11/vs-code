// import { LightningElement } from 'lwc';

// export default class objectformdisplaying extends LightningElement {

//     value='';
//     selectedValue='';
//     isAccount;
//     isContact;
//     isOpportunity;
    
//     get options(){
//         return [{label:'Account',value:'Account'},
//                 {label:'Contact',value:'Contact'},
//                 {label:'Opportunity',value:'Opportunity'}];
//     }
//      handleChange(event){
//         //this.value=event.detail.value;
//         this.selectedValue=event.detail.value;

//     }
//     get isAccount(){
//         return this.selectedValue==='Account';
//     }
//     get isContact(){
//        return this.selectedValue==='Contact';
//     }
//     get isOpportunity(){
//        return this.selectedValue==='Opportunity';
//     }
    
// }

import { LightningElement } from 'lwc';

export default class ObjectFormDisplaying extends LightningElement {
    selectedValue = '';

    get options() {
        return [
            { label: 'Account', value: 'Account' },
            { label: 'Contact', value: 'Contact' },
            { label: 'Opportunity', value: 'Opportunity' }
        ];
    }

    handleChange(event) {
        this.selectedValue = event.detail.value;
    }

    get isAccount() {
        return this.selectedValue === 'Account';
    }

    get isContact() {
        return this.selectedValue === 'Contact';
    }

    get isOpportunity() {
        return this.selectedValue === 'Opportunity';
    }
}
