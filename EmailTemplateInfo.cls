public class EmailTemplateInfo {
    //public static String sub = 'New';
    //public static String body = 'XYZ';
    //public static String[] addrs = new String[] {'ramchandanipooja18@gmail.com'};
    
   
    
    public static void sendMail(String sub, String body, String[] addrs)
    {
		Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setSubject(sub);
        email.setPlainTextBody(body);
     	email.setToAddresses(addrs);
        
        Messaging.sendEmailResult [] rs = Messaging.sendEmail (new Messaging.singleEmailMessage[] {email});
      	if(rs[0].isSuccess())
        {
            System.debug('Sent');
        }
        else
        {
            System.debug('NotSent');
        }
       
	}
}