/*==============================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : Internet.java
* Version      : v1.0.0
* Author       : i.sshe
* Date         : 2016/03/04
* Description  :
* Function list: 1.
*                2.
*                3.
* History      :
\*==============================================================================*/

import java.net.*;

class Internet
{
     public static void main(String[] args)
     {
         try
         {
              InetAddress inetadd;
              inetadd = InetAddress.getLocalHost();
              System.out.println("hostname = " + inetadd.getHostName());
              System.out.println(inetadd.toString());
         }
         catch(Exception e)
         {
              System.out.println(e);
         }
     }
}
