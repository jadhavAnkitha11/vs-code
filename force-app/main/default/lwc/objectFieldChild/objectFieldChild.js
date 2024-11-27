import { LightningElement } from 'lwc';

export default class ObjectFieldChild extends LightningElement {
   
   value='';
   options=[{label:'Contact',value:'Contact'},{label:'Opportunity',value:'Opportunity'},{label:'Case',value:'Case'}];
       
  // handleChange(event){
      // this.value=target.event.value;
       
   //}
//     <selectedObjectHandler(event){
//        const objectName=event.detail;
//         this.value=this.options.find(object => object.name==Object_config)
//    }
handleChange(event){
   // event.preventDefault();
    this.value=event.detail.value;
    console.log('option', this.value);
    
    const selectEvent = new CustomEvent('parent',{    //customevent creation
      detail : this.value
    });
    this.dispatchEvent(selectEvent);
   }
}