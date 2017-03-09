/*=========================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : Solution.cpp
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
    stack<int> minstack;
    stack<int> datastack;
    
    void push(int value) {
        datastack.push(value);
        if (minstack.size() <= 0 || value <= minstack.top())
        {
            minstack.push(value);
        }
        else
        {
            minstack.push(minstack.top());
        }
    }
    void pop() {
        datastack.pop();
        minstack.pop();
    }
    int top() {
        return datastack.top();
    }
    int min() {
        return minstack.top();
    }
};
