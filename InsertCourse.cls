public class InsertCourse {
    public String name {get; set;}
    
    public PageReference insertCourse()
    {
        Course__c c = new Course__c();
       	c.Name = name;
        insert c;
        PageReference p = new PageReference('/apex/InsertionUpdate');
        System.debug(p);
        return p;
    }
    
}