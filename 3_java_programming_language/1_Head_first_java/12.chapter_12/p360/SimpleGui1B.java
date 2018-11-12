/*==============================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : SimpleGui1B.java
* Version      : v1.0.0
* Author       : 初代
* Date         : 2016/01/05
* Description  :
* Function list: 1.
*                2.
*                3.
* History      :
\*==============================================================================*/

import javax.swing.*;
import java.awt.event.*;

//实现此接口， 这表示SimpleGui1B是个ActionListener
//(时间只会通知有实现actionListener的类
public class SimpleGui1B implements ActionListener {

    JButton button;

    public static void main (String[] args) {
        SimpleGui1B gui = new SimpleGui1B();
        gui.go();
    }

    public void go() {
         JFrame frame = new JFrame();
         button = new JButton("click me");

         //向按钮注册， this可改成类名？！（不知道有没记错）
         //按下按钮的时候， 调用后面的actionPerformed();
         button.addActionListener(this);

         //把按钮加到frame的pane上
         frame.getContentPane().add(button);
         frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
         frame.setSize(300, 300);
         frame.setVisible(true);
    }

    //实现interface上的方法， 这是真正处理事件的方法。
    public void actionPerformed(ActionEvent event) {
         button.setText("I've been clicked!");
    }

}
