/*=========================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : Find.cpp
* Version      : v1.0.0
* Author       : 初代
* Date         : 2016/07/25
* Description  :
* Function list: 1.
*                2.
*                3.
* History      :
\*=========================================================================*/

class Solution {
public:
    bool Find(vector<vector<int> > array,int target) {
        int row = array.size();
        int col = array[0].size();
        int i = 0;
        int j = col-1;
        
        if (row > 0 && col > 0)
        {
             while(i < row && j >= 0)
             {
                    if (array[i][j] > target)
                    {
                        j--;
                    }
                    else if (array[i][j] < target)
                    {
                        i++;
                    }
                    else
                    {
                        return true;
                    }
            }
        }
        
        return false;
    }
    
};
