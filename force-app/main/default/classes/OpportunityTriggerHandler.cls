public with sharing class OpportunityTriggerHandler {
    public static void afterUpdate(
      List<Opportunity> oppNew,
      Map<Id, Opportunity> oppOldMap
    ) {
      List<Opportunity> oppList = new List<Opportunity>();
      //  List<Decimal> oldOppList = new List<Decimal>();
      // Set<Id> accId = new Set<Id>();
      Map<Id, Decimal> accAmount = new Map<Id, Decimal>();
      for (Opportunity eachOpp : oppNew) {
        if (eachOpp.Amount != oppOldMap.get(eachOpp.Id).Amount) {
          Opportunity oldOpp = oppOldMap.get(eachOpp.Id);

          //||
          //check if amount got deducted or increase

                Decimal oldAmount = oldOpp.Amount != null ? oldOpp.Amount:0; 
                Decimal newAmount = eachOpp.Amount != null ? eachOpp.Amount : 0; 
                Decimal amountDifference = newAmount - oldAmount; 
          
          if (eachOpp.Amount > oppOldMap.get(eachOpp.Id).Amount) {
            //increased amount
            Decimal increasedAmount=oppOldMap.get(eachOpp.Id).Amount+eachOpp.Amount;
            
          } else {
            //decreased amount
            Decimal decreasedAmount=oppOldMap.get(eachOpp.Id).Amount - eachOpp.Amount;
      
          }
          oppList.add(eachOpp);
          accAmount.put(eachOpp.AccountId, eachOpp.Amount);
        } else if (eachOpp.AccountId <> oppOldMap.get(eachOpp.Id).AccountId) {
          //if Account is lost on Opp.
          if (String.isBlank((String) eachOpp.AccountId)) {
            accAmount.put(eachOpp.AccountId, 0);

            //get old account from old opp map
          } else {
            accAmount.put(
              oppOldMap.get(eachOpp.Id).AccountId,
              oppOldMap.get(eachOpp.Id).Amount
            );
            //get new account to update or increment new value
            //get old account to decrement lost value.
          }
        } 
      }
      List<Account> accList = [
        SELECT Id, SumOfOppAmount__c
        FROM Account
        WHERE Id IN :accAmount.keySet()
      ];
      updateSumOfOppsAmount(oppList, accList, accAmount);
    }
    private static void updateAccountIfOppIsLost(){
    }
    // public static void afterInsert(List<Opportunity> newOpp){
    //     Set<Id> accId = new Set<Id>();
    //     for(Opportunity eachOpp : newOpp){
    //         accId.add(eachOpp.AccountId);
    //     }
    //     updateSumOfOppsAmount(newOpp, accId);
    // }
    public static void updateSumOfOppsAmount(
      List<Opportunity> oppList,
      List<Account> accList,
      Map<Id, Decimal> accAmount
    ) {
      Map<Id, Account> accMap = new Map<Id, Account>();
      // List<Id> accIdList = new List<Id>(accIdSet);
      Integer i = 0;
      for (Opportunity opp : oppList) {
        if (
          accAmount.containsKey(opp.AccountId) &&
          opp.Amount != null &&
          accList[i].Id == opp.AccountId
        ) {
          if (!accMap.containsKey(opp.AccountId)) {
            accMap.put(
              opp.AccountId,
              new Account(
                Id = opp.AccountId,
                SumOfOppAmount__c = accList[i].SumOfOppAmount__c -
                  accAmount.get(opp.AccountId)
              )
            );
          }
          Account acc = accMap.get(opp.AccountId);
          acc.SumOfOppAmount__c += opp.Amount; //map get decimal amoutn
          accMap.put(opp.AccountId, acc);
        }
        i++;
      }
      // Correctly working code but should be Optimized by removing query.
      // for(Opportunity eachOpp : [Select Id, AccountId, Amount from Opportunity where Amount != null AND AccountId IN : accIdSet with SECURITY_ENFORCED]){
      //     if(!accMap.containsKey(eachOpp.AccountId)){
      //         accMap.put(eachOpp.AccountId, new Account(Id = eachOpp.AccountId, SumOfOppAmount__c = 0));
      //     }
      //     Account acc = accMap.get(eachOpp.AccountId);
      //     acc.SumOfOppAmount__c += eachOpp.Amount;
      //     accMap.put(eachOpp.AccountId, acc);
      // }
      update accMap.values();
      // Previous written code.
      // for (Opportunity eachOpp : oppList) {
      //     // Account a = oppMap.get(eachOpp.AccountId);
      //     if(eachOpp.Account.SumOfOppAmount__c == null){
      //         eachOpp.Account.SumOfOppAmount__c = 0;
      //     }
      //     eachOpp.Account.SumOfOppAmount__c += eachOpp.Amount;
      // }
    }
  }