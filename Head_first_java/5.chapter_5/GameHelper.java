/*==============================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : GameHelper.java
* Version      : v1.0.0
* Author       : 初代
* Date         : 2016/01/02
* Description  :
* Function list: 1.
*                2.
*                3.
* History      :
\*==============================================================================*/

import java.io.*;       //

public class GameHelper {

    public String getUserInput(String prompt) {
        String inputLine = null;
        System.out.print(prompt + " ");

        try {
            BufferedReader is ;
            is = new BufferedReader(new InputStreamReader(System.in)); //

            inputLine = is.readLine();

            if (inputLine.length() == 0){
                 return null;
            }
        }
        catch (IOException e) {
            System.out.println("IOException: " + e);
        }

        return inputLine;
    }
}
