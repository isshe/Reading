using namespace std;
/*
struct TreeLinkNode {
    int val;
    struct TreeLinkNode *left;
    struct TreeLinkNode *right;
    struct TreeLinkNode *next;
    TreeLinkNode(int x) :val(x), left(NULL), right(NULL), next(NULL) {
        
    }
};
*/
class Solution {
public:
    TreeLinkNode* GetNext(TreeLinkNode* pNode)
    {
        if (pNode == NULL)
            return NULL;
        
        TreeLinkNode *currentNode = NULL;
        TreeLinkNode *resultNode = NULL;
        TreeLinkNode *parentNode = NULL;
        //第一情况：
        //1. 该节点没有右节点，并且是它父节点的左节点，则返回它的父节点。        
        //第二种情况：
        //1. 该节点是它父节点的右节点 && 该节点没有右节点
        //第三种情况：
        //1. 该节点有右节点，则返回右节点或右子树的最左节点。
        //第二第三种情况可以合在一起写代码。
        
        currentNode = pNode;
        if (currentNode->right != NULL) 			//第一种情况
        {
            currentNode = currentNode->right;
            while(currentNode->left != NULL)
            {
                currentNode = currentNode->left;
            }
            
            resultNode = currentNode;
        }
        else if (currentNode->next != NULL)
        {
            parentNode = currentNode->next;
//            if (parentNode != NULL && currentNode == parentNode->left) 		//第二种情况
 //           {
//                resultNode = parentNode;
//            }
//            else if (parentNode != NULL && currentNode == parentNode->right) //第三种情况
//            {
                while(parentNode != NULL && currentNode == parentNode->right)
                {
                    currentNode = currentNode->next;
                    parentNode = parentNode->next;
                }
            
            //如果parentNode == NULL,也可以赋值当结果。
            resultNode = parentNode;
//            }
        }
        
        return resultNode;
 
    }
}
