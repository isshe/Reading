/*=========================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : Permutation.cpp
* Version      : v1.0.0
* Author       : 初代
* Date         : 2016/08/04
* Description  :
* Function list: 1.
*                2.
*                3.
* History      :
\*=========================================================================*/

/*-----------------------------------------------------------*
 * 头文件                                                    *
 *-----------------------------------------------------------*/

class Solution {
public:
    vector<string> 	res;
    
    vector<string> Permutation(string str) {

        if (str.size() == 0)
        {
            return res;
        }
        
        coreFunc(str, 0);
        sort(res.begin(),res.end());       //需要这个，顺序不对通不过。
        return res;
    }
    
    void coreFunc(string str, int begin)
    {
        int len = str.size();
        if (begin == len - 1)
        {
            res.push_back(str);
        }
        else
        {
            for(int i = begin; i < len; i++)
            {
                //处理重复元素的情况
                if (str[i] == str[begin] && i != begin)
                    continue;
                //交换
//                char temp = str[i];
//                str[i] = str[begin];
//                str[begin] = temp;
            	swap(str[i],str[begin]);                
                coreFunc(str, begin+1);
            	swap(str[i],str[begin]);	                
 
            }
        }
    }
};
