=begin ========================================================================\
* Copyright(C)2016 Chudai.
* 
* File name    : p48_case_class.rb
* Version      : v1.0.0
* Author       : i.sshe
* Date         : 2016/01/10
* Description  : 
* Function list: 1.
*                2.
*                3.
* History      : 
=end =========================================================================*/

array = [ "aa", 1, nil ]
3.times {
  |i|
item = array[i]
  case item
  when String
    puts "item is a String."
  when Numeric 
    puts "item is a Numeric."
  else 
    puts "item is a someting."
  end 
}
