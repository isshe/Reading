/*==============================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : AnimalTest.java
* Version      : v1.0.0
* Author       : 初代
* Date         : 2016/01/05
* Description  :
* Function list: 1.
*                2.
*                3.
* History      :
\*==============================================================================*/

public class AnimalTest {
    public static void main( String[] args ) {
        MyAnimalList list = new MyAnimalList();
        Dog a = new Dog();
        Cat c = new Cat();
        list.add(a);
        list.add(c);

        System.out.println("//测试继承！");
        a.eat();
        a.sleep();

        System.out.println("//测试继承！");
        c.eat();
        c.sleep();
    }
}
