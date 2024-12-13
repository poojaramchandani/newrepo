public class OpportunityLineItemTriggerHandler {
    public static void countNumberOfProduct(List<OpportunityLineItem> newOppLineItemList){
        
        Set<Id> oppIds = new Set<Id>();
        Set<Id> accIds = new Set<Id>();
        if(newOppLineItemList != null && newOppLineItemList.size()>0 && !newOppLineItemList.isEmpty()){
            for(OpportunityLineItem oppLineItem : newOppLineItemList){
                oppIds.add(oppLineItem.OpportunityId); 
            }
        }
        
        
        if(oppIds != null && oppIds.size()>0 && !oppIds.isEmpty()){
            List<Opportunity> oppList = [Select Id, AccountId From Opportunity Where Id IN: oppIds AND AccountId != NULL];
            if(oppList != null && oppList.size()>0 && !oppList.isEmpty()){
                for(Opportunity opp : oppList){
                    accIds.add(opp.AccountId);
                }
            }
            
            if(accIds != null && accIds.size()>0 && !accIds.isEmpty()){
                List<OpportunityLineItem> oppLineItemList2 = [Select Id, Opportunity.AccountId FROM OpportunityLineItem Where Opportunity.AccountId IN: accIds];
                List<Account> accList = [Select Id, Number_of_Products__c FROM Account WHERE Id IN: accIds];
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
    
    
    
    //
    //
    public static void countNumberOfProductOnDeleteOpportunity(List<OpportunityLineItem> oppLineItemList){
        Set<Id> oppIds = new Set<Id>();
        Set<Id> accIds = new Set<Id>();
        if(oppLineItemList != null && oppLineItemList.size()>0 && !oppLineItemList.isEmpty()){
            for(OpportunityLineItem oppLineItem : oppLineItemList){
                if(oppLineItem.Opportunity.AccountId != NULL){
                    accIds.add(oppLineItem.Opportunity.AccountId); 
                }
            }
        }
        
        if(accIds != null && accIds.size()>0 && !accIds.isEmpty()){
                List<OpportunityLineItem> oppLineItemList2 = [Select Id, Opportunity.AccountId FROM OpportunityLineItem Where Opportunity.AccountId IN: accIds];
                List<Account> accList = [Select Id, Number_of_Products__c FROM Account WHERE Id IN: accIds];
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