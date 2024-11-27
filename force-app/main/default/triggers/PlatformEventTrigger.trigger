
trigger PlatformEventTrigger on Parent_Child_Assigning__e (after insert) {
    if (Trigger.isAfter && Trigger.isInsert) {
        PlatformEventTriggerHandler.handleOpportunityEvents(Trigger.new);
    }
}
