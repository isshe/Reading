/*=========================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : rectCover.cpp
* Version      : v1.0.0
* Author       : 初代
* Date         : 2016/07/26
* Description  :
* Function list: 1.
*                2.
*                3.
* History      :
\*=========================================================================*/

class Solution {
public:
    int rectCover(int number) {
     	//注意题目是2×n（宽为2， 长为n）
        //故number==1时， 只有2*1， 一种；
        //number == 2时， 只有横的2*2和竖的2*2，两种。
        //number == 3时，即 number == 1情况和number == 2情况的结合。
        
        int fiba = 0;
        int fibb = 0;
        int fibn = 0;
        
        if(number == 1)
        {
            return 1;
        }
        else if (number == 2)
        {
            return 2;
        }
        
      	fiba = 1;
        fibb = 2;
        for (int i = 2; i < number; i++)
        {
            fibn = fiba + fibb;
            fiba = fibb;
            fibb = fibn;
        }
        
        return fibn;

    }
};

