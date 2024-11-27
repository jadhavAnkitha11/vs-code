trigger ContactTrigger on Contact (before insert,before update,after update) {
    TriggerHandler th=new TriggerHandler();
    if (Trigger.isBefore){
        if(Trigger.isInsert){
        th.beforeInsert(Trigger.new);
    }
    if (Trigger.isUpdate){
        th.beforeUpdate(Trigger.new,Trigger.oldMap);
    }
    
    
}
}
