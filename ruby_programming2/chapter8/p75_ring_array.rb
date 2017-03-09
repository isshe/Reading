=begin ========================================================================\
* Copyright(C)2016 Chudai.
* 
* File name    : p75_ring_array.rb
* Version      : v1.0.0
* Author       : i.sshe
* Date         : 2016/01/12
* Description  : 
* Function list: 1.
*                2.
*                3.
* History      : 
=end =========================================================================*/

class RingArray < Array     #指定父类
  def [](i)                 #重新定义运算符
    idx = i % size 
    super(idx)
  end 
end 

eto = RingArray[ "yi", "二", "三", "四", "五" ]

p eto[6]
p eto[1]
p eto[10]
p eto[-1]
