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
    ListNode* ReverseList(ListNode* pHead) {
        
        if (pHead == NULL || pHead->next == NULL) //0个或一个节点
            {
            return pHead;
        }
        
        ListNode *a = pHead; 			
        ListNode *cu = pHead->next; 	 					//两个以上节点
        ListNode *b = pHead->next->next;
        a->next = NULL; 									//这步很关键！
        do{
            cu->next = a;
            a = cu;
            cu = b;
            if (b != NULL)
            {
                b = b->next;
            }
           
        }while(cu != NULL);
        
        pHead = a;
        
        return pHead;

    }
};

