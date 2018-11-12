=begin ========================================================================\
* Copyright(C)2016 Chudai.
* 
* File name    : p75_ext_string.rb
* Version      : v1.0.0
* Author       : i.sshe
* Date         : 2016/01/12
* Description  : 
* Function list: 1.
*                2.
*                3.
* History      : 
=end =========================================================================*/

class String 
  def count_word 
    ary = self.split(/\s+/)
    return ary.size 
  end 
end 

str = "Just isshe chudai"
p str.count_word 
