=begin ========================================================================\
* Copyright(C)2016 Chudai.
* 
* File name    : p61_strip.rb
* Version      : v1.0.0
* Author       : i.sshe
* Date         : 2016/01/10
* Description  : 
* Function list: 1.
*                2.
*                3.
* History      : 
=end =========================================================================*/

file = open(ARGV[0])
while text = file.gets 
  next if /^\s*$/ =~ text 
  next if /^#/ =~ text 
  next if /^=/ =~ text 
  next if /^\*/ =~ text 
  print text 
end 
