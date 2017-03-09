/*==============================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : InetAddress.java
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

public class MYIPVersion
{
     public static void main(String[] args)
     {
         try
         {
              InetAddress inetadd = InetAddress.getLocalHost();
              byte[] address = inetadd.getAddress();
              System.out.println("inetadd = " + inetadd);
              System.out.println("address = " + address);
 //             System.out.println(inetadd.getAddress());

              if ( address.length == 4 )
              {
                  System.out.println("The Ip version is IPv4");

                  int firstbyte = address[0];
                  System.out.println("firstbyte = " + firstbyte);

                  if (firstbyte < 0)
                  {
                       firstbyte += 256;
                  }

                  if ((firstbyte & 0x80) == 0)
                  {
                       System.out.println("The IP class is A");
                  }
                  else if ((firstbyte & 0xC0) == 0x80)
                  {
                       System.out.println("The IP class is B");
                  }
                  else if ((firstbyte & 0xE0) == 0xC0)
                  {
                       System.out.println("The IP class is C");
                  }
                  else if ((firstbyte & 0xF0) == 0xE0)
                  {
                       System.out.println("The IP class is D");
                  }
                  else if ((firstbyte & 0xF8) == 0xF0)
                  {
                       System.out.println("The IP class is E");
                  }
              }
              else if (address.length == 16)
              {
                   System.out.println("The IP version is IPv6");
              }
         }
         catch (Exception e)
         {};
     }
}
