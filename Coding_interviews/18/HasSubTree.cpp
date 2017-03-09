/*
struct TreeNode {
	int val;
	struct TreeNode *left;
	struct TreeNode *right;
	TreeNode(int x) :
			val(x), left(NULL), right(NULL) {
	}
};*/
class Solution {
public:
    bool Tree1HaveTree2(TreeNode *pRoot1, TreeNode *pRoot2)
    {
        bool res = false;
        
        if(pRoot2 == NULL)
        {
            return true;
        }
        
        if (pRoot1 == NULL)
        {
            return false;
        }
        
        if (pRoot1->val != pRoot2->val)
        {
            return false;
        }
        
        res = Tree1HaveTree2(pRoot1->left, pRoot2->left) 
            && Tree1HaveTree2(pRoot1->right, pRoot2->right);
        return res;
    }
    
    bool HasSubtree(TreeNode* pRoot1, TreeNode* pRoot2)
    {
        if (pRoot2 == NULL || pRoot1 == NULL)
        {
            return false;
        }
        
        //第一步：找pRoot1中节点值和pRoot2中根节点值相同的节点
        //第二部：判断是否是子结构
        bool res = false;
        if (pRoot1->val == pRoot2->val)
        {
            res = Tree1HaveTree2(pRoot1, pRoot2);
        }
        
        if (!res)
        {
            res = HasSubtree(pRoot1->left, pRoot2);
        }
        
        if (!res)
        {
            res = HasSubtree(pRoot1->right, pRoot2);
        }
        
        return res;
    }
};
