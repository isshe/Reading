=begin ========================================================================\
* Copyright(C)2016 Chudai.
* 
* File name    : p29_read_text.rb
* Version      : v1.0.0
* Author       : i.sshe
* Date         : 2016/01/09
* Description  : 
* Function list: 1.
*                2.
*                3.
* History      : 
=end =========================================================================*/

filename = ARGV[0]
file = open(filename)
text = file.read
print text 
file.close
