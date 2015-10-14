import io.github.daveho.funwithsound.*;
import net.beadsproject.beads.core.*;
import net.beadsproject.beads.data.*;

// You may need to change this, depending on which drive letter
// is assigned to your USB flash drive.
final String SOUNDFONT_DIR = "D:/SoundFonts";

// As above
final String SAMPLE_DIR = "D:/Samples";

// Some good percussion soundfonts
final String TR808 = SOUNDFONT_DIR + "/tr808/Roland_TR-808_batteria_elettronica.sf2";
final String TR909 = SOUNDFONT_DIR + "/tr909/Roland_TR-909_batteria_elettronica.sf2";
final String ARACHNO = SOUNDFONT_DIR + "/arachno/Arachno SoundFont - Version 1.0.sf2";
final String M1 = SOUNDFONT_DIR + "/m1/HS M1 Drums.sf2";
final String VDW = SOUNDFONT_DIR + "/hammersound/Vintage Dreams Waves v2.sf2";
final String MUSYNG = SOUNDFONT_DIR + "/musyng/Musyng Kite.sf2";
final String HS_PT1 = SOUNDFONT_DIR + "/hammersound/HS Pads and Textures I.sf2";
final String FLUID = SOUNDFONT_DIR + "/fluid/FluidR3 GM2-2.SF2";

class MyFWS extends FunWithSound {
  MyFWS(PApplet parent) {
    super(parent);
  }
  
  protected Player createPlayer() {
    Player player = super.createPlayer();
    registerCustomInstruments(player);
    return player;
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
    naturalMinor(57); // A minor, rooted at A3
    
    // Sample player
    Instrument sp = samplePlayer();
    sp.addSample(0, SAMPLE_DIR + "/youtube/knowtherules.wav", .4); // the entire sample
    sp.addSample(1, SAMPLE_DIR + "/youtube/knowtherules.wav", 1494, 2654, .4); // "know the rules"
    sp.addSample(2, SAMPLE_DIR + "/youtube/knowtherules.wav", 778, 1399, .4); // "one of us"
    sp.addSample(3, SAMPLE_DIR + "/youtube/knowtherules.wav", 1822, 2457, .4); // "the rules"
    sp.addSample(4, SAMPLE_DIR + "/youtube/knowtherules.wav", 1494, 1850, .4); // "know"
    sp.addSample(5, SAMPLE_DIR + "/youtube/knowtherules.wav", 89, 810, .4); // "it's up to each"

    // Set up a percussion instruments for building a rhythm pattern
    Instrument drumkit = percussion(FLUID);
    
    // Nice synth bass sound
    Instrument bass = instr(VDW, 4);
    v(bass,0.6); // make the bass a bit quieter
    
    Rhythm dr = r(p(0,127), p(1.5,101), p(2,127), p(4,127), p(5.5,101), p(6,127));
    Melody dm = m(an(36), an(36), an(39), an(36), an(36), an(39));
    Figure df = f(dr, dm, drumkit);
    
    Rhythm hr = r(
      p(.5,101), p(1,101), p(1.5,101), p(2,101), s(2.5,1.5,101),
      s(6,.5,101), s(6.5,1,101), s(7,.5,101)
    );
    Melody hm = m(
      an(42), an(42), an(42), an(42), an(46),
      an(44), an(46), an(44)
    );
    Figure hf = f(hr, hm, drumkit);
    
    Rhythm bassr = r(
      s(0,0.5,106), s(2,0.5,110), s(2.5,0.5,106), s(3,0.5,110),
      s(4,0.5,118), s(6,0.5,110), s(6.5,0.5,106), s(7,0.5,110));
    Melody bassm = m(
      an(40), an(40), an(50), an(40), an(40), an(40), an(50), an(40));
    Figure bassf = f(bassr, bassm, bass);
    
    // figure to play the entire sample: it's about 2 measures long
    Rhythm sampr = r(p(0));
    Melody sampm = m(an(0));
    Figure sampf = f(sampr, sampm, sp);
    
    // "stutter" figure with just "know the rules" repeated several times
    Rhythm samp2r = r(p(0),p(1),p(2),p(3),p(4));
    Melody samp2m = m(an(1),an(1),an(1),an(1),an(1));
    Figure samp2f = f(samp2r, samp2m, sp);
    
    // faster "stutter" figure
    Rhythm samp3r = r(p(0),p(.5),p(1),p(1.5),p(2),p(2.5),p(3),p(3.5), p(4));
    Melody samp3m = m(an(1),an(1),an(1),an(1),an(1),an(1),an(1),an(1),an(1));
    Figure samp3f = f(samp3r, samp3m, sp);
    
    // mismash of various parts of the sample, re-arranged
    Rhythm samp4r = r(p(0),p(1.5), p(2.5),p(4),p(5.5), p(6.5));
    Melody samp4m = m(an(3),an(4), an(5),an(3),an(4), an(5));
    Figure samp4f = f(samp4r, samp4m, sp);
    
    add1(gf(df,hf));
    add1(gf(df,hf));
    add1(gf(df,hf,bassf));
    add1(gf(df,hf,bassf));
    add1(gf(df,hf,bassf));
    add1(gf(df,hf,bassf));
    add1(gf(df,hf,sampf));
    add1(gf(df,hf));
    add1(gf(df,hf,sampf));
    add1(gf(df,hf));
    add1(gf(df,hf,samp2f));
    add1(gf(df,hf,samp2f));
    add1(gf(df,hf,samp2f));
    add1(gf(df,hf,samp2f));
    add1(gf(df,hf,bassf,samp3f));
    add1(gf(df,hf,bassf,samp3f));
    add1(gf(df,hf,bassf,samp3f));
    add1(gf(df,hf,bassf,samp3f));
    add1(gf(df,hf,bassf,samp4f));
    add1(gf(df,hf,bassf,samp4f));
    add1(gf(df,hf,bassf,samp4f));
    add1(gf(df,hf,bassf,samp4f));
    add1(gf(df,hf,bassf,samp3f));
    add1(gf(df,hf,bassf,samp3f));
    add1(gf(df,hf,bassf,samp3f));
    add1(gf(df,hf,bassf,samp3f));
    add1(gf(df,hf));
    add1(gf(df,hf));
    
    audition(bass);
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
  //fws.play(c);
  fws.saveWaveFile(c, "/home/dhovemey/drum+bass+knowtherules.wav");
}

void registerCustomInstruments(Player player) {
  CustomInstrumentFactory factory = new CustomInstrumentFactoryImpl(
    0, new CustomInstrumentFactoryImpl.CreateCustomInstrument() {
      public RealizedInstrument create(AudioContext ac) {
        DataBead params = Defaults.monosynthDefaults();
        params.put(ParamNames.GLIDE_TIME_MS, 80.0f);
        SynthToolkit tk = SynthToolkitBuilder.start()
          .withWaveVoice(Buffer.SAW)
          .withASRNoteEnvelope()
          .getTk();
        MonoSynthUGen2 u = new MonoSynthUGen2(ac, tk, params,
          new double[]{ 1.0, 1.5, 2.0 },
          new double[]{ 1.0, .5, .4 }
          );
        return new RealizedInstrument(u, ac);
      }
    });
  player.setCustomInstrumentFactory(factory);
}
