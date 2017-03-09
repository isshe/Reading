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

//思路：
//序列化 
//1. 先序遍历二叉树，保存树节点的值到 tempSerialize
//2. 复制tempSerialize到 res ， 注意一个是int类型，一个是char类型

//反序列化 （就是构建二叉树）
//1. 根据 str 数组的数据【先序遍历的结果】，类似先序遍历地创建 并构建二叉树。
class Solution {
public:
    vector<int> tempSerialize;
    char* Serialize(TreeNode *root) {
        if (root == NULL)
        {
            return NULL;
        }
        
        //先序遍历
        serializeRecur(root);
        
        //复制
        char *res = new char[tempSerialize.size()];
        for (int i = 0; i < tempSerialize.size(); i++)
        {
            res[i] = tempSerialize[i];
        }
        
        return res;
    }
    
    void serializeRecur(TreeNode *root)
    {
        if (root == NULL)
        {
            tempSerialize.push_back('$');
            return;
        }
        
        tempSerialize.push_back(root->val);
        serializeRecur(root->left);
        serializeRecur(root->right);
    }
        
    
    TreeNode* Deserialize(char *str) {
        if (str == NULL)
            return NULL;

        int i = 0;
    	TreeNode *pNode = DeserializeRecur(str, i);

        return pNode;
    }
    

    TreeNode* DeserializeRecur(char *str, int &i) {
        if (str == NULL || str[i] == '\0')
            return NULL;
        
        TreeNode *pNode = NULL;
        int num = str[i];
        
        if (str[i] != '$')
        {
            if (num <= 0) 						//这里之所以这样是因为char类型容不下>127的数，
            	num += 256;						//这个方法并不好，移植性不好
    		pNode = new TreeNode(num); 			
            i++;
            pNode->left = DeserializeRecur(str, i);
            i++;
            pNode->right = DeserializeRecur(str, i);
        }
        return pNode;
    }
}
