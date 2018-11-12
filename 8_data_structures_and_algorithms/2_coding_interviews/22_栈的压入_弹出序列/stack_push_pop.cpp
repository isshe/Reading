/*=========================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : stack_push_pop.cpp
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
    bool IsPopOrder(vector<int> pushV,vector<int> popV) {
        
        if (pushV.size() != popV.size() || pushV.size() <= 0)
        {
            return false;
        }
        
        stack<int> tempstack;
        int j = 0;
        for(int i = 0; i < pushV.size(); i++)
        {
            tempstack.push(pushV[i]);
            while(!tempstack.empty() && tempstack.top() == popV[j] && j < popV.size())  		//
            {
                j++;
                tempstack.pop();
            }
        }

        if (tempstack.empty())
        {
            return true;
        }
        else
        {
            return false;
        }
    }
};
