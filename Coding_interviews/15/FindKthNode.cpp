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
    ListNode* FindKthToTail(ListNode* pListHead, unsigned int k) {
        
        if (pListHead == NULL || k <= 0)
        {
            return NULL;
        }
        
        ListNode *current = pListHead;
        ListNode *before = pListHead;
        int i = 0;        
        for (i = 0; i < k; i++)
        {
            if (current != NULL)
            	current = current->next;
            else
                return NULL;
        }
        
        while(current != NULL)
        {
            current = current->next;
            before = before->next;
        }
        
        return before;
    
    }
};
