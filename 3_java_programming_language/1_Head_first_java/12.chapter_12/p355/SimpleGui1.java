/*==============================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : SimpleGui1.java
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

public class SimpleGui1 {
    public static void main (String[] args) {

        //创建frame和button
        JFrame frame = new JFrame();
        JButton button = new JButton("click me");

        //这行程序会在window关闭的时候不程序结束掉
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        //把button加到frame的pane上
        frame.getContentPane().add(button);

        //设定frame的大小， 并把frame显示出来。
        frame.setSize(300, 300);
        frame.setVisible(true);
    }
}
