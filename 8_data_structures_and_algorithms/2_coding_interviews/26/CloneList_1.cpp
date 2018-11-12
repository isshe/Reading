/*=========================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : CloneList_1.cpp
* Version      : v1.0.0
* Author       : 初代
* Date         : 2016/07/28
* Description  :
* Function list: 1.
*                2.
*                3.
* History      :
\*=========================================================================*/

/*
struct RandomListNode {
    int label;
    struct RandomListNode *next, *random;
    RandomListNode(int x) :
            label(x), next(NULL), random(NULL) {
    }
};
*/

//这个答案只是实现了思路，并不能运行
class Solution {
public:
    RandomListNode* Clone(RandomListNode* pHead)
    {
        //第一步：先把主干连接起来（就是所有的next）
        //第二部：查找相应的数据，进行random的连接。
        //普通方法的话，时间复杂度是O（n^2),
        //如果用哈希表存random的数据，则时间复杂度是O(n^2), 凡是需要O(n)的辅助空间
        if (pHead == NULL)
        {
            return NULL;
        }

        RandomListNode *CloneHead = LinkMainList(pHead);
        CloneHead = LinkRandomNode(pHead, CloneHead);

        return CloneHead;
    }

    //连接主干节点的函数
    RandomListNode *LinkMainList(RandomListNode * pHead)
    {
        if (pHead == NULL)
            return NULL;
        RandomListNode *copyHead = new RandomListNode(pHead->label);
        RandomListNode *copyNode = copyHead;
        RandomListNode *pNode = pHead->next;

        while(pNode!= NULL)
        {
            RandomListNode *newNode = new RandomListNode(pNode->label);
            copyNode->next = newNode;
            newNode = NULL;
            pNode = pNode->next;
        }

        return copyHead;
    }

    RandomListNode *LinkRandomNode(RandomListNode *pHead, RandomListNode *CloneHead)
    {
        if(pHead == NULL || CloneHead == NULL)
        {
            return NULL;
        }

        RandomListNode *pNode = pHead;
        RandomListNode *CNode = CloneHead;

        while(pNode != NULL)  	//外循环遍历整个链表
        {
            if (pNode->random != NULL)
            {
                int label = pNode->random->label;
                CNode->random = FindNode(CloneHead, label);
            }
            pNode = pNode->next;
            CNode = CNode->next;
        }

        return CloneHead;
    }

    RandomListNode *FindNode(RandomListNode *CloneHead, int label)
    {
        RandomListNode *CNode = CloneHead;

        while(CNode != NULL && CNode->label != label)
        {
            CNode = CNode->next;
        }

        return CNode;
    }
};

