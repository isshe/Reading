/*==============================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : TestCalendar.java
* Version      : v1.0.0
* Author       : 初代
* Date         : 2016/01/07
* Description  :
* Function list: 1.
*                2.
*                3.
* History      :
\*==============================================================================*/

import java.util.*;


public class TestCalendar {
    public static void main(String[] args) {
        Calendar c = Calendar.getInstance();
        c.set(2016,0,7,19,40);
        System.out.println("set time: " + c.getTime());

        long day1 = c.getTimeInMillis();
        day1 += 1000 * 60 * 60;         // one hour
        c.setTimeInMillis(day1);
        System.out.println("new hour " + c.get(c.HOUR_OF_DAY));

        c.add(c.DATE, 30);
        System.out.println("add 30 days " + c.getTime());

        c.roll(c.DATE, 30);
        System.out.println("roll 30 days " + c.getTime());

        c.set(c.DATE, 1);
        System.out.println("set to 1" + c.getTime());
    }
}
