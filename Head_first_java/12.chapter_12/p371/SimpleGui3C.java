/*==============================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : SimpleGui3C.java
* Version      : v1.0.0
* Author       : 初代
* Date         : 2016/01/06
* Description  : 按下按钮圆圈就会改变颜色
* Function list: 1.
*                2.
*                3.
* History      :
\*==============================================================================*/

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class SimpleGui3C implements ActionListener {
    JFrame frame;

    public static void main (String[] args) {
        SimpleGui3C gui = new SimpleGui3C();
        gui.go();
    }

    public void go() {
         frame = new JFrame();
         frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

         JButton button = new JButton("Change colors");
         button.addActionListener(this);        //和actionPerformed关联

         MyDrawPanel drawPanel = new MyDrawPanel();

         frame.getContentPane().add(BorderLayout.SOUTH, button);
         frame.getContentPane().add(BorderLayout.CENTER, drawPanel);
         frame.setSize(300, 300);
         frame.setVisible(true);
    }

    public void actionPerformed(ActionEvent event) {
         frame.repaint();       //调用下面的paintComponet().
    }
    
}
/*    
    class MyDrawPanel extends JPanel {
        public void paintComponet(Graphics g) {
            Graphics2D g2d = (Graphics2D) g;

            GradientPaint gradient =
                new GradientPaint(70, 70, Color.blue, 150, 150, Color.orange);

            g2d.setPaint(gradient);
            g2d.fillOval(70, 70, 100, 100);
        }
    }
*/  
/*
 
    class MyDrawPanel extends JPanel {
        public void paintComonent(Graphics g) {
            Graphics2D g2d = (Graphics2D) g;
            
         g2d.fillRect(0,0,this.getWidth(), this.getHeight());
            
            int red = (int) (Math.random() * 255);
            int green = (int) (Math.random() * 255);
            int blue = (int) (Math.random() * 255);
            Color startColor = new Color(red, green, blue);

            red = (int) (Math.random() * 255);
            green = (int) (Math.random() * 255);
            blue = (int) (Math.random() * 255);
            Color endColor = new Color(red, green, blue);


            GradientPaint gradient =
                new GradientPaint(70, 70, startColor, 150, 150, endColor);
            g2d.setPaint(gradient);
            g2d.fillOval(70,70,100,100);

        }
    }
*/

class MyDrawPanel extends JPanel {
    
      public void paintComponent(Graphics g) {
         
         g.fillRect(0,0,this.getWidth(), this.getHeight());

         // make random colors to fill with
         int red = (int) (Math.random() * 255);
         int green = (int) (Math.random() * 255);
         int blue = (int) (Math.random() * 255);

         Color randomColor = new Color(red, green, blue);
         g.setColor(randomColor);

//         g.setColor(Color.orange);
         g.fillOval(70,70,100,100);
      }

}


