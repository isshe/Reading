/*==============================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : MyAnimalList.java
* Version      : v1.0.0
* Author       : 初代
* Date         : 2016/01/05
* Description  :
* Function list: 1.
*                2.
*                3.
* History      :
\*==============================================================================*/

public class MyAnimalList {
    private Animal[] animals = new Animal[5];
    private int nextIndex = 0;

    public void add(Animal a) {
        if (nextIndex < animals.length) {
            animals[nextIndex] = a;
            System.out.println("Animal added at " + nextIndex);
            nextIndex++;
        }
    }
}
