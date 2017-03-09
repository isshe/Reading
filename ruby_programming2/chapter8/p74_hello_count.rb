=begin ========================================================================\
* Copyright(C)2016 Chudai.
* 
* File name    : p74_hello_count.rb
* Version      : v1.0.0
* Author       : i.sshe
* Date         : 2016/01/12
* Description  : 
* Function list: 1.
*                2.
*                3.
* History      : 
=end =========================================================================*/

class HelloCount 
  @@count = 0

  def HelloCount.count      #用来读取调用次数的类方法
    @@count 
  end 

  def initialize(myname="Ruby")
    @name = myname 
  end 

  def hello 
    @@count += 1
    print "Hello world. I am ", @name, ".\n"
  end 
end 

bob = HelloCount.new("bob")
isshe = HelloCount.new("isshe")
ruby = HelloCount.new 

p HelloCount.count 
bob.hello 
isshe.hello 
ruby.hello 
p HelloCount.count 
