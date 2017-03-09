=begin ========================================================================\
* Copyright(C)2016 Chudai.
* 
* File name    : p48_case.rb
* Version      : v1.0.0
* Author       : i.sshe
* Date         : 2016/01/10
* Description  : 
* Function list: 1.
*                2.
*                3.
* History      : 
=end =========================================================================*/

tag = ["A", "IMG", "PRE"]
tag.each{|tagname|
  case tagname
  when "p", "A", "I", "B", "BLOCKQUOTE"
    print tagname, " has child.\n"
  when "IMG", "BR"
    print tagname, " hsa no child.\n"
  else 
    print tagname, " cannot be used.\n"
  end
}
