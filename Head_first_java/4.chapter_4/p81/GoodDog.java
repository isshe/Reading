/*==============================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : GoodDog.java
* Version      : v1.0.0
* Author       : 初代
* Date         : 2016/01/02
* Description  :
* Function list: 1.
*                2.
*                3.
* History      :
\*==============================================================================*/


class GoodDog {
     private int size;          //注意这里的类型

     public int getSize(){
         return size;
     }

     public void setSize(int s) {
          size = s;
     }

     void bark() {              //没有public之类的关键字修饰
          if (size > 60)
          {
              System.out.println("Wooof!Wooof!");
          }
          else if (size > 14) {
               System.out.println("Ruff! Ruff!");
          }
          else
          {
               System.out.println("Yip! Yip!");
          }
     }
}
