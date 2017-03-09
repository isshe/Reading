/*==============================================================================\
* Copyright(C)2016 Chudai.
*
* File name    : MiniMusicApp.java
* Version      : v1.0.0
* Author       : i.sshe
* Date         : 2016/01/09
* Description  :
* Function list: 1.
*                2.
*                3.
* History      :
\*==============================================================================*/


// 这个程序没有几个地方是懂的!!!!!!!//

import javax.sound.midi.*;

public class MiniMusicApp {
    public static void main(String[] args)
    {
        MiniMusicApp mini = new MiniMusicApp();
        mini.play();
    }

    public void play() {

        try {

            //取得sequencer,并打开, sequencer是什么?
            Sequencer player = MidiSystem.getSequencer();
             player.open();

             Sequence seq = new Sequence(Sequence.PPQ, 4); //不懂

             Track track = seq.createTrack();       //???有何用?

             ShortMessage a = new ShortMessage();
             a.setMessage(144, 1, 44, 100);
             MidiEvent noteOn = new MidiEvent(a, 1);
             track.add(noteOn);

             ShortMessage b = new ShortMessage();
             b.setMessage(128, 1, 44, 100);
             MidiEvent noteOff = new MidiEvent(b, 16);
             track.add(noteOff);

             player.setSequence(seq); //
             player.start();

        }catch (Exception ex) {
             ex.printStackTrace();          //
        }
    }
}
