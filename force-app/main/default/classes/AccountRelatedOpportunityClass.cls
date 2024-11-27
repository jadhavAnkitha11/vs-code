public with sharing class AccountRelatedOpportunityClass {
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> opportunities(Id accId) {
       return [SELECT Id, Name, StageName, Amount, Description FROM Opportunity WHERE AccountId =: accId];
    
    }
    @AuraEnabled
    public static String updateOpps(Opportunity opp) {
        System.debug('Opp Id:'+opp);
        try {
            update opp;
            return 'Successfully updated the Opportunity';
        } catch (Exception e) {
            return 'Error : '+e.getMessage();
        }
        
    }

    // @AuraEnabled
    // public static String deleteOpps(Id oppId) {
    //     System.debug('Opp Id:'+oppId);
    //     try {
    //         Opportunity oppToDelete = [SELECT Id FROM Opportunity WHERE Id = :oppId];
    //         delete oppToDelete;
    //         return 'Opportunity deleted successfully';
    //     } catch (Exception e) {
    //         return 'Error : ' + e.getMessage();
    //     }
    // }
    @AuraEnabled
    public static String deleteOpps(Id oppId) {
        System.debug('Opp Id:'+oppId);
        try {
            
            if (oppId == null) {
                return 'Error: Opportunity ID is invalid or null.';
            }
    
            
            List<Opportunity> oppList = [SELECT Id FROM Opportunity WHERE Id = :oppId];
            
            if (oppList.isEmpty()) {
                return 'Error: No Opportunity found for the provided ID.';
            }
    
            Opportunity oppToDelete = oppList[0];
            delete oppToDelete;
            return 'Opportunity deleted successfully';
        } catch (QueryException qe) {
            return 'Error: Opportunity not found or invalid Id - ' + qe.getMessage();
        } catch (DmlException de) {
            return 'Error: Unable to delete Opportunity - ' + de.getMessage();
        } catch (Exception e) {
            return 'Error: ' + e.getMessage();
        }
    }
    


}
    


