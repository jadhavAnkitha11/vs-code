public with sharing class PlatformEventFactory {
    public static PlatformEventInterface getHandler(String objectType) {
        if (objectType == 'Opportunity') {
            return new PlatformEventforStandaradObject();
        } else if (objectType == 'Gadget__c') {
            return new PlatformEventforCustomObject();
        } else {
            throw new IllegalArgumentException('Unsupported object type: ' + objectType);
        }
    }
}