=begin ========================================================================\
* Copyright(C)2016 Chudai.
* 
* File name    : p61_ten_lines_grep.rb
* Version      : v1.0.0
* Author       : i.sshe
* Date         : 2016/01/10
* Description  : 
* Function list: 1.
*                2.
*                3.
* History      : 
=end =========================================================================*/

pattern = Regexp.new(ARGV[0])
filename = ARGV[1]
max_matches = 10
matches = 0

file = open(filename)
while text = file.gets
  if matches >= max_matches
    break 
  end 
  if pattern =~ text          # ===
    matches += 1
    print text 
  end 
end 
