public class PlatformEventforCustomObject implements  PlatformEventInterface {
    public void accoppInterface(List<Parent_Child_Assigning__e> pca) {
        List<Id> childIds = new List<Id>(); //creating a list to store new parent Ids
        Map<Id, Id> childToNewParentMap = new Map<Id, Id>();
        for (Parent_Child_Assigning__e events : pca) {  //gathering of child ids and new parent ids
            List<Id> ids = (List<Id>)JSON.deserializeUntyped(events.Child_Id__c);
            Id newParentId = events.Parent_Id__c;
            for (Id id : ids) { // Add child IDs to the list and map it to the new parent ID
                childIds.add(id);
                childToNewParentMap.put(id, newParentId);
            }
        }
        List<Gadget__c> updatecustomobj = [SELECT Id FROM Gadget__c WHERE Id IN :childIds];
        for (Gadget__c gad :updatecustomobj) {
            gad.Account__c = childToNewParentMap.get(gad.Id);
        }
        if (!updatecustomobj.isEmpty()) {
                update updatecustomobj;
            } 
        }
    }

