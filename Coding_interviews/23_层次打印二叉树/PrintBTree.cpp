/*=========================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : PrintBTree.cpp
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
    vector<int> PrintFromTopToBottom(TreeNode *root) {
        //利用队列， 先进先出的特点
        queue<TreeNode *> BTNode;
        vector<int> res;
        TreeNode *pNode;
        
        if (root != NULL)
        {
            //根节点入队
            BTNode.push(root); 
            
            do
            {
                pNode = BTNode.front();
                BTNode.pop();
                res.push_back(pNode->val);
                if (pNode->left != NULL)
                {
                    BTNode.push(pNode->left);
                }
                if (pNode->right != NULL)
                {
                    BTNode.push(pNode->right);
                }
            }while(!BTNode.empty());
            
        }
        
        return res;
        
    }
};
