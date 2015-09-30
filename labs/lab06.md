---
layout: default
title: "Lab 6: Rhythm section"
---

# Learning goals

* Use FunWithSound Rhythm, Melody, and Figure objects to create and play drum patterns
* Use soundfonts to load instrument sounds

# What to do

Your task is to create a rhythm part using soundfonts and MIDI percussion instruments.  This lab is the first step in a series of labs in which you will create a music composition.

First, follow the instructions in *Getting started*.  Next, read through the examples in the *Example* section, and adapt the techniques to create your own rhythm.  Also, see the *Other things to try* section at the end.

## Getting started

If you have not already done so, download the **soundfonts.zip** file and extract it onto a USB flash drive, as described in the agenda for [Day 10](../agenda/day10.html).

Start Processing.  Copy the following code into the Processing editor:

{% highlight java %}
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

    // Set up a percussion instrument for building a rhythm pattern
    Instrument drumkit = percussion(TR808);
    
    // Metronome pattern: plays a closed hihat every 2 beats
    Rhythm metr = rr(p(0,101), 2, 4);
    Figure metf = pf(metr, 42, metronome);
    
    // Add 4 measures of the metronome pattern
    add1(gf(metf));
    add1(gf(metf));
    add1(gf(metf));
    add1(gf(metf));
 
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
  //fws.saveWaveFile(c, "myrhythm.wav");
}
{% endhighlight %}

**Important**: You may need to change the definition of the `SOUNDFONT_DIR` variable so that it correctly refers to the USB flashdrive that has your soundfont files.

## Example

This example shows the creation of a rhythm that might be appropriate for some type of [Electronic Dance Music](https://en.wikipedia.org/wiki/Electronic_dance_music).

Typical components of a rhythm in EDM include

* Four beats per measure
* Kick drum (often on the first and third beats)
* Snare, often following the kick drum, and often [syncopated](https://en.wikipedia.org/wiki/Syncopation)
* Hihat cymbals, often used for "fills" between the kick drum and snare

Note that in the starter code shown above, the tempo is actually set to use 8 beats per measure.  There is really no particular difference between 4 beats per measure and 8 beats per measure.  If you want to use 4 beats per measure, and lower the number of beats per minute, that's fine.  However, the code below will assume 8 beats per measure.

One question to think about is what you would like the percussion sounds to sound like.  FunWithSound supports *soundfonts*, which are libraries of instrument sounds.  The **soundfonts.zip** file you downloaded and extracted onto your USB flash drive has a number of interesting soundfonts.  Some of these soundfonts emulate particular synthesizers or drum machines, while others are "general purpose" soundfonts containing a large variety of different instrument sounds.

Most sound fonts are organized according to the [GM1 sound set](http://www.midi.org/techspecs/gm1sound.php) as defined in the [MIDI](http://www.midi.org/) standard.  Part of the GM1 standard defines the organization of percussion instruments, where particular MIDI note numbers correspond to particular percussion sounds: see the [General MIDI Level 1 Percussion Key Map](http://www.midi.org/techspecs/gm1sound.php#percussion).  For example, in a MIDI percussion instrument, note number 42 is a closed hihat sound.

Let's build up a rhythm first with a kick drum, then adding a snare, then adding hihats.

I am going to use a soundfont based on the [Roland TR-808](https://en.wikipedia.org/wiki/Roland_TR-808) drum machine.  (You will notice that the `drumkit` instrument defined in the starting code loads a TR-808 soundfont.)  The TR-808 is hugely important for many genres of music, including hip hop and many forms of electronic dance music.  You will probably recognize many of the TR-808 percussion sounds from songs you have heard.

### Kick drum

First, the kick drums.  The MIDI note number for "Bass Drum 1" is 36.  FunWithSound defines the beginning of a measure to be beat 0, and we have defined this composition to have 8 beats per measure.  We will define a kick drum pattern with strikes on beats 0, 1, 5, and 6.5.

{% highlight java %}
Rhythm kickr = r(p(0,127), p(1,127),p(5,127),p(6.5,127));
Melody kickm = m(an(36), an(36), an(36), an(36));
Figure kickf = f(kickr, kickm, drumkit);
{% endhighlight %}

The `r` command creates a Rhythm object with a specified pattern of Strikes.  Each strike is specified with the `p` command, which specifies a start beat and a strike velocity.  The velocity indicates the forcefulness of the strike, with 127 being the maximum velocity.  The `m` command creates a Melody object with a specified pattern of Chords (which are usually single notes.)  The `an` function creates a note from a MIDI note number, and (as noted above) 36 is "Bass drum 1".  The `f` command creates a Figure object specifying a particular rhythm and melody to be played using a specified instrument (in this case, the `drumkit` instrument.)

Let's play this pattern along with the metronome pattern.  We'll change the `add1` commands that schedule figures to be played to add the `kickf` figure:

{% highlight java %}
add1(gf(metf,kickf));
add1(gf(metf,kickf));
add1(gf(metf,kickf));
add1(gf(metf,kickf));
{% endhighlight %}

Here's how it sounds:

> <iframe width="500" height="166" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/226268485&amp;color=ff5500&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false&amp;show_artwork=false"></iframe>

### Snare

Next, we'll add a snare pattern to play at the same time as the kick pattern.  MIDI note number 40 is "Electric Snare".  We'll put snare strikes on beats 2, 3.5, 4.5, and 6, leading to a vaguely hip-hop rhythm:

{% highlight java %}
Rhythm snarer = r(p(2,127), p(3.5,127), p(4.5, 127), p(6,127));
Melody snarem = m(an(40),an(40),an(40),an(40));
Figure snaref = f(snarer, snarem, drumkit);
{% endhighlight %}

And, we'll schedule this snare pattern to play along with the metronome and kick drum pattern:

{% highlight java %}
add1(gf(metf,kickf,snaref));
add1(gf(metf,kickf,snaref));
add1(gf(metf,kickf,snaref));
add1(gf(metf,kickf,snaref));
{% endhighlight %}

Here's how it sounds:

> <iframe width="500" height="166" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/226268879&amp;color=ff5500&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false&amp;show_artwork=false"></iframe>

### Hihats

Finally, let's add some hihats.  Personally, I think hihats are hugely important in providing texture to a rhythm pattern, and for adding additional syncopation.

The MIDI GM1 standard defines three hihat sounds:

* Note number 42 is "Closed Hi Hat", which is a short "tick" sound
* Note number 44 is "Pedal Hi Hat", which the the sound of banging together the two hihat cymbals using the foot pedal
* Note number 46 is "Open Hi Hat", which is a more sustained sound

Personally, I find that the pedal hihat sound isn't particularly useful, so I just use closed and open sounds.

One important consideration with hihat sounds is that it is necessary to specify a *duration* for the open hihat sound, which you can think of as how long the hihat is allowed to "ring" before being muted.  With the previous percussion sounds, we used the `p` command to create "percussive" strikes with only a start beat and velocity.  With open hihats, we need to use the `s` command to specify a start beat, a duration (in beats), and a velocity.

I like hihat patterns with a lot of very quick closed hihat strikes and a few open hihat strikes mixed in:

{% highlight java %}
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
{% endhighlight %}

This hihat pattern shows how to create complex patterns by combining simpler patterns:

* `gr` means "group rhythm", and allows a single rhythm to be built up by combining simpler rhythms
* `rr` means "repeated rhythm", and works by repeating an initial strike a specified number of times, with the strikes separated by a given number of beats
* `s` creates a strike with a start, duration, and velocity (useful for open hihat sounds, where we need to specify a duration)
* `gm` means "group melody", and allows a melody to be built up by combining simpler melodies
* `rm` means "repeated melody", creating a melody by duplicating a note a specified number of times

Let's add the hihat pattern to play along with the kick and snare patterns.  Note that I am removing the metronome pattern at this point, since we already have a relatively complete rhythm:

{% highlight java %}
add1(gf(kickf,snaref,hihatf));
add1(gf(kickf,snaref,hihatf));
add1(gf(kickf,snaref,hihatf));
add1(gf(kickf,snaref,hihatf));
{% endhighlight %}

Here's what it sounds like:

> <iframe width="500" height="166" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/226275363&amp;color=ff5500&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false&amp;show_artwork=false"></iframe>

Here is the final version of the code:

> [RhythmSection.pde](https://github.com/ycpcs/fys100-fall2015/blob/gh-pages/examples/RhythmSection.pde)

## Other things to try

The example above is just a starting point.  There are lots of other things you can do to create interesting rhythms for your composition.

### Multiple percussion sounds

Other soundfonts will give you different percussion sounds.  In the starter code above, you will see variables referring to several different soundfonts.  Try changing the definition of the `drumkit` instrument to use a different soundfont.  For example, here is the example rhythm with the `TR909` soundfont, which emulates the [Roland TR-909](https://en.wikipedia.org/wiki/Roland_TR-909) drum machine:

> <iframe width="500" height="166" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/226276453&amp;color=ff5500&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false&amp;show_artwork=false"></iframe>

Here is the example rhythm using the [Musyng Kite](http://www.kvraudio.com/forum/viewtopic.php?t=351893) soundfont:

> <iframe width="500" height="166" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/226277780&amp;color=ff5500&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false&amp;show_artwork=false"></iframe>

Note that there is no reason why you need to use a single soundfont for all of your percussion sounds.  For example, you might like the kick and snare sounds in `TR808`, but prefer the hihat sounds in `TR909`.  All you need to do to use multiple soundfonts is to create multiple instruments, and change your figures to use the appropriate instrument.  For example:

{% highlight java %}
Instrument drumkit = percussion(TR808);
Instrument hihats = percussion(TR909);

// ... elsewhere in the program ...

Figure kickf = f(kickr, kickm, drumkit);

Figure hihatf = f(hihatr, hihatm, hihats);
{% endhighlight %}

### Mix it up

You don't need to play exactly the same rhythm over and over again.  You might create two distinct rhythm patterns, and then play them in alternating measures.

### Drop out

You can have some of your instrument sounds "drop out" for a measure, or perhaps several measures.  For example:

* Have the hihats drop out
* Have everything but the kick drum drop out

### Play live

Use the `audition` command to play a percussion instrument live.  The `ARACHNO` soundfont has some really interesting percussion sounds (including sounds for note numbers beyond the ones defined by the GM1 standard.)
