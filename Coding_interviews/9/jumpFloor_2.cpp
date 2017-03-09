/*=========================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : jumpFloor_2.cpp
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
        int jump1 = 1;
        int jump2 = 2;
        int jumpn = 0;
        
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
        
        for (i = 2; i < number; i++)
        {
            jumpn = jump1 + jump2;
            jump1 = jump2;
            jump2 = jumpn;
        }
        
        return jumpn;

    }
    
};

