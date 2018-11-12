/*=========================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : jumpFloor_1.cpp
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
    int jumpFloor(int number) {
       int i = 0;
        long res = 0;
        int j = 0;
        long fenzi = 0;
        long fenmu = 0;
        int yi = 0;
        int er = 0;

        	yi = number -2;
            er++;
            
			for (; yi > 0; yi-=2, er++)
            {
                fenzi = 1;
                fenmu = 1;
            	for (i=er, j=1; i > 0; i--, j++)
                {
                	fenzi *= (yi + j);
                    fenmu *= i;
                }
                res += fenzi/fenmu;
            }
        if (number % 2 == 0)
            res += 2;
        else 
            res += 1;
        
    	return res;

    }
    
};

