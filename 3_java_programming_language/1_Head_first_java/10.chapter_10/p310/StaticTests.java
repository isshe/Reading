/*==============================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : StaticSuper.java
* Version      : v1.0.0
* Author       : 初代
* Date         : 2016/01/07
* Description  :
* Function list: 1.
*                2.
*                3.
* History      :
\*==============================================================================*/


//编译不过,,, 不懂!!!
//
package p310;

class StaticSuper {
    static {
        System.out.println("super static block");
    }

    StaticSuper {
        System.out.println("super constructor");
    }
}

public class StaticTsts extends StaticSuper {
    static int rand;

    static {
         rand = (int) (Math.random() * 6);
         System.out.println("static block " + rand);
    }

    StaticTests() {
        System.out.println("constructor");
    }

    public static void main(String[] args) {
         System.out.println("in main");
         StaticTests st = new StaticTests();
    }
}
