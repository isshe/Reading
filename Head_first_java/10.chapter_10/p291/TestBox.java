/*==============================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : TestBox.java
* Version      : v1.0.0
* Author       : 初代
* Date         : 2016/01/07
* Description  :
* Function list: 1.
*                2.
*                3.
* History      :
\*==============================================================================*/

public class TestBox {

    Integer i;
    int j;

    public static void main(String[] args) {
        TestBox t = new TestBox();
        t.go();
    }

    public void go() {
        j = i;
        System.out.println(j);
        System.out.println(i);
    }
}
