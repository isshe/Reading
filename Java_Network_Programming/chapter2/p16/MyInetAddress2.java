/*==============================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : MyInetAddress2.java
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

public class MyInetAddress2
{
     public static void main(String[] args) throws Exception
     {
         if (args.length == 0)
         {
             System.out.println("Usage: java MyInetAddress2 Your_name");
              return;
         }
         String host = args[0];

         try
         {
              InetAddress address = InetAddress.getByName(host);
              System.out.println(address);
         }
         catch (UnknownHostException el)
         {
              el.printStackTrace();
         }
     }
}
