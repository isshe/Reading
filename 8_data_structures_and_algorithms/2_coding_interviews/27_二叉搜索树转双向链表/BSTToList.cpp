/*=========================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : BSTToList.cpp
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
    TreeNode *LastNode;
    
    TreeNode* Convert(TreeNode* pRootOfTree)
    {
        if (pRootOfTree == NULL)
            return NULL;
        
        LastNode = NULL;
        if (pRootOfTree)
        	ConvertList(pRootOfTree);
        
        TreeNode *pNode = pRootOfTree;
        while(pNode->left)
        {
            pNode = pNode->left;
        }
        
        return pNode;
    }
    
    //需要按照中序遍历的顺序来链接节点，不然容易碰到已建好的链接被后面操作破坏的轻快
    void ConvertList(TreeNode *root)
    {
        if (root == NULL)
            return;
        
        TreeNode *currentNode = root;
        
        //中序遍历，先从左子树开始，先遍历最小的
        if (currentNode->left)
        {
            ConvertList(currentNode->left);
        }
        
        currentNode->left = LastNode;
        if (LastNode)
        {
            LastNode->right = currentNode;
        }
        
        LastNode = currentNode;
        
        if (currentNode->right)
        {
            ConvertList(currentNode->right);
        }
        
    }
};
