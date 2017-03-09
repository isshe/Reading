=begin ========================================================================\
* Copyright(C)2016 Chudai.
* 
* File name    : p59_break_next.redo.rb
* Version      : v1.0.0
* Author       : i.sshe
* Date         : 2016/01/10
* Description  : 
* Function list: 1.
*                2.
*                3.
* History      : 
=end =========================================================================*/

print "break shili:\n"
i = 0
["Perl", "Python", "Ruby", "Scheme"].each {
  |lang|
  i += 1
  if i == 3
    break
  end 
  p [ i, lang ]
}

print "\nnext shili: \n"
i = 0
["Perl", "Python", "Ruby", "Scheme"].each {
  |lang|

  i += 1
  if i == 3
    next 
  end 
  p [ i, lang ]
}

print "\nredo shili: \n"
i = 0
["Perl", "Python", "Ruby", "Scheme"].each {
  |lang|

  i += 1
  if i == 3
    redo
  end 
  p [ i, lang ]
}
