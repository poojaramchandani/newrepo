public class NewMergeCommand {
    public static void mergeCommand()
    {
		List<Account> list1 = [SELECT name, Id, type from Account where name LIKE 'Axis%' LIMIT 3];
        Account a = list1[0];
   		Account b = list1[1];
   		Account c = list1[2];
        merge a b;
        /*System.debug(a);
        List<Account> mergelist = new List<Account>();
        mergelist.add(b);
        mergelist.add(c);
        merge a mergelist;*/
        
    }
    
     public static void deleteCommand()
    {
        List <Account> deletedAcc = [Select Name from Account where isDeleted = true and LastModifiedDate = Today ALL ROWS];
        undelete deletedAcc;
    }
}