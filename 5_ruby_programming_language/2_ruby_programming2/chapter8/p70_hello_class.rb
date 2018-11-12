=begin ========================================================================\
* Copyright(C)2016 Chudai.
* 
* File name    : p70_hello_class.rb
* Version      : v1.0.0
* Author       : i.sshe
* Date         : 2016/01/12
* Description  : 
* Function list: 1.
*                2.
*                3.
* History      : 
=end =========================================================================*/

class HelloWorld
  def initialize(myname="Ruby")
    @name = myname 
  end 

  def hello 
    print "Hello, world. I am ", @name, ".\n"
  end 
end 

bob = HelloWorld.new("Bob")
isshe = HelloWorld.new("isshe")
chudai = HelloWorld.new("chudai")

bob.hello 
isshe.hello 
chudai.hello 
