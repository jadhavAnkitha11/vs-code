// import { LightningElement,api,wire } from 'lwc';
// import objectsRelatedToAccount from '@salesforce/apex/ObjectFieldClass.queryMethod';
// export default class objectFieldParent extends LightningElement {
//     objectToDisplay;
//     handleParent(event){
//         this.objectToDisplay = event.detail;
//         console.log('objectName',this.objectToDisplay);
//     }
//     @api recordId; 
//     columnData;
//     rowData;
//     isRecordsPresent=false;
//     searchTerm = '';
//     pagenumber=1;
//     paginatedrecords=[]; 
//     pageSize = 5;
//     totalPages = 0;
//     hidepageno=false;
    
// @wire (objectsRelatedToAccount, {accountId : '$recordId' ,  selectedObject : '$objectToDisplay'})
//     wiredRecords({error,data}) {
//         if(data){
//             console.log('data',data);
//             console.log('hello');
            
//             // this.columnData  = data.metadata.map(col => { //change here that is delete data[0] element
//             //     return {
//             //         label: col.Field_Config__r.Label,
//             //         fieldApi: col.Field_Config__r.Field_Api_Name__c
//             //     };
//             // });
//             if (data && data.metadata && data.relatedObjectRecords) {
//                 this.columnData = data.metadata.map(col => ({
//                     label: col.Field_Config__r.Label,
//                     fieldApi: col.Field_Config__r.Field_Api_Name__c
//                 }));
//             console.log('col' , JSON.stringify(this.columnData));
//             const dr= data.relatedObjectRecords;
//             this.rowData = Object.keys(dr).map(recordId => { //here also change data[1] complete  remove this numbering and do it in  a different way using data structures
                
//                 let obj ={
//                 Id : recordId,
//                 record : this.buildRecord(dr[recordId])};
//                 return obj;
//             });
//             this.isRecordsPresent = this.rowData.length > 0 ;
//             this.hidepageno=this.rowData.length > 5;
//             console.log('isRecordsPresent' , this.isRecordsPresent);
//             console.log('rowData' , JSON.stringify(this.rowData));
//            this. displayRecords();
//         }
//         else if(error){     
//             console.log('error' ,error);
//         }
//     }   
//     buildRecord(value){
//         let record = [];
//         this.columnData.map(column => {
//             record.push(value[column.fieldApi]);
//         });
//         return record;
//     }
   

//   displayRecords() {
//     // console.log('inside display');
    
//     // const filteredData = this.searchTerm ? this.rowData.filter(
//     //   object => { return object.record.some(value => 
//     //     String(value).toLowerCase().startsWith(this.searchTerm.toLowerCase())|| 
//     //       String(value).toLowerCase().includes(this.searchTerm.toLowerCase())
//     // );
//     //   }) : this.rowData;

//       const startIdx = (this.pagenumber - 1) * this.pageSize;
//         console.log('startIdx',startIdx);
//         const endIdx = startIdx + this.pageSize;
//         console.log('endIdx',endIdx);
//         this.paginatedrecords = this.rowData.slice(startIdx, endIdx);
//         console.log(JSON.stringify(this.paginatedrecords));  
//         this.totalPages=Math.ceil(this.rowData.length / this.pageSize);
//     }
//     //   this.isRecordsPresent = this.rowData.length > 0;
//     //     this.rowData.map(value=>{
//     //       return value.record;

//     get canGoToPreviousPage() {
//         return this.pagenumber === 1;
//     }
//     get canGoToNextPage() {
//         return this.pagenumber === this.totalPages;
//     }
//     get isPreviousDisabled() {
//         return this.pagenumber === 1;
//     }
//     get isNextDisabled() {
//         return this.pagenumber === this.totalPages;
//     }
//   handlePreviousPage() {
//         if (this.pagenumber > 1) {
//             this.pagenumber -= 1;
//             this.displayRecords();
//             console.log('this.pageNumber',this.pagenumber);
//         }
//     }
//     handleNextPage() {
//         console.log(this.totalPages,this.pagenumber);
//         console.log('this.pagenumber',this.pagenumber < this.totalPages);
//         if(this.pagenumber < this.totalPages) {
//             this.pagenumber += 1;
//             this.displayRecords();
//             console.log('this.pagenumber',this.pagenumber);
//         }
//     }
//       searchBarMethod(){
//         const searchTermLower = this.searchTerm?.toLowerCase();
//         const filteredData = searchTermLower
//        ? this.rowData.filter(object =>
//       object.record.some(value => {
//         const stringValue = String(value).toLowerCase();
//         return stringValue.startsWith(searchTermLower) || stringValue.includes(searchTermLower);
//       })
//     )
//   : this.rowData;
//       }
//      handleSearchTerm(event) {
//         // this.searchTerm = event.detail;
//         // this.pagenumber=1;
//         // this.displayRecords();
//         this.searchTerm = event.detail.toLowerCase(); 
//         this.filteredData = this.getFilteredData(); 
//         this.pagenumber = 1;
//         this.displayRecords();
//      }
//       };
  


  
//     }
import { LightningElement, api, wire } from 'lwc';
import objectsRelatedToAccount from '@salesforce/apex/ObjectFieldClass.queryMethod';

export default class ObjectFieldParent extends LightningElement {
    objectToDisplay;
    @api recordId;
    columnData = [];
    rowData = [];
    isRecordsPresent = false;
    searchTerm = '';
    pagenumber = 1;
    paginatedrecords = [];
    pageSize = 5;
    totalPages = 0;
    hidepageno = false;

    handleParent(event) {
        this.objectToDisplay = event.detail;
        console.log('objectName', this.objectToDisplay);
    }

    @wire(objectsRelatedToAccount, { accountId: '$recordId', selectedObject: '$objectToDisplay' })
    wiredRecords({ error, data }) {
        if (data) {
            console.log('data', data);
            if (data.metadata && data.relatedObjectRecords) {
                this.columnData = data.metadata.map(col => ({
                    label: col.Field_Config__r.Label,
                    fieldApi: col.Field_Config__r.Field_Api_Name__c
                }));
                console.log('Column Data:', JSON.stringify(this.columnData));

                const dr = data.relatedObjectRecords;
                this.rowData = Object.keys(dr).map(recordId => ({
                    Id: recordId,
                    record: this.buildRecord(dr[recordId])
                }));

                this.isRecordsPresent = this.rowData.length > 0;
                this.hidepageno = this.rowData.length > 5;
                console.log('Is Records Present:', this.isRecordsPresent);
                console.log('Row Data:', JSON.stringify(this.rowData));
                this.displayRecords();
            }
        } else if (error) {
            console.error('Error:', error); 
        }
    }

    buildRecord(value) {
        return this.columnData.map(column => value[column.fieldApi]);
    }

    displayRecords() {
        const startIdx = (this.pagenumber - 1) * this.pageSize;
        const endIdx = startIdx + this.pageSize;
        this.paginatedrecords = this.rowData.slice(startIdx, endIdx);
        this.totalPages = Math.ceil(this.rowData.length / this.pageSize);
        console.log('Paginated Records:', JSON.stringify(this.paginatedrecords));
    }

    get canGoToPreviousPage() {
        return this.pagenumber === 1;
    }
    get canGoToNextPage() {
        return this.pagenumber === this.totalPages;
    }
    get isPreviousDisabled() {
        return this.pagenumber === 1;
    }
    get isNextDisabled() {
        return this.pagenumber === this.totalPages;
    }

    handlePreviousPage() {
        if (this.pagenumber > 1) {
            this.pagenumber -= 1;
            this.displayRecords();
            console.log('Current Page Number:', this.pagenumber);
        }
    }

    handleNextPage() {
        if (this.pagenumber < this.totalPages) {
            this.pagenumber += 1;
            this.displayRecords();
            console.log('Current Page Number:', this.pagenumber);
        }
    }

    handleSearchTerm(event) {
        this.searchTerm = event.detail.toLowerCase();
        this.pagenumber = 1; 
        this.displayRecords(); 
    }
}
