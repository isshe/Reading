/*==============================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : MyInetAddress3.java
* Version      : v1.0.0
* Author       : i.sshe
* Date         : 2016/03/01
* Description  : 通过名字获取所有的ip地址
* Function list: 1.
*                2.
*                3.
* History      :
\*==============================================================================*/

import java.net.*;

public class MyInetAddress3
{
     public static void main(String[] args) throws Exception
     {
         if (args.length == 0)
         {
              System.out.println("Usage: java MyInetAddress3 yourname");
              return;
         }

         String host = args[0];
         InetAddress addresses[] = InetAddress.getAllByName(host);
         for (InetAddress address : addresses)
         {
              System.out.println(address);
         }
     }
}
