/*=========================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : reOrderArray.cpp
* Version      : v1.0.0
* Author       : 初代
* Date         : 2016/07/26
* Description  :
* Function list: 1.
*                2.
*                3.
* History      :
\*=========================================================================*/

//注意，这份代码和Readme.md中的思路有些不同，不过本质一样。
class Solution {
public:
    void reOrderArray(vector<int> &array) {
        int arraylen = array.size();
        int ji_count = 0;   
        int i = 0;
        int j = 0;
        int k = 0;
        
        if (arraylen <= 0)
        {
            return;
        }
        
        for (i = 0; i < arraylen; i++)
        {
            if (array[i] % 2 == 1)
            {
                ji_count++;
            }
        }
        
        int *temparray = new int[arraylen];
        j = 0;
        k = ji_count;
        for (i = 0; i < arraylen; i++)
        {
            if (array[i] % 2 == 1)
            {
                temparray[j] = array[i];
                j++;
            }
            else 
            {
                temparray[k] = array[i];
                k++;
            }
        }
        
        for (i = 0; i < arraylen; i++)
        {
            array[i] = temparray[i];
        }
    }
};

