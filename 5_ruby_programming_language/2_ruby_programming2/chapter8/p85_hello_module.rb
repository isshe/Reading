=begin ========================================================================\
* Copyright(C)2016 Chudai.
* 
* File name    : p85_hello_module.rb
* Version      : v1.0.0
* Author       : i.sshe
* Date         : 2016/01/12
* Description  : 
* Function list: 1.
*                2.
*                3.
* History      : 
=end =========================================================================*/

module HelloModule 
  Version = "1.0"
  def hello(name)
    print "Hello, ", name, ".\n"
  end 
  module_function :hello    #将hello以模块函数形式公开
end 

p HelloModule::Version 
HelloModule::hello("Alice")
