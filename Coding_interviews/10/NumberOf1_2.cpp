/*=========================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : NumberOf1_2.cpp
* Version      : v1.0.0
* Author       : 初代
* Date         : 2016/07/26
* Description  :
* Function list: 1.
*                2.
*                3.
* History      :
\*=========================================================================*/

int NumberOf1_2(int n)
{
     int count = 0;

     while(n)
     {
          n = n & (n-1);        //消去一个1
          count++;
     }

     return count;
}
