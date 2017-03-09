=begin ========================================================================\
* Copyright(C)2016 Chudai.
* 
* File name    : p76_acc_text.rb
* Version      : v1.0.0
* Author       : i.sshe
* Date         : 2016/01/12
* Description  : 
* Function list: 1.
*                2.
*                3.
* History      : 
=end =========================================================================*/

class AccTest
  def pub 
    puts "pub is a public method"
  end 
  public :pub       #pub方法设置为public
  
  def priv 
    print "priv is a private method"
  end 
  private :priv 
end 

acc = AccTest.new 
acc.pub 
acc.priv


