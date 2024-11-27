
import { LightningElement, wire } from 'lwc';
import getAccounts from '@salesforce/apex/AccordionClass.accounts';
import getContacts from '@salesforce/apex/AccordionClass.contacts';
import getOpportunities from '@salesforce/apex/AccordionClass.opportunities';
import getCases from '@salesforce/apex/AccordionClass.cases';
export default class Accordion extends LightningElement {
    accounts = [];
    activeSectionMessage = '';
    activeSections = {};
    @wire(getAccounts)
    wiredAccounts({ data, error }) {
        if (data) {
            // Initialize accounts with empty contacts, opportunities, and cases arrays
            this.accounts = data.map(account => ({
                ...account,
                contacts: [],
                opportunities: [],
                cases: []   
            }));
        } else if (error) {     
            console.error(error);
        }
    }
    handleToggleSection(event) {
        const accountId = event.detail.openSections;
        this.activeSectionMessage = accountId;
        // Load related records for the account if not already loaded
        const account = this.accounts.find(acc => acc.Id === accountId);
        if (account && account.contacts.length === 0) {
            this.loadRelatedRecords(accountId);
        }
    }
    loadRelatedRecords(accountId) {
        // Fetch contacts
        getContacts({ accountId })
            .then(contacts => {
                this.updateAccountRelatedRecords(accountId, 'contacts', contacts);
            })
            .catch(error => {
                console.error('Error fetching contacts:', error);
            });
        // Fetch opportunities
        getOpportunities({ accountId })
            .then(opportunities => {
                this.updateAccountRelatedRecords(accountId, 'opportunities', opportunities);
            })
            .catch(error => {
                console.error('Error fetching opportunities:', error);
            });
        // Fetch cases
        getCases({ accountId })
            .then(cases => {
                this.updateAccountRelatedRecords(accountId, 'cases', cases);
            })
            .catch(error => {
                console.error('Error fetching cases:', error);
            });
    }
    updateAccountRelatedRecords(accountId, recordType, records) {
        this.accounts = this.accounts.map(account => {
            if (account.Id === accountId) {
                return { ...account, [recordType]: records };
            }
            return account;
        });
    }
}

// import { LightningElement, wire, track } from 'lwc';
// import getAccounts from '@salesforce/apex/AccordionClass.accounts';
// import getContacts from '@salesforce/apex/AccordionClass.contacts';
// import getOpportunities from '@salesforce/apex/AccordionClass.opportunities';
// import getCases from '@salesforce/apex/AccordionClass.cases';

// export default class Accordion extends LightningElement {
//     @track accounts = [];
//     activeSections = []; // Track the active sections for the accordion

//     @wire(getAccounts)
//     wiredAccounts({ data, error }) {
//         if (data) {
//             this.accounts = data.map(account => ({
//                 ...account,
//                 contacts: [],
//                 opportunities: [],
//                 cases: []
//             }));
//         } else if (error) {
//             console.error(error);
//         }
//     }

//     handleToggleSection(event) {
//         const { openSections } = event.detail;
//         const accountId = openSections.length > 0 ? openSections[0] : null;

//         if (accountId && !this.activeSections.includes(accountId)) {
//             this.loadRelatedRecords(accountId);
//         }
//         this.activeSections = openSections; // Update the active sections based on user clicks
//     }

//     loadRelatedRecords(accountId) {
//         // Load contacts
//         getContacts({ accountId })
//             .then(contacts => {
//                 this.updateAccountRelatedRecords(accountId, 'contacts', contacts);
//             })
//             .catch(error => {
//                 console.error('Error fetching contacts:', error);
//             });

//         // Load opportunities
//         getOpportunities({ accountId })
//             .then(opportunities => {
//                 this.updateAccountRelatedRecords(accountId, 'opportunities', opportunities);
//             })
//             .catch(error => {
//                 console.error('Error fetching opportunities:', error);
//             });

//         // Load cases
//         getCases({ accountId })
//             .then(cases => {
//                 this.updateAccountRelatedRecords(accountId, 'cases', cases);
//             })
//             .catch(error => {
//                 console.error('Error fetching cases:', error);
//             });
//     }

//     updateAccountRelatedRecords(accountId, recordType, records) {
//         this.accounts = this.accounts.map(account => {
//             if (account.Id === accountId) {
//                 return { ...account, [recordType]: records };
//             }
//             return account;
//         });
//     }
// }










