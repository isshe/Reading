/*==============================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : InetAddressDemo.java
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

public class InetAddressDemo
{
     public static void main(String[] args) throws UnknownHostException
     {
         String host = "localhost";

         if (args.length == 1)
         {
             host = args[0];
         }

         InetAddress ia = InetAddress.getByName(host);

         //???
         System.out.println("Canonical Host Name = " + ia.getCanonicalHostName());
         System.out.println("Host Address = " + ia.getHostAddress());
         System.out.println("Host Name = " + ia.getHostName());
         System.out.println("Is Loopback Address = " + ia.isLoopbackAddress());

     }
}
