/*==============================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : MusicTest1.java
* Version      : v1.0.0
* Author       : i.sshe
* Date         : 2016/01/09
* Description  :
* Function list: 1.
*                2.
*                3.
* History      :
\*==============================================================================*/

import javax.sound.midi.*;

public class MusicTest1 {
    public void play() {

        try {
            Sequencer selected = MidiSystem.getSequencer();
            System.out.println("Successfully got a sequencer");
        } catch (MidiUnavailableException ex) {
            System.out.println("Bummer");
        }
    }

    public static void main(String[] args)
    {
         MusicTest1 mt = new MusicTest1();
         mt.play();
    }
}
