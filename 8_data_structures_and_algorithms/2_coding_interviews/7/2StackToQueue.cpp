/*=========================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : 2StackToQueue.cpp
* Version      : v1.0.0
* Author       : 初代
* Date         : 2016/07/26
* Description  :
* Function list: 1.
*                2.
*                3.
* History      :
\*=========================================================================*/

class Solution
{
public:
    void push(int node) {
        stack1.push(node);
         
    }
 
    int pop() {
        int temp = 0;
         
        if (stack2.size() <= 0)  //如果没有元素则看stack1有没有，有的话则压到stack2中
        {
            while(stack1.size() > 0)
            {
                stack2.push(stack1.top());
                stack1.pop();
            }           
        }
         
        //直接出栈
        temp = stack2.top();
        stack2.pop();
         
        return temp;
         
    }
 
private:
    stack<int> stack1;
    stack<int> stack2;
};

