public class ContactLeadHandler implements Database.Batchable<SObject>  {
    public Database.QueryLocator start(Database.BatchableContext bc) {
      return Database.getQueryLocator(
        'SELECT Id , Name, Phone , Email  FROM Lead  LIMIT 40000'
      );
    }
    public void execute(Database.BatchableContext bc, List<Lead> scope) {
        Map<Id,Contact> mapLeadCon = new Map<Id,Contact>();
        List<Contact> contacts= [SELECT Id , Name , Phone , Email FROM Contact ORDER BY LastModifiedDate LIMIT 40000];
        for(Lead leads : scope){
          for(Contact con : contacts){
            if(leads.Name != null && leads.Phone != null && con.Name != null && con.Phone != null && leads.Name == con.Name && leads.Phone == con.Phone){
              mapLeadCon.put(leads.Id , con);
            }else if(leads.Name != null && leads.Email != null && con.Name != null && con.Email != null && leads.Name == con.Name && leads.Email == con.Email){
              mapLeadCon.put(leads.Id , con);
            }else if(leads.Email != null && leads.Phone != null && con.Email != null && con.Phone != null && leads.Email == con.Email && leads.Phone == con.Phone){
              mapLeadCon.put(leads.Id , con);
            }else if(leads.Name != null && leads.Phone != null &&  leads.Email != null && con.Name != null && con.Phone != null && Con.Email!= null && leads.Name == con.Name && leads.Phone == con.Phone && leads.Email == con.Email){
              mapLeadCon.put(leads.Id , con);
            }
          }
        }
        System.debug('inside map --->'+ mapLeadCon );
        // for(Lead le : scope){
        //     for(Contact con : mapCon.values()){
        //         if((le.Name != null && le.Phone != null && con.Name != null && con.Phone != null && le.Name == con.Name && le.Phone == con.Phone)||
        //            (le.Name != null && le.Email != null && con.Name != null && con.Email != null && le.Name == con.Name && le.Email == con.Email)||
        //            (le.Email != null && le.Phone != null && con.Email != null && con.Phone != null && le.Email == con.Email && le.Phone == con.Phone)||
        //            (le.Name != null && le.Phone != null &&  le.Email != null && con.Name != null && con.Phone != null && Con.Email!= null && le.Name == con.Name && le.Phone == con.Phone && le.Email == con.Email)
        //          ){
        //             mapLeadCon.put(le.Id , con);
        //         }
        //     }
        // }
    }
  public void finish(Database.BatchableContext bc) {
    System.debug('');
  }
}






