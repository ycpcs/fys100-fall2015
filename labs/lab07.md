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

Yeah.

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
