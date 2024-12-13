public class OpportunityTriggerHandler {
    public static void countNumberOfProduct(List<Opportunity> newOppList, Map<Id,Opportunity> oldOppMap){
        Set<Id> accIds = new Set<Id>();
        if(newOppList != null && newOppList.size()>0 && !newOppList.isEmpty()){
            for(Opportunity opp: newOppList){
                if(opp.AccountId != NULL && oldOppMap.get(opp.Id).AccountId != opp.AccountId){
                    accIds.add(opp.AccountId);
                    accIds.add(oldOppMap.get(opp.Id).AccountId);
                }
            }
        }
        
        if(accIds != null && accIds.size()>0 && !accIds.isEmpty()){
            List<Account> accList = [Select Id, Number_of_Products__c FROM Account WHERE Id IN: accIds];
            List<OpportunityLineItem> oppLineItemList2 = [Select Id, Opportunity.AccountId FROM OpportunityLineItem Where Opportunity.AccountId IN: accIds];
            if(accList != null && accList.size()>0 && !accList.isEmpty()){
                for(Account acc: accList){
                    Integer i=0;
                    if(oppLineItemList2 != null && oppLineItemList2.size()>0 && !oppLineItemList2.isEmpty()){
                        for(OpportunityLineItem oppLineItem : oppLineItemList2){
                            if(oppLineItem.Opportunity.AccountId == acc.Id){
                                i++;
                            }
                        }
                    }
                    acc.Number_of_Products__c = i;
                }
                UPDATE accList;
            }
        }
    }
    
    public static void countNumberOfProductOnDeleteUndeleteOpportunity(List<Opportunity> oppList){
        Set<Id> accIds = new Set<Id>();
        if(oppList != null && oppList.size()>0 && !oppList.isEmpty()){
            for(Opportunity opp: oppList){
                if(opp.AccountId != NULL){
                    accIds.add(opp.AccountId);
                }
            }
        }
        
        if(accIds != null && accIds.size()>0 && !accIds.isEmpty()){
            List<Account> accList = [Select Id, Number_of_Products__c FROM Account WHERE Id IN: accIds];
            List<OpportunityLineItem> oppLineItemList2 = [Select Id, Opportunity.AccountId FROM OpportunityLineItem Where Opportunity.AccountId IN: accIds];
            if(accList != null && accList.size()>0 && !accList.isEmpty()){
                for(Account acc: accList){
                    Integer i=0;
                    if(oppLineItemList2 != null && oppLineItemList2.size()>0 && !oppLineItemList2.isEmpty()){
                        for(OpportunityLineItem oppLineItem : oppLineItemList2){
                            if(oppLineItem.Opportunity.AccountId == acc.Id){
                                i++;
                            }
                        }
                    }
                    acc.Number_of_Products__c = i;
                }
                UPDATE accList;
            }
        }
    }
}