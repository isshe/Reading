/*=========================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : CloneList_2.cpp
* Version      : v1.0.0
* Author       : 初代
* Date         : 2016/07/28
* Description  :
* Function list: 1.
*                2.
*                3.
* History      :
\*=========================================================================*/

//使用的是方法3
/*
struct RandomListNode {
    int label;
    struct RandomListNode *next, *random;
    RandomListNode(int x) :
            label(x), next(NULL), random(NULL) {
    }
};
*/
class Solution {
public:
    RandomListNode* Clone(RandomListNode* pHead)
    {
        if (pHead == NULL)
            return NULL;
         
        RandomListNode* pNode = pHead;
        RandomListNode* CNode ;
        
        //第一步：复制节点， 链接到原节点后面
        while(pNode)
        {
            CNode = new RandomListNode(pNode->label);
            CNode->next = pNode->next;
            CNode->random = NULL;
             
            pNode->next = CNode;
            pNode = CNode->next;
        }
        
        //第二步：复制复杂链接
        pNode = pHead;
        while(pNode)
        {
            if (pNode->random)
            {
                pNode->next->random = pNode->random->next;
            }
            pNode = pNode->next->next;
        }
         
        pNode = pHead;
        CNode = pNode->next;
        RandomListNode* CHead = CNode;
        
        //第三步：分离链表
        while(pNode)
        {
            pNode->next = CNode->next;
            pNode = pNode->next;
             
            if (pNode)
            {
                CNode->next = pNode->next;
                CNode = CNode->next;
            }
            else
            {
                CNode->next = NULL;
            }
        }
         
        return CHead;
    }
};

