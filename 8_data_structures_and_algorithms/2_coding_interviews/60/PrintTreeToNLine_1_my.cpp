/*=========================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : PrintTreeToNLine_1_my.cpp
* Version      : v1.0.0
* Author       : 初代
* Date         : 2016/07/30
* Description  :
* Function list: 1.
*                2.
*                3.
* History      :
\*=========================================================================*/

/*
struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
    TreeNode(int x) :
            val(x), left(NULL), right(NULL) {
    }
};
*/
class Solution {
public:
        vector<vector<int> > Print(TreeNode* pRoot) {
        	//和层次遍历有些不同
            
            int layer = 0;
            queue<int> aidQueue;
            int hight = 0;
            int maxHight = 0;
            
            recursive(pRoot, aidQueue, layer, hight, maxHight);
            vector<vector<int>> res(maxHight);
            if (pRoot == NULL)
                return res;
            
            int i = 0;
            int len = aidQueue.size();
            int val = 0;
            while(i < len)
            {
                layer = aidQueue.front();
                aidQueue.pop();
                val = aidQueue.front();
                aidQueue.pop();
                
                res[layer].push_back(val);
                i += 2;
            }
            
            return res;
        }
    
    void recursive(TreeNode *pRoot, queue<int> &aidQueue, int layer, int hight, int &maxHight)
    {
        if (pRoot == NULL)
            return;
        
        aidQueue.push(layer);
        aidQueue.push(pRoot->val);
        layer++;
        hight++;
        
        if (maxHight < hight)
            maxHight = hight;
        
        recursive(pRoot->left, aidQueue, layer, hight, maxHight);
        recursive(pRoot->right, aidQueue, layer, hight, maxHight);
    }
};
