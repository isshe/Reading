/*=========================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : jumpFloor_3.cpp
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
    int jumpFloorII(int number) {
        
        int i = 0;
        int jump1 = 1;
        int jump2 = 2;
        int jumpn = 0;
        int res = 0;
        
        if (number == 0)
            {
            return 0;
        }
        else if (number == 1)
            {
            return 1;
        }
        else if (number == 2)
        {
            return 2;
        }
        
        for (i = number - 1; i > 0; i--)
        {
            res += jumpFloorII(i);
        }
        
        jumpn = res + 1;
        return jumpn;
    }
};

