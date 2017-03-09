/*==============================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : MyInetAddrss1.java
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

public class MyInetAddress1
{
     public static void main(String[] args) throws Exception
     {
         try
         {
              InetAddress localAddress = InetAddress.getLocalHost();
              System.out.println(localAddress);
         }
         catch(UnknownHostException el)
         {
              el.printStackTrace();
         }
     }
}
