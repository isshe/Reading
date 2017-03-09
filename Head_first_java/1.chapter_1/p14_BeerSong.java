/*==============================================================================\
* Copyright(C)2015 Chudai.
*
* File name    : p14_BeerSong.java
* Version      : v1.0.0
* Author       : 初代
* Date         : 2015/12/30
* Description  :
* Function list: 1.
*                2.
*                3.
* History      :
\*==============================================================================*/

public class p14_BeerSong {
    public static void main(String[] args) {
        int beerNum = 99;
        String word = "bottles";

        while (beerNum > 0) {
            if (beerNum == 1) {
                word = "bottle";        //单数的瓶子
            }

            System.out.println(beerNum + " " + word + " of beer on the wall ");
            System.out.println(beerNum + " " + word + " of beer.");
            System.out.println("Take one down.");
            System.out.println("Pass it aroud.");
            beerNum = beerNum - 1;

            if (beerNum > 0) {
                System.out.println(beerNum + " " + word + " of beer on the wall");
            }
            else {
                System.out.println("No more bottles of beer on the wall");
            }//else
        }//while
    }//main方法
}//class
