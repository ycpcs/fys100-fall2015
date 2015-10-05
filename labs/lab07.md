---
layout: default
title: "Lab 7: Lay down a groove"
---

# Learning goals

* Understand semitones and scales
* Create and use melodic instruments in FunWithSound
* Understand the [GM1 Sound Set](http://www.midi.org/techspecs/gm1sound.php)

# What to do

Your task is to add melodic parts to the composition you started in [Lab 6](lab06.html).

My suggestion is to start with a bass part, then some pads, then a melodic lead.

Start by reading *Pitches and scales*, then read *An example* to get an idea of how to proceed with your own composition.

## Pitches and scales

Here is a tiny bit of music theory.

### Octaves

As we saw in [Lab 5](lab05.html), a note's pitch is determined by its frequency.  The higher the frequency, the higher the pitch.

An interesting auditory phenomenon occurs when you multiply a note's frequency by 2: you get a higher note that sounds "the same" as the first note, only higher:

> <iframe width="500" height="166" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/227054905&amp;color=ff5500&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false&amp;show_artwork=false"></iframe>

Frequencies that differ by a factor of 2 are one *octave* apart.

So, what about notes within a scale?  Western music uses a 12 tone scale, meaning that there are 12 distinct pitches in each octave.  The difference between two notes is called a *semitone* or a *half step*.  So, what is the relationship between the notes within an octave?

The basic idea is that we want the notes within the scale to be separated by more or less the same difference in pitch.  Because the next higher octave involves doubling the frequency, moving to the next note involves "one-twelfth doubling" of the frequency.  The idea is that there is a factor, which, if multiplied by a note frequency, gives us the frequency of the next note, *and*, if we multiply a note frequency by the factor 12 times, we effectively double the frequency, giving us the same note at the next higher octave.

This "note multiplier", which we'll call *f*, can be computed as

> *f* = 2<sup>1/12</sup>

In other words, 2 raised to the power 1/12.  This factor is approximately 1.059.  Multiplying any note frequency by *f* gives us the frequency of the next higher note, and dividing by *f* gives us the frequency of the next lower note.  This scheme is known as [equal temperament](https://en.wikipedia.org/wiki/Equal_temperament), and in modern times is used nearly universally for instrument tuning.

Note that because equal temperament only tells us how to move between notes, we need to have one note's frequency to be specified as a constant.  The most common standard is that A4 (the note "A" in the fourth audible octave) is defined as exactly 440 Hz.  All other note frequencies are defined relative to this reference point.

### Scales

If you've ever sat down at a piano or keyboard and played random keys, you've probably noticed that it doesn't sound very good.  This is because most western music uses notes selected from a *scale*.  Typically, a scale includes exactly 7 notes.  Scales are defined by specifying a pattern of how many semitones there are between notes.  The important thing to realize about scales is that the number of semitones to reach the next note is not always 1!

A major scale uses the following pattern of semitones:

> 2, 2, 1, 2, 2, 2, 1

Here is a C major scale:

> <iframe width="500" height="166" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/227058130&amp;color=ff5500&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false&amp;show_artwork=false"></iframe>

A natural minor scale uses the following pattern of semitones:

> 2, 1, 2, 2, 1, 2, 2

Note how in each case, the sum of the semitone increments is 12, which makes sense, because the progression specifies how to reach the scale's root note in the next higher octave.

Here is a C minor scale:

> <iframe width="500" height="166" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/227058460&amp;color=ff5500&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false&amp;show_artwork=false"></iframe>

Notice how the major scale sounds "happy", and the minor scale sounds "sad".

### What this means to you

You will probably want to pick a scale to use in your composition, and use notes selected from that scale.  In particular, C major and A minor are good choices, because the notes in those scales correspond exactly to the white keys on the piano keyboard.

## An example

The example from [Lab 6](lab06.html) created a vaguely hip-hop rhythm:

> <iframe width="500" height="166" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/226275363&amp;color=ff5500&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false&amp;show_artwork=false"></iframe>

### Bass

Let's add a bass part.  First, we need to choose an instrument sound.  When choosing a melodic instrument, the two general options are:

* Use a general purpose soundfont, and look for a suitable patch in the [GM1 Sound Set](http://www.midi.org/techspecs/gm1sound.php)
* Use a special purpose soundfont, and experiment with the available patches

The first approach is easy.  The soundfont zipfile that you extracted onto your flash drive has three general purpose soundfonts: [Arachno](http://www.arachnosoft.com/main/soundfont.php), [FluidR3](https://musescore.org/en/handbook/soundfont), and [Musyng Kite](http://www.kvraudio.com/forum/viewtopic.php?t=351893).  Your program should already include variables `ARACHNO` and `MUSYNG` to select the Arachno and Musyng Kite soundfonts.  You can add the following soundfont for FluidR3:

{% highlight java %}
final String FLUID = SOUNDFONT_DIR + "/fluid/FluidR3 GM2-2.SF2";
{% endhighlight %}

All of these general purpose soundfonts use the GM1 sound set to organize their available sounds.  All of them are very good, but I would encourage you to experiment with them to see which ones you like the most.  In the GM1 sound set, patches 33&ndash;40 all represent bass sounds.  Personally, I like the "synth bass" sounds, which are patches 39 and 40.  Here is how we could define an instrument for the Arachno soundfont, and the "Synth Bass 1" patch:

{% highlight java %}
Instrument bass = instr(ARACHNO, 39);
{% endhighlight %}

The second approach requires a bit more work.  Some soundfonts don't use the GM1 sound set to organize their available sounds, meaning that you need to experiment to find appropriate instrument sounds.  However, some of these more specialized soundfonts have some excellent sounds, so exploring them is very worthwhile.  For example, the [Vintage Dreams Waves](http://www.hammersound.net/hs_soundfonts.html) soundfont is a collection of sounds inspired by vintage analog synthesizers: you should see a `VDW` variable in your program which references this soundfont.  Through experimentation, I found that patch 4 in this soundfont is a nice synth bass sound.  So, I will define my `bass` instrument as

{% highlight java %}
Instrument bass = instr(VDW, 4);
{% endhighlight %}

*Now for the hard part.*  The hardest part of creating a melodic part for a composition is coming up with the rhythm and melody.  There are a two general approaches.  One approach is to play a part live, then copy and paste the rhythm and melody into the composition, and then edit them until they sound like what you intended.  To do this, change the `audition` command at the bottom of your `create` method so that it specifies the instrument you want to play live.  For example:

{% highlight java %}
audition(bass);
v(bass,0.6); // make the bass a bit quieter
{% endhighlight %}

Here is a bass melody I captured by playing live:

{% highlight java %}
Melody bassm = m(
  an(45), an(45), an(45),
  an(45), an(45), an(45),
  an(41), an(41), an(41),
  an(41),an(38));
{% endhighlight %}

Note that all of the notes in this melody are created using the `an` command, which specifies a note using an absolute [MIDI note number](https://newt.phys.unsw.edu.au/jw/notes.html).  So, if you have specified a particular scale for your composition, the notes you played live may or may not be part of the scale you are using.

<div class="callout">
<b>Protip</b>: If you use a C major or A minor scale, all of your notes correspond to white keys on the piano keyboard.  Using these scales makes it very likely that the notes you play will sound correct if you only hit white keys when you play live.
</div>

Another possibility is to define a scale for your composition, and specify your melody relative to this scale.  First, define the scale (put this just below the `tempo` command at the beginning of your `create` method):

{% highlight java %}
naturalMinor(57); // A minor, rooted at A3
{% endhighlight %}

What this means is that I am using a minor scale, with MIDI note 57 (A3) being the "root" note of the scale.  The other command you can use to specify a scale are `major`, `melodicMinor`, and `harmonicMinor`.

Here is the same bass melody specified using scale-relative note numbers:

{% highlight java %}
Melody bassm = m(-7, -7, -7, -7, -7, -7, -9, -9, -9, -9, -11);
{% endhighlight %}

This is exactly equivalent to the original melody.

It is up to you whether you specify melodies using absolute MIDI note numbers or scale-relative note numbers.  In fact, you can use both in the same composition.  It's your choice.

Once you have a melody, you need to specify a rhythm.  Here is the rhythm I came up with:

{% highlight java %}
Rhythm bassr = r(
  s(0,.5,101), s(.5,.5,101), s(1.5,1,101),
  s(5,.5,101), s(5.5,.5,101), s(6.5,1,101),
  s(8,.5,101), s(8.5,.5,101), s(9.5,1,101),
  s(11,.5,101), s(11.5,4,101)
);
{% endhighlight %}

Once you have specified a melody and rhythm, you can use them to create a figure:

{% highlight java %}
Figure bassf = f(bassr, bassm, bass);
{% endhighlight %}

Finally, incorporate the figure into your composition.  The bass figure shown above is two measures long.  So, I can specify it to start playing every two measures if I want an ongoing bass pattern.  Combining this with my percussion figures, the overall composition is now:

{% highlight java %}
add1(gf(kickf,snaref,hihatf,bassf));
add1(gf(kickf,snaref,hihatf));
add1(gf(kickf,snaref,hihatf,bassf));
add1(gf(kickf,snaref,hihatf));
{% endhighlight %}

Here is what it sounds like:

> <iframe width="500" height="166" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/227034913&amp;color=ff5500&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false&amp;show_artwork=false"></iframe>

### Pad

A synth "pad" is a sustained note or chord, often similar to strings, used as a background accompaniment to a composition.  Patches 89&ndash;96 in the GM1 sound set specify pad sounds, so one of the general-purpose soundfonts is a good place to look for pads.  Let's try the "Pad 8 (sweep)" sound in the FluidR3 soundfont:

{% highlight java %}
Instrument pad = instr(FLUID, 96);
{% endhighlight %}

Here is a rhythm, melody, and figure (I played this live, and then edited the rhythm to make the notes start and end in the right places):

{% highlight java %}
Rhythm padr = r(
  s(0,6,101), s(6,1,101), s(7,1,101),
  s(8,4,101), s(12,2,101), s(14,2,101),
  s(16,6,101), s(22,1,101), s(23,1,101),
  s(24,4,101), s(28,2,101), s(30,2,101)
);
Melody padm = m(
  an(71), an(72), an(74),
  an(71), an(72), an(69),
  an(71), an(69), an(67),
  an(69), an(67), an(69));
Figure padf = f(padr, padm, pad);
{% endhighlight %}

This figure is four measures long, so we only need to play it every fourth measure.  Let's extend the composition to 8 measures, and combine this part with the percussion and bass parts:

{% highlight java %}
add1(gf(kickf,snaref,hihatf,bassf,padf));
add1(gf(kickf,snaref,hihatf));
add1(gf(kickf,snaref,hihatf,bassf));
add1(gf(kickf,snaref,hihatf));
add1(gf(kickf,snaref,hihatf,bassf,padf));
add1(gf(kickf,snaref,hihatf));
add1(gf(kickf,snaref,hihatf,bassf));
add1(gf(kickf,snaref,hihatf));
{% endhighlight %}

Here is how it sounds:

> <iframe width="500" height="166" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/227042499&amp;color=ff5500&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false&amp;show_artwork=false"></iframe>

### Lead

A lead part carries the composition's main melody.

I think any discussion of synth leads would be incomplete without at least mentioning the Doctor Who theme composed by [Ron Grainer](https://en.wikipedia.org/wiki/Ron_Grainer) and played by [Peter Howell](https://en.wikipedia.org/wiki/Peter_Howell_(musician%29):

> <iframe width="252" height="189" src="https://www.youtube.com/embed/v2oCK89xxNQ" frameborder="0" allowfullscreen></iframe>

In the spirit of reproducing some authentic 1980s cheesiness, let's use a custom instrument based on a sawtooth wave, add some portamento (for the "sliding" effect from note to note), and put on some delays and a reverb.  First, the instrument definition:

{% highlight java %}
Instrument lead = custom(0);
v(lead, 0.1); // the raw waveforms are super loud, quiet it down 
addfx(lead, new AddDelay(300.0, 1.0, 0.5));
addfx(lead, new AddDelay(600.0, 1.0, 0.4));
addfx(lead, new AddDelay(900.0, 1.0, 0.3));
addfx(lead, new AddReverb());
{% endhighlight %}

In order to use a custom instrument, we need to add one method to the `MyFWS` class, and one method to the overall sketch.  The method to add to `MyFWS` is:

{% highlight java %}
protected Player createPlayer() {
  Player player = super.createPlayer();
  registerCustomInstruments(player);
  return player;
}
{% endhighlight %}

The method to add at the end of the sketch is:

{% highlight java %}
void registerCustomInstruments(Player player) {
  CustomInstrumentFactory factory = new CustomInstrumentFactoryImpl(
    0, new CustomInstrumentFactoryImpl.CreateCustomInstrument() {
      public RealizedInstrument create(AudioContext ac) {
        DataBead params = Defaults.monosynthDefaults();
        params.put(ParamNames.GLIDE_TIME_MS, 80.0f);
        SynthToolkit tk = SynthToolkitBuilder.start()
          .withWaveVoice(Buffer.SAW)
          .withOnOffNoteEnvelope()
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
{% endhighlight %}

You can refer to the completed source code, [Groove.pde](https://github.com/ycpcs/fys100-fall2015/blob/gh-pages/examples/Groove.pde), to see exactly where to put these methods.

Note that you absolutely can and should use a lead instrument chosen from a soundfont, if you would prefer that to a custom instrument.  Patches 81&ndash;88 in the GM1 sound set are synth leads, but in general you will find lots of sounds that work well for leads.

Once our lead instrument is in place, we just need a rhythm and melody:

{% highlight java %}
Rhythm leadr = r(
  s(2,2,106), s(4,4,93),
  s(7,1,102), s(8,2,102), s(10,1,81), s(11,2,72), s(13,3,90),
  s(18,2,79), s(20,4,99),
  s(23,1,77), s(24,2,67), s(26,1,71), s(27,2,110), s(29,1,110), s(30,2,67),
  s(34,2,106), s(36,3,79),
  s(39,1,85), s(40,2,99), s(42,1,96), s(43,2,106), s(45,3,87),
  s(50,2,102), s(52,1,102), s(53,2,87),
  s(55,1,87), s(56,6,106)
  );
Melody leadm = m(
  an(76), an(77),
  an(67), an(77), an(76), an(65), an(67),
  an(76), an(77),
  an(76), an(79), an(77), an(76), an(71), an(76),
  an(76), an(77),
  an(76), an(77), an(76), an(69), an(79),
  an(76), an(77), an(76),
  an(67), an(69)
);
Figure leadf = f(leadr, leadm, lead);
{% endhighlight %}

Again, I played this part live, and then edited the rhythm until all of the notes were in the right places.

This figure is 8 measures long.  We'll update the composition so that there is a percussion lead in, then the bass enters, then the pad enters, then the pad drops out, and then the pad resumes and the lead enters:

{% highlight java %}
add1(gf(kickf,snaref,hihatf)); // percussion lead in
add1(gf(kickf,snaref,hihatf));
add1(gf(kickf,snaref,hihatf,bassf)); // bass enters
add1(gf(kickf,snaref,hihatf));
add1(gf(kickf,snaref,hihatf,bassf));
add1(gf(kickf,snaref,hihatf));
add1(gf(kickf,snaref,hihatf,bassf,padf)); // pad enters
add1(gf(kickf,snaref,hihatf));
add1(gf(kickf,snaref,hihatf,bassf));
add1(gf(kickf,snaref,hihatf));
add1(gf(kickf,snaref,hihatf,bassf)); // pad ends, and it's just perc+bass
add1(gf(kickf,snaref,hihatf));
add1(gf(kickf,snaref,hihatf,bassf));
add1(gf(kickf,snaref,hihatf));
add1(gf(kickf,snaref,hihatf,bassf,padf,leadf)); // now everything, including lead!
add1(gf(kickf,snaref,hihatf));
add1(gf(kickf,snaref,hihatf,bassf));
add1(gf(kickf,snaref,hihatf));
add1(gf(kickf,snaref,hihatf,bassf,padf));
add1(gf(kickf,snaref,hihatf));
add1(gf(kickf,snaref,hihatf,bassf));
add1(gf(kickf,snaref,hihatf));
{% endhighlight %}

Here's how it sounds (lead starts at about 0:33):

> <iframe width="500" height="166" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/227050962&amp;color=ff5500&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false&amp;show_artwork=false"></iframe>

Here is the complete code:

> [Groove.pde](https://github.com/ycpcs/fys100-fall2015/blob/gh-pages/examples/Groove.pde)
