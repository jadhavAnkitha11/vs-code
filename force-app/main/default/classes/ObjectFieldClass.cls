public class ObjectFieldClass {
    @AuraEnabled(cacheable=true)
    public static Map<String, Object> queryMethod(Id accountId, String selectedObject) {
        // Retrieve the metadata for the specified object
        List<Field_Object_Config__mdt> metaData = [
            SELECT Field_Config__r.Label, Field_Config__r.Field_Api_Name__c 
            FROM Field_Object_Config__mdt 
            WHERE Object_Config__r.Label = :selectedObject
        ];

        Map<String, Object> responseMap = new Map<String, Object>();
        Set<String> columns = new Set<String>();
        List<Field_Object_Config__mdt> validMetadata = new List<Field_Object_Config__mdt>();
        Map<String, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe().get(selectedObject).getDescribe().fields.getMap();
        for (Field_Object_Config__mdt mdt : metaData) {
            String fieldApiName = mdt.Field_Config__r.Field_Api_Name__c?.trim(); 

            if (fieldApiName != null && fieldMap.containsKey(fieldApiName)) {
                columns.add(fieldApiName);
                validMetadata.add(mdt);
            } else {
                System.debug('Invalid field ignored: ' + fieldApiName);
            }
        }
        if (!columns.isEmpty()) {
            responseMap.put('metadata', validMetadata);
            String query = 'SELECT Id, ' + String.join(columns, ', ') + 
                           ' FROM ' + selectedObject + 
                           ' WHERE AccountId = :accountId ' + 
                           ' ORDER BY LastModifiedDate DESC';

            System.debug('Generated Query: ' + query);
            List<SObject> relatedObjectRecords = Database.query(query);
            Map<Id, SObject> recordsMap = new Map<Id, SObject>();
            for (SObject record : relatedObjectRecords) {
                recordsMap.put(record.Id, record); 
            }
            responseMap.put('relatedObjectRecords', recordsMap);
        } else {
            System.debug('No valid fields found for query.');
        }
        
        return responseMap;
    }
}
