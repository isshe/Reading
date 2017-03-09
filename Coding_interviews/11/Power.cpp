//注意情况：
//1. exponent == 0, 任何数的0次方 =1；(0^0也返回1)
//2. exponent < 0, 取次方后的倒数
//3. base 等于 0， 计算是否== 0时，还要考虑到是double/float类型，不能直接用==， 这个要十分注意！！！
//4. base是正是负不用分情况。

//此题还有一种更快的解法，具体见《剑指offer》93页。
class Solution {
public:
    double Power(double base, int exponent) {
        double res = 0.0;
        int tempexp = exponent;
        int i = 0;
        int flag = equal_0(base); 			//用来标志是否为0；1代表为0； 0代表不为0
        
        if (exponent == 0)
        {
            return 1;
        }
        else if (exponent == 1 || flag == 1)
        {
            return base;
        }
        else if (exponent < 0)
        {
            tempexp = - exponent;
        }
        
        
        res = 1.0;
        for (i = 1; i <= tempexp; i++)
        {
            res = res * base;
        }
        
        if (exponent < 0 && flag == 0)
        {
            res = 1.0 / res;
        }
        
        return res;
    }
    
    int equal_0(double base)
    {
        if (base - 0.0 < 0.0000001 && base - 0.0 > -0.0000001)
        {
            return 1;
        }
        else
        {
            return 0;
        }
            
    }
};
