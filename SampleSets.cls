public class SampleSets {
    
    public static void setMethod()
    {
		Set<Integer> s1 = new Set<Integer>();
   		 s1.add(1);
   		 s1.add(2);
    
        Set<Integer> s2 = new Set<Integer>{3,4,1};
            
    	Set<String> s3 = new Set<String>();
   	 		s3.add('Pooja');
   			 s3.add('User');
  		  	    
   		Set<String> s4 = new Set<String>{'New','User','Done'};
    	Set<College__C> s5 = new Set<College__C>();
  		College__C c1 = new College__C(Name = 'Jecc');
        College__C c2 = new College__C(Name = 'Jecc');
        //will not take duplicate values so will replace c1 by c2
        College__C c3 = new College__C(Name = 'NIT');
  		s5.add(c1);
        s5.add(c2);
        s5.add(c3);
        System.debug(s2);
        System.debug(s2);
        System.debug(s3);
        System.debug(s4);
        System.debug(s5);
        
        //set methods
        System.debug(s2.size());
        s2.remove(3);
        System.debug(s2);//show 1,4
        s2.removeAll(s1);
      	System.debug(s2);//show 4
        s2.addall(s1);
        System.debug(s2);//show 1,4,2
        System.debug(s2.contains(4));//show true
        System.debug(s2.containsAll(s1));//show true
        
        Set<Integer> s6 = new Set<Integer>{9};
        
        //System.debug(s2.retainAll(s6));
        //System.debug(s2);
        Set <Integer> s7 = s6.clone();
        System.debug(s7);
        s7.clear();
        System.debug(s7);
        
    }
}