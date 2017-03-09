/*==============================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : GetHostName.java
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

public class GetHostName
{
     public static void main(String args[])
     {
         try
         {
              InetAddress ad = InetAddress.getByName(args[0]);
              System.out.println("主机名为: " + ad.getHostName());
         }
         catch (UnknownHostException el)
         {
              el.printStackTrace();
         }
     }
}
