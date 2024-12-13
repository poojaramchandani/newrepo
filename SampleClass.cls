public class SampleClass {
    public static void myMethod()
    {
        List <String> list1 = new List<String>();
        list1.add('One');
        list1.add('Two');
        System.debug(list1);
        List <String> list2 = new List<String>{'yes', 'no'};
        System.debug(list2);
    }

}