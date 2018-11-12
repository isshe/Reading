/*=========================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : printListFromTailToHead_1.cpp
* Version      : v1.0.0
* Author       : 初代
* Date         : 2016/07/25
* Description  :
* Function list: 1.
*                2.
*                3.
* History      :
\*=========================================================================*/

/**
*  struct ListNode {
*        int val;
*        struct ListNode *next;
*        ListNode(int x) :
*              val(x), next(NULL) {
*        }
*  };
*/
class Solution {
public:
    
        ListNode* ReverseList(ListNode* pHead) 
        {
        	ListNode *a = NULL;
        	ListNode *cu = NULL;
        	ListNode *b = NULL;
        
        	if (pHead == NULL) //0个
            	{
            	return pHead;
        	}
        
        	a = pHead; 			//1个
        	if (a->next == NULL)
            {
            	return pHead;
        	}
        
        	cu = pHead->next; 	//2个
        	if (cu->next == NULL)
            {
            	cu->next = pHead;
            	pHead->next = NULL;
            	pHead = cu;
            
            	return pHead;
        	}
        
        //3个及以上
        	b = pHead->next->next;
        	while (b->next != NULL)
            {
            	cu->next = a;
            
            	a = cu;
            	cu = b;
            	b = b->next;
        	}
        	cu->next = a;
        	b->next = cu;
        	pHead->next = NULL;
        
        	pHead = b;
        
        	return pHead;
    	}
    vector<int> printListFromTailToHead(struct ListNode* head) {
        ListNode *re_head = ReverseList(head); 		//把习题翻转链表的代码直接拿过来了.
        ListNode *current = re_head;
        vector<int> my_vec;
        
        while (current != NULL)
            {
            my_vec.push_back(current->val);
            current = current->next;
        }
        
        return my_vec;
        
    }
};
