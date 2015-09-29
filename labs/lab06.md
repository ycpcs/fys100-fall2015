---
layout: default
title: "Lab 6: Beatbox"
---

*Note: This lab is not complete yet*

# Learning goals

* Use FunWithSound Rhythm, Melody, and Figure objects to create and play drum patterns
* Use soundfonts to load instrument sounds

# What to do

Your task is to create a rhythm part using soundfonts and MIDI percussion instruments.  This lab is the first step in a series of labs in which you will create a music composition.

First, follow the instructions in *Getting started*.  Next, read through the examples in the *Example* section, and adapt the techniques to create your own rhythm.

## Getting started

If you have not already done so, download the **soundfonts.zip** file and extract it onto a USB flash drive, as described in the agenda for [Day 10](../agenda/day10.html).

Start Processing.  Copy the following code into the Processing editor:

{% highlight java %}
import io.github.daveho.funwithsound.*;
import net.beadsproject.beads.core.*;
import net.beadsproject.beads.data.*;

// You may need to change this, depending on which drive letter
// is assigned to your USB flash drive.
final String SOUNDFONT_DIR = "D:/";

// Some good percussion soundfonts
final String TR808 = SOUNDFONT_DIR + "/tr808/Roland_TR-808_batteria_elettronica.sf2";
final String TR909 = SOUNDFONT_DIR + "/tr909/Roland_TR-909_batteria_elettronica.sf2";
final String ARACHNO = SOUNDFONT_DIR + "/arachno/Arachno SoundFont - Version 1.0.sf2";

FunWithSound fws = new FunWithSound(this);

class MyComp extends Composer {
  void create() {
    tempo(200, 8);  // 200 beats per minute, 8 beats per measure

    // Metronome instrument for keeping time
    Instrument metronome = percussion();

    // Set up a percussion instrument for building a rhythm pattern
    Instrument drumkit = percussion(TR808);
    
    // Metronome pattern: plays a closed hihat every 2 beats
    Rhythm metr = rr(p(0,101), 2, 4);
    Figure metf = pf(metr, 42, metronome);
    
    // Add 8 measures of the metronome pattern
    add1(gf(metf));
    add1(gf(metf));
    add1(gf(metf));
    add1(gf(metf));
    add1(gf(metf));
    add1(gf(metf));
    add1(gf(metf));
    add1(gf(metf));
 
    // Play live using your drumkit instrument
    audition(drumkit);
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
{% endhighlight %}

## Example

This example shows the creation of a rhythm that might be appropriate for some type of [Electronic Dance Music](https://en.wikipedia.org/wiki/Electronic_dance_music), possibly [House](https://en.wikipedia.org/wiki/House_music) (?).

Typical components of a rhythm in EDM include

* Four beats per measure
* Kick drum (often on the first and third beats)
* Snare, often following the kick drum, and often [syncopated](https://en.wikipedia.org/wiki/Syncopation)
* Hihat cymbals, often used for "fills" between the kick drum and snare

Note that in the starter code shown above, the tempo is actually set to use 8 beats per measure.  There is really no particular difference between 4 beats per measure and 8 beats per measure.  If you want to use 4 beats per measure, and lower the number of beats per minute, that's fine.  However, the code below will assume 8 beats per measure.

One question to think about is what you would like the percussion sounds to sound like.  FunWithSound supports *soundfonts*, which are libraries of instrument sounds.  The **soundfonts.zip** file you downloaded and extracted onto your USB flash drive has a number of interesting soundfonts.  Some of these soundfonts emulate particular synthesizers or drum machines, while others are "general purpose" soundfonts containing a large variety of different instrument sounds.

Most sound fonts are organized according to the [GM1 sound set](http://www.midi.org/techspecs/gm1sound.php) as defined in the [MIDI](http://www.midi.org/) standard.
