/*==============================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : SimpleDotCom.java
* Version      : v1.0.0
* Author       : 初代
* Date         : 2016/01/02
* Description  :
* Function list: 1.
*                2.
*                3.
* History      :
\*==============================================================================*/

public class SimpleDotCom {
    int [] locationCells ;
    int numOfHits = 0;

    public void setLocationCells (int[] locs) {
        locationCells = locs;
    }

    public String checkYourself( String stringGuess ) {
        int guess = Integer.parseInt(stringGuess);
        String result = "miss";

        for (int cell : locationCells) {
            if (guess == cell) {
                //在此把locationCells的相应元素清0即可处理重复hit的bug。
                //现在不懂如何做， 如果是for（；；）这种可能会。
                result = "hit";
                numOfHits++;
                break;
            }
        }

        if (numOfHits == locationCells.length) {
             result = "kill";
        }

        System.out.println(result);
        return result;
    }
}
