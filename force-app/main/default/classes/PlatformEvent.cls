public class PlatformEvent {
    public static void platformEvent(List<Id> oppId,Id accId,String classnames){
        String serializedopps=JSON.serialize(oppId);
    List<Parent_Child_Assigning__e> platformEvent=new List<Parent_Child_Assigning__e>();
    Parent_Child_Assigning__e event=new Parent_Child_Assigning__e();
    event.Parent_Id__c=accId;//account Id
    event.Child_Id__c=serializedopps;// opportunity Ids
    event.class_name__c=classnames;
    platformEvent.add(event);
    //platformEvent.add(new Parent_Child_Assigning__e(Child_Id__c='serializedData',Parent_Id__c='001dL00000Ll7bSQAR',class_name__c='AccRelatedOpps'));
    List<Database.SaveResult> results = EventBus.publish(platformEvent);
    for (Database.SaveResult dsr : results) {
        if (dsr.isSuccess()) {
            System.debug('Successfully published event.');
        } else {
            for(Database.Error err : dsr.getErrors()) {
                System.debug('Error returned: ' +
                err.getStatusCode() +
                ' - ' +
                err.getMessage());
            }
        }       
    }
 }
}

//Map<String,string> assigningOppId=new Map<String,string>();
// assigningOppId.put('oppId1','oppId1:006dL000003t5i5QAA');
// assigningOppId.put('oppId2','006dL000002ouKTQAY');
// assigningOppId.put('oppId3','006dL000002ouKeQAI');
// platformEvent.ParentId=accId
// PlatformEvent.class_name__c=classnames;
// platformEvent.Child_Id__c=JSON.serialize(oppId);
//string serializedData=JSON.serialize(oppId);//converting object into string format
// Event_Name__e event =new Event_Name__e();