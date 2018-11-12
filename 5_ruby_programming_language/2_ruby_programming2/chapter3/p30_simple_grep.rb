=begin ========================================================================\
* Copyright(C)2016 Chudai.
* 
* File name    : p30_simple_grep.rb
* Version      : v1.0.0
* Author       : i.sshe
* Date         : 2016/01/09
* Description  : 
* Function list: 1.
*                2.
*                3.
* History      : 
=end =========================================================================*/

pattern = Regexp.new(ARGV[0])     #不懂
filename = ARGV[1]

file = open(filename)
while text = file.gets do 
  if pattern =~ text        ##不懂
    print text 
  end 
end 
file.close
