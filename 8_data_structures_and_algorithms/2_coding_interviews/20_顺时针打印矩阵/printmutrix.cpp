/*=========================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : printmutrix.cpp
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
class Solution {
public:

    vector<int> printMatrix(vector<vector<int> > matrix) {
        int row = matrix.size();
        int col = matrix[0].size();
        vector<int> res;

        
        int start = 0;
        int tempcol = col; 		
        int temprow = row;
        
        while(col > start * 2 && row > start * 2)
        {
//            PrintCircle(matrix, temprow, tempcol, start, res); 因为res传参改变数据无效，大概需要传引用或指针
              int i = 0;
        	  int j = 0;
        
        	  for(i = start, j = start; j < tempcol; j++)
        	  {
            	  res.push_back(matrix[i][j]);
        	  }
        
        	  for (i = start+1, j = tempcol-1; i < temprow; i++)
        	  {
            	  res.push_back(matrix[i][j]);
        	  }
        
        	  for (i = temprow-1, j = tempcol-2; j >= start; j--)
        	  {
            	  if (start < temprow -1)
            		  res.push_back(matrix[i][j]);
        	  }
        
        	  for (i = temprow-2, j = start; i >= start+1; i--)
       		  {
            	  if (start < tempcol - 1)
            	  {
            		  res.push_back(matrix[i][j]); 
            	  }
        	  }
            	  tempcol--;
            	  temprow--;
            	  start++;
        }
        
        return res;
        
    }
};
