=begin ========================================================================\
* Copyright(C)2016 Chudai.
* 
* File name    : p4_fib2.rb
* Version      : v1.0.0
* Author       : i.sshe
* Date         : 2016/01/08
* Description  : 
* Function list: 1.
*                2.
*                3.
* History      : 
=end =========================================================================*/

def fib(n)
  if n<2
    n
  else 
    fib(n-2) + fib(n-1)
  end 
end 

print "fib(6) = ", fib(6) , "\n"
