/*==============================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : GoodDogTest.java
* Version      : v1.0.0
* Author       : 初代
* Date         : 2016/01/02
* Description  :
* Function list: 1.
*                2.
*                3.
* History      :
\*==============================================================================*/

class GoodDogTest {

    public static void main (String[] args) {
        GoodDog one = new GoodDog();
        GoodDog two = new GoodDog();

        one.setSize(70);
        two.setSize(8);

        System.out.println("Dog one: " + one.getSize());
        System.out.println("Dog two: " + two.getSize());

        one.bark();
        two.bark();
    }
}
