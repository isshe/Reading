/*==============================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : TwoButtons.java
* Version      : v1.0.0
* Author       : 初代
* Date         : 2016/01/05
* Description  :
* Function list: 1.
*                2.
*                3.
* History      :
\*==============================================================================*/

//还存在问题： 圆圈没画出来

import javax.swing.*;
import java.awt.event.*;
import java.awt.*;

//现在不要的GUI累并不实现ActionListener
public class TwoButtons {
    JFrame frame;
    JLabel label;

    public static void main (String[] args) {
        TwoButtons gui = new TwoButtons();
        gui.go();
    }

    public void go() {
         frame = new JFrame();
         frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

         JButton labelButton = new JButton("Change Label");
         labelButton.addActionListener(new LabelListener()); //

         JButton colorButton = new JButton("Change Circle");
         colorButton.addActionListener(new ColorListener());  //

         label = new JLabel("I'm a label");
         MyDrawPanel drawPanel = new MyDrawPanel();     //

         frame.getContentPane().add(BorderLayout.SOUTH, colorButton);
         frame.getContentPane().add(BorderLayout.CENTER, drawPanel);
         frame.getContentPane().add(BorderLayout.EAST, labelButton);
         frame.getContentPane().add(BorderLayout.WEST, label);

         frame.setSize(400, 300);
         frame.setVisible(true);
    }

    class LabelListener implements ActionListener {
        public void actionPerformed(ActionEvent event) {
            label.setText("Ouch!");
        }
    }

    class ColorListener implements ActionListener {
        public void actionPerformed(ActionEvent event) {
             frame.repaint();
        }
    }
}
/*
    class MyDrawPanel extends JPanel {
        public void paintComonent(Graphics g) {
            Graphics2D g2d = (Graphics2D) g;
            
            g2d.fillRect(0, 0, this.getWidth(), this.getHeight());

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
            g2d.fillOval(70, 70, 100, 100);
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
         g.fillOval(70,70,100,100);
      }

}
  


