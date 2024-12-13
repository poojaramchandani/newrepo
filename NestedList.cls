public class NestedList {
 public static void listnested()
    {
        //List <List<Integer>> list1 = new List <List<Integer>>();
        List <List<Integer>> list1 = new List <List<Integer>>{
					new List<Integer>{11,20,33},		
					new List<Integer>{13,50,11},
                        new List<Integer>{13,50,11}};
																
        /*List<Integer> l1 = new List<Integer>();
        l1.add(11);
        l1.add(20);
        l1.add(33);
        
      	List<Integer> l2 = new List<Integer>{12,40,22};
        List<Integer> l3 = new List<Integer>{13,50,11};    
        list1.add(l1);
        list1.add(l2);    
        list1.add(l3);   */
        System.debug('Hello       Hii   \n');
        System.debug(list1+'\n');
    }
}