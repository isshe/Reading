/*==============================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : DotComBust.java
* Version      : v1.0.0
* Author       : 初代
* Date         : 2016/01/04
* Description  :
* Function list: 1.
*                2.
*                3.
* History      :
\*==============================================================================*/

import java.util.*;

public class DotComBust {

    private GameHelper helper = new GameHelper();
    private ArrayList<DotCom> DotComList = new ArrayList<DotCom>();     //*新知识
    private int numOfGuesses = 0;

    private void setUpGame() {
         DotCom one = new DotCom();
         DotCom two = new DotCom();
         DotCom three = new DotCom();

         one.setName("Pets.com");
         two.setName("eToys.com");
         three.setName("Go2.com");

         DotComList.add(one);
         DotComList.add(two);
         DotComList.add(three);

         System.out.println("Your goal is to sink three dot coms.");
         System.out.println("Pets.com, eToys.com, Go2.com");
         System.out.println("Try to sink them all in the fewest number of guesses");

         for (DotCom dotComToSet : DotComList) {
              ArrayList<String> newLocation = helper.placeDotCom(3);
              dotComToSet.setLocationCells(newLocation);
         }
    }

    private void startPlaying() {
        while (!DotComList.isEmpty()) {
            String userGuess = helper.getUserInput("Enter a guess");
            checkUserGuess(userGuess);
        }

        finishGame();
    }

    private void checkUserGuess(String userGuess) {
         numOfGuesses++;    //猜测次数+1

         String result = "miss";        //初始化为miss

         for (DotCom dotComToTest :DotComList) {
              result = dotComToTest.checkYourself(userGuess);

              if (result.equals("hit")) {
                  break;
              }

              if (result.equals("kill")) {
                   DotComList.remove(dotComToTest);  //删除击中的dotcom
                   break;
              }
         }
         System.out.println(result);        //列出结果
    }

    private void finishGame() {
         System.out.println("All Dot Coms are dead! Your stock is now worthless.");

         if (numOfGuesses < 18) {
             System.out.println("It only took you " + numOfGuesses + " guesses.");
             System.out.println(" You got out befor your options sank.");
         }
         else {
             System.out.println("Took you long enough. "+ numOfGuesses + " guesses.");
             System.out.println("Fish are dancing with your options");
         }
    }

    public static void main (String[] args) {
         DotComBust game = new DotComBust();
         game.setUpGame();
         game.startPlaying();
    }
}
