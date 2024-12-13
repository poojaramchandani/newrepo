public class FinalAssg2Apex {
    @AuraEnabled
    public static void insertObj(String f, String l, String street, String city, String state, String code, String country, String phon, String mail)
    {
        System.debug('ok111');
        Contact c = new Contact();
        c.FirstName = f;
        c.LastName = l;
        c.MailingStreet = street;
        c.MailingCity = city;
        c.MailingState = state;
        c.MailingPostalCode = code;
        c.MailingCountry = country;
        c.Phone = phon;
        c.Email = mail;
        System.debug('ok111');
        system.debug(c);
      	insert c;
        insertStripe(c);
       System.debug('inserted');
    }
    @AuraEnabled
    public static void insertStripe(Contact c)
    {
        Stripe__c s = new Stripe__c	();
        s.Contact__c = c.Id;
        s.Price__c = 400;
        s.Order_Status__c = 'Order Placed';
        insert s;
        System.debug('inserted');
    }

}