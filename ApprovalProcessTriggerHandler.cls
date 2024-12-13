public class ApprovalProcessTriggerHandler {
    
    public static void updateApproval(List<Account> newAcc)
    {
        List<Account> aList = new List<Account>();
        for(Account acc : newAcc)
        {
            String billCon = (String)acc.BillingCountry;
            if(acc.CheckBox__c == true &&  billCon.equalsIgnoreCase('india'))
            {
                Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
                req.setComments('Submitting request for approval automatically using Trigger');
                req.setObjectId(acc.Id);
                List<User> user1 = [Select ID, Username from User];
				User user2 = new User();
				for(User u : user1)
				{
                	    String s = u.Username;
						if(s.contains('anav'))
						{
							//System.debug(u.Username);
							user2 = u;
						}					
                }
				//System.debug(user2);
 				List<Id> uList = new List<Id> ();
                uList.add(user2.Id);
                //req.setSubmitterId(user2.Id);
                req.setNextApproverIds(uList);
                //System.debug(req.getNextApproverIds());
                //System.debug(req.getSubmitterId());
                req.setProcessDefinitionNameOrId('Approval_For_CheckBox');
                try
                {
                     Approval.ProcessResult result = Approval.process(req);
                }
                catch(Exception e)
                {
                    System.debug(e);
                }
               
                //System.debug(result);
            }
            
        }
    }
    
}