/*=========================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : NumberOf1_1.cpp
* Version      : v1.0.0
* Author       : 初代
* Date         : 2016/07/26
* Description  :
* Function list: 1.
*                2.
*                3.
* History      :
\*=========================================================================*/

int NumberOf1_1(int n)
{
     unsigned int flag = 1;
     int count = 0;

     while (flag)
     {
          if (flag & n)
          {
              count++;
          }

          flag = flag << 1;         //左移一位以测试n的下一位是否为1.
     }

     return count;
}
