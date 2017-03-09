/*==============================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : DotCom.java
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

public class DotCom {
    private ArrayList<String> locationCells;
    private String name;

    public void setLocationCells(ArrayList<String> loc) {
        locationCells = loc;
    }

    public void setName(String n) {
         name = n;
    }

    public String checkYourself(String userInput) {
        String result = "miss";

        int index = locationCells.indexOf(userInput);
        if (index >= 0) {               //击中
            locationCells.remove(index);  //删除此元素

            if (locationCells.isEmpty()) {
                result = "kill";
                System.out.println("Ouch! you sunk " + name + "  : ( ");
            }
            else{
                 result = "hit";
            }
        }

        return result;
    }
}
