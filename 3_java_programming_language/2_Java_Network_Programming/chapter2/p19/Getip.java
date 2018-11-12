/*==============================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : Getip.java
* Version      : v1.0.0
* Author       : i.sshe
* Date         : 2016/03/01
* Description  :
* Function list: 1.
*                2.
*                3.
* History      :
\*==============================================================================*/

import java.net.*;

public class Getip
{
     public static void main(String[] args) throws Exception
     {
         try
         {
              InetAddress add = InetAddress.getByName(args[0]);
              System.out.println("ip address :" + add.getHostAddress());
         }
         catch(UnknownHostException el)
         {
              el.printStackTrace();
         }
     }
}
