public  class WrapperClass {
    @AuraEnabled
    public List<Field_Object_Config__mdt> metadata;
    @AuraEnabled
    public List<SObject> relatedObjectRecords;
    public WrapperClass(List<Field_Object_Config__mdt> metadata,List<Sobject> relatedObjectRecords){
        this.metadata=metadata;
        this.relatedObjectRecords = relatedObjectRecords;
    }
   
}