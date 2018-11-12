/*=========================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : VerifySquenceBST.cpp
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
    
    bool TestSequence(vector<int> sequence, int start, int end)
    {
        bool res1 = false;
        bool res2 = false;
        
        if (end - start < 0)
        {
            return false;
        }
        
        //把左子树分出来
        int i = start;
        while(sequence[i] < sequence[end] && i < end)
        {
            i++;
        }
        
        int mid = i; 		//保存中间位置，为递归准备
        
        //如果右子树有小于根节点的，则返回false
        while(i < end) 										//这里注意i++
        {
            if (sequence[i] < sequence[end])
            {
                return false;
            }
            i++;
        }
        res1 = true; 				//这里要注意,为了应对没有左子树或没有右子树和只剩一个节点的情况
        if (mid-1-start > 0)
        	res1 = TestSequence(sequence, start, mid - 1);
        res2 = true;
        if (end-1-mid > 0)
            res2 = TestSequence(sequence, mid, end-1);
        
        return res1 && res2;
        
    }

    bool VerifySquenceOfBST(vector<int> sequence) {
        if (sequence.size() <= 0)
        {
            return false;
        }

        return TestSequence(sequence, 0, sequence.size() - 1);

    }
};
