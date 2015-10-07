---
layout: default
title: "Lab 8: Putting it together"
---

# Learning goals

* Explore techniques for creating repetition and variation in a composition

# What to do

Your task is to plan and create a structure for your overall composition.

A good goal for this lab is to create an outline for your composition, by expressing in words what you would like each segment of the composition to sound like.  Then, start filling in the details of each segment by adding rhythms, melodies, and figures.

Start by reading the *Composition techniques* section.  Then, you can take a look at the *Example* section, which describes a continuation of the example composition from [Lab 7](lab07.html).

## Composition techniques

> If it sounds good, it *is* good.<br><span style="margin-left: 20px;">&mdash; <i>Duke Ellington</i></span>

I think this quote is, in some sense, all there is to know about music and music composition.  There are no hard and fast rules.  If you create something that captures an emotion and conveys it to the listener, you have succeeded.

Nonetheless, we can identify some compositional techniques that can serve as a source of inspiration.

The basic elements of music composition are *repetition* and *variation*.

Once you come up with a melody that you like, repeat it for some number of measures.  Some forms of music are very repetitive &mdash; [house music](https://en.wikipedia.org/wiki/House_music), and other forms of [electronic dance music](https://en.wikipedia.org/wiki/Electronic_dance_music), for example.

Repetition should be balanced with variation.  Variation can happen at different scales.  At a "fine" scale, you can make modifications to some of your percussion or melody figures.  For example, make small changes to the rhythms, shift the melody up or down an octave, etc.  You can also create repeating patterns such as bass lines that alternate measures.  At a "coarse" scale, you can designate larger sections of your composition.  For example, many pop songs have song structure that alternates between verses and choruses.  Even if you don't follow a strict verse/chorus model, you may find it useful to return to previous themes.

Along these lines, you may find it useful to create an "outline" for your composition.  Think about what each segment of the composition should sound like, then steadily fill in the details for each section by adding figures.

## Example

This example continues the example from [Lab 7](lab07.html).  The example composition already had some structure:

* It started with just percussion
* Then the bass part entered
* Then the pad part entered
* Then the pad dropped out, leaving just the percussion and bass
* Then the pad rejoined, and the lead started

Having parts enter and drop out is an important compositional technique.  Personally, I think of composition in terms of ebb and flow: I want to gradually build up, then back off, then build back up.  Of course, this is certainly not the only way to think about composition.

At any rate, let's figure out how to pick back up where the composition left off, at the end of the lead part.  Since the lead was fairly over the top, my instinct is to back off, and start a quieter passage, with the goal of slowly rebuilding some tension, in order to build up to a second lead passage.

We'll start by creating a series of hihat patterns of (gradually) increasing complexity:

{% highlight java %}
Rhythm hihat2r = r(
  p(0,101), p(2,101), p(4,101), p(6,101)
);
Melody hihat2m = rm(an(42), 4);
Figure hihat2f = f(hihat2r, hihat2m, drumkit);

Rhythm hihat3r = r(
  p(0,101),
  p(1.5,101), p(2,101),
  p(3.5,101), p(4,101),
  p(5.5,101), p(6,101),
  s(6.5,1,101)
);
Melody hihat3m = m(
  an(42),
  an(44), an(42),
  an(44), an(42),
  an(44), an(42),
  an(46)
);
Figure hihat3f = f(hihat3r, hihat3m, drumkit);

Rhythm hihat4r = r(
  p(0,101), p(1,101), p(2,101), p(3,101),
  s(4,.5,101),
  p(4.5,101), s(5,.5,101), p(5.5,101),
  p(6.5,101), s(7,.5, 101), p(7.5,101));
Melody hihat4m = m(
  an(42), an(42), an(42), an(42),
  an(46),
  an(44), an(46), an(44),
  an(44), an(46), an(44)
);
Figure hihat4f = f(hihat4r, hihat4m, drumkit);
{% endhighlight %}

I've used some pedal hihat sounds in these patterns, and the TR-808 soundfont that we have been using for percussion sounds doesn't have a pedal hihat sound.  So, let's switch our percussion instrument to FluidR3:

{% highlight java %}
Instrument drumkit = percussion(FLUID);
{% endhighlight %}

As it turns out, the percussion sounds in FluidR3 are excellent, so I sort of wish I'd used it from the beginning.  Oh well.

Finally, let's create 12 measures with our new hihat patterns:

{% highlight java %}
add1(gf(hihat2f));
add1(gf(hihat2f));
add1(gf(hihat2f));
add1(gf(hihat2f));
add1(gf(hihat3f));
add1(gf(hihat3f));
add1(gf(hihat3f));
add1(gf(hihat3f));
add1(gf(hihat4f));
add1(gf(hihat4f));
add1(gf(hihat4f));
add1(gf(hihat4f));
{% endhighlight %}

Here's how it sounds:

> <iframe width="500" height="166" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/227340377&amp;color=ff5500&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false&amp;show_artwork=false"></iframe>

Next, let's add a second pad instrument to play a low drone part over the new hihat patterns:

{% highlight java %}
Instrument pad2 = instr(FLUID, 95); // Pad 7 (halo)
{% endhighlight %}

Here are rhythms and melodies for this instrument:

{% highlight java %}
Rhythm pad2r = r(
  s(0,4,127), s(4,.5,127), s(4.5,3.5,127),
  s(8,4,127), s(12,.5,127), s(12.5,3.5,127)
);
Melody pad2m = m(
  an(33),an(33),an(33),
  an(33),an(33),an(33)
);
Figure pad2f = f(pad2r, pad2m, pad2);

Rhythm pad3r = r(
  s(0,4,127), s(4,4,127), s(8,4,127),
  s(12,.5,127), s(12.5,.5,127), s(13,3,127)
);
Melody pad3m = m(
  an(45), an(36), an(45),
  an(48), an(50), an(52));
Figure pad3f = f(pad3r, pad3m, pad2);
{% endhighlight %}

Now, let's arrange to play these new pad figures over the new hihat figures, with `pad2f` being played for 4 measures, and `pad3f` for 8.  (Because each figure is 2 measures long, we only need to start them every other measure.)

{% highlight java %}
add1(gf(hihat2f,pad2f));
add1(gf(hihat2f));
add1(gf(hihat2f,pad2f));
add1(gf(hihat2f));
add1(gf(hihat3f,pad3f));
add1(gf(hihat3f));
add1(gf(hihat3f,pad3f));
add1(gf(hihat3f));
add1(gf(hihat4f,pad3f));
add1(gf(hihat4f));
add1(gf(hihat4f,pad3f));
add1(gf(hihat4f));
{% endhighlight %}

Here's what it sounds like:

> <iframe width="500" height="166" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/227340794&amp;color=ff5500&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false&amp;show_artwork=false"></iframe>

Now let's reintroduce the kick drum, but with a simpler <a href="https://en.wikipedia.org/wiki/Four_on_the_floor_(music)">four on the floor</a> rhythm:

{% highlight java %}
Rhythm kick2r = rr(p(0,127), 2, 4);
Figure kick2f = pf(kick2r, 36, drumkit);
{% endhighlight %}

And, let's throw in a new snare pattern (which actually has some hand claps in it, not just snare):

{% highlight java %}
Rhythm snare2r = r(p(2,127), p(5,127), p(6.5,127));
Melody snare2m = m(an(40), an(39), an(39));
Figure snare2f = f(snare2r, snare2m, drumkit);
{% endhighlight %}

We'll add 4 measures with the kick drum, and then 4 measures with both the kick and snare patterns:

{% highlight java %}
add1(gf(hihat4f,kick2f,pad3f));
add1(gf(hihat4f,kick2f));
add1(gf(hihat4f,kick2f,pad3f));
add1(gf(hihat4f,kick2f));

add1(gf(hihat4f,kick2f,snare2f,pad3f));
add1(gf(hihat4f,kick2f,snare2f));
add1(gf(hihat4f,kick2f,snare2f,pad3f));
add1(gf(hihat4f,kick2f,snare2f));
{% endhighlight %}

Here's what it sounds like:

> <iframe width="500" height="166" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/227341309&amp;color=ff5500&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false&amp;show_artwork=false"></iframe>

Now, let's start a second lead part.  It won't reproduce the original lead, but will perhaps echo it:

{% highlight java %}
Rhythm lead2r = r(
  s(0,2,99), s(2,6,106),
  s(7,1,90), s(8,1,106), s(9,7,101),
  s(16,2,77), s(18,5,106),
  s(23,1,76), s(24,1,65), s(25,7,79)
);
Melody lead2m = m(
  an(72), an(74),
  an(72), an(74), an(76),
  an(84), an(76),
  an(77), an(81), an(79));
Figure lead2f = f(lead2r, lead2m, lead);
{% endhighlight %}

Also, we'll add an [arpeggiated](https://en.wikipedia.org/wiki/Arpeggio) bass pattern, to join in after two measures of playing the second lead:

{% highlight java %}
Rhythm bass2r = r(
  s(0,1,110), s(1,1,102), s(2,1,85), s(3,.5,106), s(3.5,1,102), s(4.5,0.5,102), s(5,1,102), s(6,1,85), s(7,1,106),
  s(8,1,110), s(9,1,102), s(10,1,85), s(11,.5,106), s(11.5,1,102), s(12.5,0.5,102), s(13,1,102), s(14,1,85), s(15,1,106)
  );
Melody bass2m = m(
  an(55), an(57), an(67), an(57), an(67), an(65), an(64), an(55), an(57),
  an(55), an(57), an(67), an(57), an(67), an(65), an(64), an(55), an(57));
Figure bass2f = f(bass2r, bass2m, bass);
{% endhighlight %}

Here's how we add these to the composition:

{% highlight java %}
add1(gf(hihat4f,kick2f,snare2f,pad3f,lead2f));  // start second lead
add1(gf(hihat4f,kick2f,snare2f));
add1(gf(hihat4f,kick2f,snare2f,pad3f));
add1(gf(hihat4f,kick2f,snare2f));
add1(gf(hihat4f,kick2f,snare2f,pad3f,lead2f));
add1(gf(hihat4f,kick2f,snare2f));
add1(gf(hihat4f,kick2f,snare2f,pad3f));
add1(gf(hihat4f,kick2f,snare2f));
add1(gf(hihat4f,kick2f,snare2f,pad3f,lead2f,bass2f)); // start second bass pattern
add1(gf(hihat4f,kick2f,snare2f));
add1(gf(hihat4f,kick2f,snare2f,pad3f,bass2f));
add1(gf(hihat4f,kick2f,snare2f));
add1(gf(hihat4f,kick2f,snare2f,pad3f,lead2f,bass2f));
add1(gf(hihat4f,kick2f,snare2f));
add1(gf(hihat4f,kick2f,snare2f,pad3f,bass2f));
add1(gf(hihat4f,kick2f,snare2f));
add1(gf(hihat4f,kick2f,snare2f,pad3f,lead2f,bass2f));
add1(gf(hihat4f,kick2f,snare2f));
add1(gf(hihat4f,kick2f,snare2f,pad3f,bass2f));
add1(gf(hihat4f,kick2f,snare2f));
{% endhighlight %}

Finally, an <a href="https://en.wikipedia.org/wiki/Conclusion_(music)">outro</a>.  We'll end the lead and bass patterns, and go back to `pad2f` (the "droning" pad figure).  Then we'll let the hihats drop out, then the kick drums:

{% highlight java %}
add1(gf(hihat4f,kick2f,pad2f));
add1(gf(hihat4f,kick2f,pad2f));
add1(gf(hihat4f,kick2f,pad2f));
add1(gf(hihat4f,kick2f,pad2f));

add1(gf(kick2f,pad2f));
add1(gf(kick2f,pad2f));
add1(gf(kick2f,pad2f));
add1(gf(kick2f,pad2f));

add1(gf(pad2f));
add1(gf(pad2f));
add1(gf(pad2f));
add1(gf(pad2f));
{% endhighlight %}

Now to put it all together: here is the complete composition:

> <iframe width="500" height="166" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/227342021&amp;color=ff5500&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false&amp;show_artwork=false"></iframe>

Here's the completed source code:

> [Groove2.pde](https://github.com/ycpcs/fys100-fall2015/blob/gh-pages/examples/Groove2.pde)
