import { LightningElement } from 'lwc';

export default class ObjectCombobox extends LightningElement {
    value='';
    // options=[{label:'Account',value:'Account'},{label:'Contact',value:'Contact'},{label:'Opportunity',value:'Opportunity'}];
    get options(){
        return [{label:'Account',value:'Account'},
                {label:'Contact',value:'Contact'},
                {label:'Opportunity',value:'Opportunity'}];
    }
     handleChange(event){
        this.value=event.detail.value;
    }
    
}