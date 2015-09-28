import io.github.daveho.funwithsound.*;
import net.beadsproject.beads.core.*;
import net.beadsproject.beads.data.*;

FunWithSound fws = new FunWithSound(this) {
  protected Player createPlayer() {
    Player player = super.createPlayer();
    registerCustomInstruments(player);
    return player;
  }
};

class MyComp extends Composer {
  void create() {
    tempo(200, 8);  // 200 beats per minute, 8 beats per measure

    // Metronome instrument for keeping time
    Instrument metronome = percussion();

    // Set up the custom instrument that will be used for notes played live
    Instrument synth = custom(1); // <-- change this to select among the custom instruments
    addfx(synth, new AddReverb()); // <-- uncomment this line to add reverb
    v(synth, 0.2); // reduce the volume
    
    Instrument synth2 = custom(1);
    addfx(synth2, new AddReverb());
    v(synth2, 0.2); // reduce the volume
    
    // Metronome pattern: plays a closed hihat every 2 beats
    Rhythm metr = rr(p(0,101), 2, 4);
    Figure metf = pf(metr, 42, metronome);
    
    // Notes captured for replay
    Rhythm bassr = r(
      s(0.000,1.037,96), s(2.114,1.072,96), s(4.153,0.459,93), s(4.608,0.665,75), s(5.768,0.535,90), s(6.795,0.452,93), s(7.103,0.611,72));
    Melody bassm = m(
      an(38), an(38), an(38), an(45), an(43), an(43), an(36));
    Figure bassf = f(bassr, bassm, synth2);
    
    // Add 4 measures of the metronome pattern and bass pattern
    add1(gf(metf,bassf));
    add1(gf(metf,bassf));
    add1(gf(metf,bassf));
    add1(gf(metf,bassf));
    
    // Play live using the custom instrument
    audition(synth);
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
}


void registerCustomInstruments(Player player) {
  // The code below defines the characteristics of the custom instruments.
  // Comments indicate where you can make changes.
  
  CustomInstrumentFactory factory = new CustomInstrumentFactoryImpl(
    // Custom instrument 0: plays simple wave forms with a single frequency,
    // using a simple on/off envelope
    0, new CustomInstrumentFactoryImpl.CreateCustomInstrument() {
      public RealizedInstrument create(AudioContext ac) {
        DataBead params = Defaults.monosynthDefaults();
        params.put(ParamNames.GLIDE_TIME_MS, 0.0f);
        SynthToolkit tk = SynthToolkitBuilder.start()
          .withWaveVoice(Buffer.SINE) // <-- try Buffer.SQUARE, Buffer.SAW, Buffer.TRIANGLE
          .withOnOffNoteEnvelope()
          .getTk();
        MonoSynthUGen2 u = new MonoSynthUGen2(ac, tk, params,
          new double[]{ 1.0 },
          new double[]{ 1.0 }
          );
        return new RealizedInstrument(u, ac);
      }
    },
    
    // Custom instrument 1: simple waveforms with a single frequency,
    // but with an attack/sustain/release envelope
    1, new CustomInstrumentFactoryImpl.CreateCustomInstrument() {
      public RealizedInstrument create(AudioContext ac) {
        DataBead params = Defaults.monosynthDefaults();
        params.put(ParamNames.GLIDE_TIME_MS, 0.0); // <-- try increasing this for portamento
        params.put(ParamNames.ATTACK_TIME_MS, 10.0); // <-- change the attack time
        params.put(ParamNames.RELEASE_TIME_MS, 80.0); // <-- change the release time
        SynthToolkit tk = SynthToolkitBuilder.start()
          .withWaveVoice(Buffer.SAW) // <-- try Buffer.SQUARE, Buffer.SAW, Buffer.TRIANGLE
          .withASRNoteEnvelope()
          .getTk();
        MonoSynthUGen2 u = new MonoSynthUGen2(ac, tk, params,
          new double[]{ 1.0 },
          new double[]{ 1.0 }
          );
        return new RealizedInstrument(u, ac);
      }
    },
    
    // Custom instrument 2: simple wave forms with multiple frequencies,
    // with attack/sustain/release envelope
    2, new CustomInstrumentFactoryImpl.CreateCustomInstrument() {
      public RealizedInstrument create(AudioContext ac) {
        DataBead params = Defaults.monosynthDefaults();
        params.put(ParamNames.GLIDE_TIME_MS, 40.0);
        SynthToolkit tk = SynthToolkitBuilder.start()
          .withWaveVoice(Buffer.SINE) // <-- try Buffer.SQUARE, Buffer.SAW, Buffer.TRIANGLE
          .withASRNoteEnvelope()
          .getTk();
        MonoSynthUGen2 u = new MonoSynthUGen2(ac, tk, params,
          new double[]{ 1.0, 1.5, 2.0 }, // <-- try changing the multiples, adding new multiples
          new double[]{ 1.0, 0.5, 0.25 } // <-- try changing the gains (volumes)
          );
        return new RealizedInstrument(u, ac);
      }
    }
    
    );
  player.setCustomInstrumentFactory(factory);
}
