trigger AccountTrigger on Account (after Update) {
    if (Trigger.isAfter && Trigger.isUpdate){
       new TriggerHandler().afterUpdate(Trigger.new,Trigger.oldMap);
    }
}