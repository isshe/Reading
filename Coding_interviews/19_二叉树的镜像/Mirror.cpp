/*=========================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : Mirror.cpp
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
    void Mirror(TreeNode *pRoot) {
        if (pRoot == NULL)
        {
            return ;
        }
        if (pRoot->left == NULL && pRoot->right == NULL)
        {
            return ;
        }
        TreeNode *tempnode = pRoot->left;
        pRoot->left = pRoot->right;
        pRoot->right = tempnode;
        
        if (pRoot->left != NULL)
        {
            Mirror(pRoot->left);
        }
        
        if (pRoot->right != NULL)
        {
            Mirror(pRoot->right);
        }
    }
};
