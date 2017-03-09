/*==============================================================================\
* Copyright(C)2015 Chudai.
*
* File name    : p37_Movie.java
* Version      : v1.0.0
* Author       : 初代
* Date         : 2015/12/30
* Description  :
* Function list: 1.
*                2.
*                3.
* History      :
\*==============================================================================*/


public class MovieTestDrive {
    public static void main(String[] args) {
        Movie one = new Movie();
        one.title = "one";
        one.genre = "one genre";
        one.rating = -2;

        Movie two = new Movie();
        two.title = "two";
        two.genre = "two genre";
        two.rating = 5;
        two.PlayIt();

        Movie three = new Movie();
        three.title = "three";
        three.genre = "three genre";
        three.rating = 127;
    }
}
