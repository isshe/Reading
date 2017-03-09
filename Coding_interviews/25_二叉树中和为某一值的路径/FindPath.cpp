/*=========================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : FindPath.cpp
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
    vector<vector<int>> res;
    vector<int> path;
    int currentSum ;
    
    void preFind(TreeNode *root, int sum)
    {
        if (root == NULL)
        {
            return ;
        }
        
        //如果是叶节点
        path.push_back(root->val); 		//先压进去
        currentSum += root->val;
        if (root->left == NULL && root->right == NULL)
        {
            if (currentSum == sum) 		//符合
            {
                //然后复制到结果集中    //这里的复制要特别注意，对C++的特性不熟悉的话，如果用循环复制，容易段错误，
                res.push_back(path);
            }

        }
        
        if (root->left != NULL) 			//左子树还有
        {
            preFind(root->left, sum);
        }
        
        if (root->right != NULL) 			//右子树还有
        {
             preFind(root->right, sum);
        }
        
        path.pop_back();
        currentSum -= root->val;
    }
    
    vector<vector<int> > FindPath(TreeNode* root,int expectNumber) {


        //前序遍历二叉树，当是叶节点的时候，就判断节点的和是否是要求的那个。
        //如果是，则把保存的路径复制到二维数组中
        //如果不是，则去除该叶节点，并在和中减去它的值
        currentSum = 0;
        if (root != NULL)
        {
        	preFind(root, expectNumber);
        }
        return res;
        
    }
};
