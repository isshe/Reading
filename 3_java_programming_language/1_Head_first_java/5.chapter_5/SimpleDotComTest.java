/*==============================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : SimpleDotComTest.java
* Version      : v1.0.0
* Author       : 初代
* Date         : 2016/01/02
* Description  :
* Function list: 1.
*                2.
*                3.
* History      :
\*==============================================================================*/

public class SimpleDotComTest {
    public static void main (String[] args) {

        int numOfGuesses = 0;
        SimpleDotCom dot = new SimpleDotCom();
        GameHelper helper = new GameHelper();

        int randomNum = (int) (Math.random() *5);
        int[] locations = {randomNum, randomNum+1, randomNum+2};
        dot.setLocationCells(locations);

        //int [] locations = {2, 3, 4};
//        dot.setLocationCells(locations);
//
        boolean isAlive = true;
        while (isAlive == true) {
             String guess = helper.getUserInput("enter a number: ");
             String result = dot.checkYourself(guess);
             numOfGuesses++;

             if (result.equals("kill")) {
                 isAlive = false;
                 System.out.println("You took " + numOfGuesses + " guesses");
             }
        }
//        String userGuess = "2";
//        String result = dot.checkYourself(userGuess);
    }
}
