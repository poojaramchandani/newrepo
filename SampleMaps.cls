public class SampleMaps {
	public static void mapMethod()
    {
        Set<Integer> s6 = new Set<Integer>{9};
        Map <Integer, Set<Integer>> m1 = new Map <Integer, Set<Integer>>();
    	m1.put(1,s6);//add values in map
        System.debug(m1);
        
        Map <Integer, Integer> m2 = new Map <Integer, Integer>();
        m2.put(2,12);
        m2.put(1,11);
        m2.put(1,12);//just override the first key and value bcoj key is duplicate
        System.debug(m2);
        
        //initializing and assigning values in map together
        Map <Integer, String> m3 = new Map <Integer, String>{1=>'One', 2=>'two', 3=>'three'};
        System.debug(m3);
        
       //map methods
        Map <Integer, String> m4 = new Map <Integer, String>();
        m4.putAll(m3);//put all the values of m3 into m4
        System.debug(m4);  
        
        List<String> l1 = m4.values();//store all values in list of string type
        System.debug(l1);
        
        System.debug(m4.get(1));//get the value of mentioned key
        
        
        System.debug(m4.isEmpty());
        Map <Integer, String> m5 = new Map <Integer, String>();
        System.debug(m5.isEmpty());//check map is empty or not
        
        System.debug(m4.keySet());//return all the keys of the mentioned map
       
        Map <Integer, Integer> m6 = new Map <Integer, Integer>{4=>1};
        m6 = m2.clone();//clone m2 in m6 and clear all previous values of  m6
        System.debug(m6);
        
        System.debug(m6.containsKey(5));//contains the mentioned key or not
        
        System.debug(m1.size());//return size of mentioned map
        
        m2.remove(1);//remove the key and value of mentioned key
        System.debug(m2);
        
        m6.clear();//remove all  the values of m6
        System.debug(m6);
        
    }
}