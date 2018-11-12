/*
struct ListNode {
	int val;
	struct ListNode *next;
	ListNode(int x) :
			val(x), next(NULL) {
	}
};*/
class Solution {
public:
    ListNode* Merge(ListNode* pHead1, ListNode* pHead2)
    {
        if (pHead1 == NULL)
        {
            return pHead2;
        }
        else if (pHead2 == NULL)
        {
            return pHead1;
        }
        
        ListNode *pNode1 = pHead1;
        ListNode *pNode2 = pHead2;
        ListNode *newHead = NULL;
        ListNode *newList = NULL;
        
        //确定头节点，这部分感觉不好。
        if (pNode1->val <= pNode2->val)
        {
            newHead = pNode1;
            newList = pNode1;
            pNode1 = pNode1->next;
        }
        else
        {
            newHead = pNode2;
            newList = pNode2;
            pNode2 = pNode2->next;
        }
        
        while(pNode1 != NULL || pNode2 != NULL)
        {
            if(pNode1 != NULL && pNode2 != NULL)
            {
                if (pNode1->val <= pNode2->val)
                {
                    newList->next = pNode1;
                    newList = newList->next;
                    pNode1 = pNode1->next;
                }
                else
                {
                    newList->next = pNode2;
                    newList = newList->next;
                    pNode2 = pNode2->next;
                }
            }
            else if (pNode1 != NULL && pNode2 == NULL)
            {
                newList->next = pNode1;
                break;
            }
            else
            {
                newList->next = pNode2;
                break;
            }
        }
        
        return newHead;
    }
};
