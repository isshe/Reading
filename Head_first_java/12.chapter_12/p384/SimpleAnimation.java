/*==============================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : SimpleAnimation.java
* Version      : v1.0.0
* Author       : 初代
* Date         : 2016/01/06
* Description  :
* Function list: 1.
*                2.
*                3.
* History      :
\*==============================================================================*/

import javax.swing.*;
import java.awt.*;

public class SimpleAnimation {
    int x = 70;
    int y = 70;

    public static void main (String[] args) {
        SimpleAnimation gui = new SimpleAnimation();
        gui.go();
    }

    public void go() {
         JFrame frame = new JFrame();
         frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

         MyDrawPanel drawPanel = new MyDrawPanel();

         frame.getContentPane().add(drawPanel);
         frame.setSize(300, 300);
         frame.setVisible(true);

         for (int i = 0; i < 130; i++) {
              x++;
              y++;

              drawPanel.repaint();      //重新绘制面板, 继承了JPanel的

              try {
                  Thread.sleep(100);
              }catch(Exception ex) {  }
         }
    }
    
    class MyDrawPanel extends JPanel {

        public void paintComponent(Graphics g) {
        
             g.setColor(Color.white);
             g.fillRect(0, 0, this.getWidth(), this.getHeight());
             
             
             int red = (int) (Math.random() * 255);
             int green = (int) (Math.random() * 255);
             int blue = (int) (Math.random() * 255);

             Color randomColor = new Color(red, green, blue);
             g.setColor(randomColor);
             g.fillOval(x, y, 40, 40);
        }
    }
    
}


