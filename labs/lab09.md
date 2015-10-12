---
layout: default
title: "Lab 9: Computer Variations"
---

# Learning goals

* Experiment with random rhythms and melodies

# What to do

The only task in this lab is to experiment with randomly-created rhythms and melodies.

Start by creating a new Processing sketch and copying the code from the following program:

> [RandomMusic.pde](https://github.com/ycpcs/fys100-fall2015/blob/gh-pages/examples/RandomMusic.pde)

The *Random music* section below explains what this program is doing.

Here are some things you can change:

* the start intervals and probabilities used to generate the random rhythms
* the melodic instrument patches and the percussion instrument sounds
* the order and combination of the figures played

You can also add some new figures.

See what you can come up with!

## Random music

As we've seen in the previous labs, music can be reduced to patterns: start beats, durations, and note numbers.  There is no reason why these patterns can't be created by a program rather than a person.  Music created by a program can be considered *generative art* in the same sense as [fractals](lab03.html) in visual art.

There are essentially an infinite number of ways we could generate music.  Here is the very simple approach we will use in this lab:

* We will generate random melodic figures and random percussion figures
* A random melodic figure consists of a random rhythm and a random melody
* A random percussion figure consists of a random rhythm and a melody consisting of repeated instances of the same percussion sound (e.g., a hihat or a snare)

### Random rhythms

Random rhythms are specified by specifiying a series of note start intervals and probabilities.  A note start interval is one of the following numbers: 8, 4, 2, 1, .5, .25, .125.  Think of these as representing a whole note, half note, quarter note, eighth note, etc.  Associated with each note start interval is a probability, which is a number from 0 to 1, 0 meaning "impossible", .5 meaning "a 50/50 chance", 1 meaning "absolutely certain", etc.

For example, here is one possible series of start intervals and probabilities:

{% highlight java %}
double[][] slowProb = {
  { 4, 0.8 },   // 80% chance of creating a half note
  { 2, 0.3 },   // 30% chance of creating a quarter note
};
{% endhighlight %}

In the example above, half notes (4) occur with .8 (80%) probability, and quarter notes (2) occur with .3 (30%) probability.

### Random melodies

A random melody is created by choosing notes from the composition's scale.  For each note in the melody, a random number from 0 to 6 is generated: these correspond to the numbers of the 7 notes in the root octave of the scale.  Usually, this note will be directly added to the melody.  However, with some probability, the note's octave may be moved up or down.

### Random melodic figures

The `randomMelodicFigure` method creates a random melodic figure.  For example:

{% highlight java %}
Figure slow1f = randomMelodicFigure(slowProb, true, .2, 8, celesta);
{% endhighlight %}

In the example above, a random melodic figure is created which

* uses `slowProb` as the start intervals and probabilities to create a random rhythm
* allows notes in the generated rhythm to overlap
* has a .2 (20%) chance of moving any note to a higher or lower octave
* is 8 measures long
* uses `celesta` as the instrument

Here is what `slow1f` sounds like on one run of the program:

> <iframe width="600" height="166" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/228099981&amp;color=ff5500&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false"></iframe>

Let's create a second random melodic figure, and then use the `gf` command to combine them so they play at the same time:

{% highlight java %}
Figure slow2f = randomMelodicFigure(slowProb, true, .2, 8, marimba);
Figure slowf = gf(slow1f, slow2f);
{% endhighlight %}

Here's what `slowf` sounds like (which is `slow1f` and `slow2f` playing at the same time):

> <iframe width="600" height="166" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/228100558&amp;color=ff5500&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false"></iframe>

### Random percussion figures

The `randomPercussionFigure` method creates a random percussion figure.  For example:

{% highlight java %}
double[][] hihatProb = {
  { 1, .6, },   // 60% chance of creating an eighth note
  { .5, .4 },   // 40% chance of creating a sixteenth note
  { .25, .1 },  // 10% chance of creating a thirty-second note
};
Figure hihatf = randomPercussionFigure(hihatProb, 2, drumkit, 42);
{% endhighlight %}

In the example above, a percussion figure is created which

* uses `hihatProb` to specify the random rhythm
* is 2 measures long
* uses `drumkit` as the instrument
* uses 42 (closed hihat) as the percussion sound

Note that the random percussion figures will have only a single percussion sound.

Here's what this figure sounds like:

> <iframe width="600" height="166" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/228101617&amp;color=ff5500&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false"></iframe>

### Putting it together

We can assemble a "composition" out of random figures in much the same way that we would assemble a composition out of figures created from scratch.  Here's a complete "composition":

> <iframe width="600" height="166" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/228102334&amp;color=ff5500&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false"></iframe>

### Controlling the randomness

You will notice that the example composition sounds the same every time you play it.  To get a different random composition, change the following line in the `mouseClicked` method:

{% highlight java %}
randomSeed(123); // <-- change this to get a different "random" composition
{% endhighlight %}

Try specifying different numbers (other than 123): this will change the sequence of random numbers generated by the program, leading to different random rhythms and melodies.
