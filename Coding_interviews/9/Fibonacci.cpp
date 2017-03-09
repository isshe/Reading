/*=========================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : Fibonacci.cpp
* Version      : v1.0.0
* Author       : 初代
* Date         : 2016/07/26
* Description  :
* Function list: 1.
*                2.
*                3.
* History      :
\*=========================================================================*/

class Solution {
public:
    int Fibonacci(int n) {
        
        int fiba = 0;
        int fibb = 1;
        int fibn = 0;
        int i = 0;
        
        if (n == 0)
        {
            return fiba;
        }
        else if (n == 1)
        {
            return fibb;
        }
        
        for (i = 2; i <= n; i++)
        {
            fibn = fiba + fibb;
            fiba = fibb;
            fibb = fibn;
        }
        
        return fibn;

    }
};
