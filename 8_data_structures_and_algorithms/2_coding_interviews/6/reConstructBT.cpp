/*=========================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : reConstructBT.cpp
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
 * Definition for binary tree
 * struct TreeNode {
 *     int val;
 *     TreeNode *left;
 *     TreeNode *right;
 *     TreeNode(int x) : val(x), left(NULL), right(NULL) {}
 * };
 */
class Solution {
public:
    struct TreeNode* reConstructBinaryTree(vector<int> pre,vector<int> in) {
        int pre_len = pre.size();
        int in_len = in.size();
        struct TreeNode *new_node ;
        
        if (in_len != pre_len || pre_len == 0)
        {
            return NULL;
        }
        
        new_node = reConstruct(pre, 0, pre_len-1, in, 0, in_len - 1);
        
        return new_node;

    }
    
    struct TreeNode *reConstruct(vector<int> pre, int pre_start, int pre_end, vector<int> in, int in_start, int in_end)
    {
        if (pre_start > pre_end)
        {
            return NULL;
        }
        
        int 	j = 0;
        
        struct TreeNode *new_node = new TreeNode(pre[pre_start]);
        int 	root = pre[pre_start];
        
        new_node->val = pre[pre_start];
        
        if (pre_start == pre_end)
        {
            new_node->left = NULL;
            new_node->right = NULL;
            
            return new_node;
        }

        
        j = 0;
        while(in[in_start + j] != root && in_start + j < in_end)
        {
            j++;
        }
               
        //在中序序列中找到了当前根节点
        new_node->left = reConstruct(pre, pre_start+1, pre_start+j, in, in_start, in_start+j-1);
        new_node->right = reConstruct(pre, pre_start+j+1, pre_end, in, in_start+j+1, in_end);

        return new_node;
    }
};





