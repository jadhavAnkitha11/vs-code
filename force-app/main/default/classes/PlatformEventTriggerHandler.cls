
public class PlatformEventTriggerHandler {
    public static void handleOpportunityEvents(List<Parent_Child_Assigning__e> pca) {
        if (pca == null || pca.isEmpty()) {
            System.debug('No events to process.');
            return; 
        }
        for (Parent_Child_Assigning__e event : pca) {
            String objectType = event.class_name__c;
            PlatformEventInterface pei = PlatformEventFactory.getHandler(objectTy  pe);
            if (pei != null) {
                pei.accoppInterface(pca); 
            } else {
                System.debug('No handler found for object type: ' + objectType);
            }
        }  
    }
}
-------------------------------------------------------------------------------------------------------
//public class PlatformEventTriggerHandler {
//     public static void handleOpportunityEvents(List<Parent_Child_Assigning__e> pca) {
//         // Check if the list is null or empty
//         if (pca == null || pca.isEmpty()) {
//             System.debug('No events to process.');
//             return; 
//         }
        
//         // Ensure the class_name__c field exists on the Parent_Child_Assigning__e object
//         Map<String, Schema.SObjectField> eventFields = Schema.SObjectType.Parent_Child_Assigning__e.fields.getMap();
//         if (!eventFields.containsKey('class_name__c')) {
//             System.debug('Field class_name__c does not exist on Parent_Child_Assigning__e.');
//             return;
//         }

//         for (Parent_Child_Assigning__e event : pca) {
//             // Validation: Check if class_name__c is not null and not empty
//             if (String.isBlank(event.class_name__c)) {
//                 System.debug('Event missing class_name__c. Skipping this event.');
//                 continue;
//             }

//             // Get the object type dynamically from the event’s class_name__c
//             String objectType = event.class_name__c;
            
//             // Validation: Check if the object type exists in the system
//             Map<String, Schema.SObjectType> allObjects = Schema.getGlobalDescribe();
//             if (!allObjects.containsKey(objectType)) {
//                 System.debug('Object type ' + objectType + ' does not exist in Salesforce. Skipping this event.');
//                 continue;
//             }
            
//             // Retrieve the appropriate handler for the object type
//             PlatformEventInterface pei = PlatformEventFactory.getHandler(objectType);
//             if (pei != null) {
//                 // Validation: Additional checks based on specific requirements
//                 if (isValidEvent(event)) {
//                     pei.accoppInterface(pca); 
//                 } else {
//                     System.debug('Event failed validation checks. Skipping this event.');
//                 }
//             } else {
//                 System.debug('No handler found for object type: ' + objectType);
//             }
//         }
//     }
    
//     // Helper method to perform custom validation logic on the event
//     private static Boolean isValidEvent(Parent_Child_Assigning__e event) {
//         // Example validation: Check if a required field (e.g., related record Id) is populated
//         if (String.isBlank(event.related_record_id__c)) {
//             System.debug('Related record ID is required but missing in event.');
//             return false;
//         }
        
//         // Additional validation checks can go here (e.g., specific field values)
        
//         return true; // Return true if all checks pass
//     }
// }
 