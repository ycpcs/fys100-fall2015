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

TODO.
