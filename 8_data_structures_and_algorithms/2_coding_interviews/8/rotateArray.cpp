/*=========================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : rotateArray.cpp
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
    int minNumberInRotateArray(vector<int> rotateArray) {
        
        int target = 0;
        
        if (rotateArray.size() <= 0)
        {
            return 0;
        }
        int start = 0;
        int end = rotateArray.size() - 1;
        int mid = 0;
        
        while(start < end)
        {
            if (end - start == 1)
            {
                target = end;
                break;
            }
            mid = (start + end) / 2;
            if (rotateArray[mid] <= rotateArray[end])
            {
                end = mid;
            }
            else if (rotateArray[mid] >= rotateArray[start])
            {
                start = mid;
            }
        }
        return rotateArray[target];
    }
};

