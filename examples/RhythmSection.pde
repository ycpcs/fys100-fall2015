import io.github.daveho.funwithsound.*;
import net.beadsproject.beads.core.*;
import net.beadsproject.beads.data.*;

// You may need to change this, depending on which drive letter
// is assigned to your USB flash drive.
final String SOUNDFONT_DIR = "D:/SoundFonts";

// Some good percussion soundfonts
final String TR808 = SOUNDFONT_DIR + "/tr808/Roland_TR-808_batteria_elettronica.sf2";
final String TR909 = SOUNDFONT_DIR + "/tr909/Roland_TR-909_batteria_elettronica.sf2";
final String ARACHNO = SOUNDFONT_DIR + "/arachno/Arachno SoundFont - Version 1.0.sf2";
final String M1 = SOUNDFONT_DIR + "/m1/HS M1 Drums.sf2";
final String VDW = SOUNDFONT_DIR + "/hammersound/Vintage Dreams Waves v2.sf2";
final String MUSYNG = SOUNDFONT_DIR + "/musyng/Musyng Kite.sf2";

class MyFWS extends FunWithSound {
  MyFWS(PApplet parent) {
    super(parent);
  }

  public void saveWaveFile(MyComp c, String fileName) {
    Player player = createPlayer();
    player.setComposition(c.getComposition());
    try {
      player.setStartDelayUs(50000L);
      player.setIdleWaitUs(1000000L);
      player.saveWaveFile(fileName);
    } catch (Exception e) {
      println("Couldn't save wave file: " + e.toString());
    }
  }
}

MyFWS fws = new MyFWS(this);

class MyComp extends Composer {
  void create() {
    tempo(200, 8);  // 200 beats per minute, 8 beats per measure

    // Metronome instrument for keeping time
    Instrument metronome = percussion(TR808);

    // Set up a percussion instruments for building a rhythm pattern
    Instrument drumkit = percussion(TR808);
    
    // Metronome pattern: plays a closed hihat every 2 beats
    Rhythm metr = rr(p(0,101), 2, 4);
    Figure metf = pf(metr, 42, metronome);
    
    Rhythm kickr = r(p(0,127), p(1,127),p(5,127),p(6.5,127));
    Melody kickm = m(an(36), an(36), an(36), an(36));
    Figure kickf = f(kickr, kickm, drumkit);
    
    Rhythm snarer = r(p(2,127), p(3.5,127), p(4.5, 127), p(6,127));
    Melody snarem = m(an(40),an(40),an(40),an(40));
    Figure snaref = f(snarer, snarem, drumkit);
    
    Rhythm hihatr = gr(
      rr(p(0,101), .5, 7),            // 7 sixteenth note strikes starting at 0
      rr(p(3.5,101), .25, 3),         // 3 thirty-second note strikes starting at 3.5
      r(s(4,1.5,101), s(5.5,2,101)),  // 2 open open hihat strikes at 4 and 5.5
      rr(p(7.5,101), .25, 2)          // 2 thirty-second note strikes starting at 7.5
    );
    Melody hihatm = gm(
      rm(an(42), 7),    // 7 closed hihat notes
      rm(an(42), 3),    // 3 closed hihat notes
      rm(an(46), 2),    // 2 open hihat notes
      rm(an(42), 2)     // 2 closed hihat notes
    );
    Figure hihatf = f(hihatr, hihatm, drumkit);
    
    // Add 8 measures of the metronome pattern
    add1(gf(kickf,snaref,hihatf));
    add1(gf(kickf,snaref,hihatf));
    add1(gf(kickf,snaref,hihatf));
    add1(gf(kickf,snaref,hihatf));
 
    // Uncomment this to play live using your drumkit instrument
    //audition(drumkit);
  }
}

MyComp c = new MyComp();

void setup() {
  size(600,200);
  textSize(32);
  fill(0);
  text("Click to start playing", 125, 140); 
  c.create();
}


void draw() {
}

void mouseClicked() {
  fws.play(c);
  //fws.saveWaveFile(c, "/home/dhovemey/kicksnarehihatpattern.wav");
}
