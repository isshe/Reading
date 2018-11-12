/*==============================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : MyInetAddress4.java
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

public class MyInetAddress4
{
     public static void main(String[] args) throws Exception
     {
         //ip = 141.146.8.66
         byte ip[] = new byte[] {(byte)141, (byte)146, 8, 66};
         InetAddress address1 = InetAddress.getByAddress(ip);
         InetAddress address2 = InetAddress.getByAddress("Oracle :", ip);

         System.out.println(address1);
         System.out.println(address2);
     }
}
