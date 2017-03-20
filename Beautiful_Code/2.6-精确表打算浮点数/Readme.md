
# 精确表达浮点数
题意： 用分数精确表示浮点数

##有限小数的表示
N = 0.a1a2a3...an 
=> N = a1a2a3...an / 10^n

## 无线循环小数的表示
N = 0.a1a2a3...an(b1b2b3...bm)
=> N = a1a2a3...an.(b1b2b3...bm) / 10^n
=> N = (a1a2a3...an + 0.(b1b2b3...bm) )/ 10^n 

令 y = 0.(b1b2b3...bm),
有 y = b1b2b3...bm.(b1b2b3...bm) / 10 ^ m
=> y * 10^m = b1b2b3...bm + 0.b1b2b3...bm
=> y * 10^m - y = b1b2b3...bm
=> y = b1b2b3...bm / (10^m - 1)

故 N = (a1a2a3...an + b1b2b3...bm / (10^m - 1)) / 10 ^ n


## 化简
* 方法一：辗转相除法
> k = x/y, b = x % y, x = ky + b;

