---
layout: default
title: "Lab 5: Weird Sounds"
---

# Learning goals

* Experiment with basic waveforms
* Experiment with audio effects
* TODO: other stuff

# What to do

First, read the *What is sound?* section.

Next, do the experiments in the *Experiments* section.

## What is sound?

<div class="callout"><b>Important</b>: Before you try playing any of the sound samples below, adjust the system volume control on the computer you are using so that it is on a low setting.</div>

Sound is caused by rapid vibrations, or *oscillations*, in physical objects.  These oscillations cause rapid changes in air pressure over time.

Sounds can be characterized by the *rate* at which the changes in air pressure occur.  For example, let's say that a vibration causes air pressure to increase and decrease at a rate of 440 changes per second: in other words, 440 times per second, the air pressure increases and then decreases.  We would describe this sound as having a *frequency* of 440 Hertz, abbreviated 440 Hz.

Sounds with lower frequencies sound "low", and sounds with higher frequencies sound "high".  The lowest frequency that we can hear is about 20 Hz, while the highest frequency we can hear is about 20,000 Hz.

The most fundamental kind of oscillation is the *sine wave*:

> ![Sine wave](img/sinewave.png)

The diagram above is a plot of air pressure over time, where the x-axis is time, and the y-axis is pressure.

Sine waves tend to occur naturally due to the way physical objects vibrate.  A pure sine wave represents a single clear tone.  For example, here is a sample of a 440 Hz sine wave:

> <iframe width="500" height="166" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/225567736&amp;color=ff5500&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false&amp;show_artwork=false"></iframe>

A sound consisting of a single sine wave tends to sound very artificial because sounds arising from the vibration of physical objects tend to have *overtones*, which are vibrations occuring at a multiple of the sound's base frequency.  For example, when an instrument string vibrates, the length of the string will determine the base frequency, but overtones will occur which are twice the base frequency, three times the base frequency, four times the base frequency, etc.

Here is a sample of a 440 Hz sine wave, along with some overtones:

> <iframe width="500" height="166" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/225569272&amp;color=ff5500&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false&amp;show_artwork=false"></iframe>

Note that in the audio sample above, the relative volume of the overtone frequencies has been lowered relative to the volume of the base frequency.

It turns out that *any* sound imaginable can be created by combining sine waves.  All of the sounds that you hear are combinations of sine waves with varying frequencies and volumes.

## Electronic waveforms

Electronic instruments, such as synthesizers and computers with sound output hardware, are not limited to creating pure sine waves.  In fact, it tends to be easier for digital devices to generate "artificial" sound waveforms.  Here are some examples of commonly-used electronic waveforms.

A square wave is characterized by abrupt transitions from low to high pressure:

> ![Square wave](img/squarewave.png) 

Here is a sample of a 440 Hz square wave:

> <iframe width="500" height="166" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/225567893&amp;color=ff5500&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false&amp;show_artwork=false"></iframe>

A square wave has e a more complex sound than a sine wave of the same frequency.  The shape of the waveform results in [higher frequency overtones at odd multiples of the base frequency](http://www.embedded.com/print/4015870).

Another common electronic waveform is the sawtooth wave, characterized by a linear rise and an abrupt fall in pressure during each oscillation:

> ![Sawtooth wave](img/sawtoothwave.png)

Here is a sample of a 440 Hz sawtooth wave:

> <iframe width="500" height="166" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/225567809&amp;color=ff5500&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false&amp;show_artwork=false"></iframe>

Again, the sawtooth wave has a more complex sound than a sine wave of the same frequency.

A triangle wave is like a sawtooth wave, except rather than having an abrupt fall, the fall is pressure linear:

> ![Triangle wave](img/trianglewave.png)

Here is a sample of a 440 Hz triangle wave:

> <iframe width="500" height="166" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/225567949&amp;color=ff5500&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false&amp;show_artwork=false"></iframe>

The sound of a triangle wave is similar to a square wave.

## Experiments

<div class="callout"><b>Important</b>: Before you try creating sounds with the processing sketch, adjust the system volume control on the computer you are using so that it is on a low setting.</div>

Your task is to experiment with playing notes using basic waveforms.

The first thing you will need to do is install the [FunWithSound](https://github.com/daveho/FunWithSound) Processing library.  The steps will be similar to what you did to install the [Terrapin](http://terrapin.sourceforge.net/) library in [Lab 3](lab03.html).  Here is what you should do:

* In Processing, choose **File&rarr;Preferences**, and verify that your sketchbook folder is set to whichever folder you are using to save your Processing programs; if it is not set correctly, change it
* Download [FunWithSound.zip](https://github.com/daveho/FunWithSound/releases/download/v1.0.4/FunWithSound.zip) and save it somewhere (such as your Downloads folder)
* Open a file browser window, navigate into the folder where you saved FunWithSound.zip
* Right-click on FunWithSound.zip, and choose **Extract All**
* Change the target directory to the **libraries** folder within your sketchbook directory (again, whichever folder you configured in your Preferences)
* Choose **Extract**
* Quit Processing and then restart it

When you restart Processing, and choose **Sketch&rarr;Import Library...**, you should see **FunWithSound** listed as one of the options.

Once the FunWithSound library is installed, copy and paste all of the code from [WeirdSounds.pde](https://github.com/ycpcs/fys100-fall2015/blob/gh-pages/examples/WeirdSounds.pde) into the Processing editor.  Run the sketch by pressing the play button.  You should see the following window:

> ![WeirdSounds screenshot](img/weirdsounds.png)

If you click the mouse somewhere in the window, you should hear a repeated tapping sound.  This is a very basic rhythm pattern (you will experiment with rhythms in [Lab 6](lab06.html).)  The tapping sound will end in a short time.  You can click in the window again to restart it.

While the rhythm pattern is playing, you can use the following keyboard keys to play notes:

> ![Keyboard keys to play notes](https://raw.githubusercontent.com/wiki/daveho/FunWithSound/img/p5keys.png)

Note that you can only play notes from one octave: the current octave is highlighted in green in the picture of the piano keyboard you see in the window.  You can use the up and down arrow keys to move the current octave higher or lower.

Now you can try some experiments!  If you scroll down to the bottom of the Processing code, you will see a method called `registerCustomInstruments`.  This method configures FunWithSound to play notes using the basic waveforms described earlier.  You will see comments labeled "Custom instrument 0", "Custom instrument 1", "Custom instrument 2", etc.  Some of the experiments will involve changing these instrument definitions to produce different sounds.  Also, note how there are comments such as

{% highlight java %}
// <-- try Buffer.SQUARE, Buffer.SAW, Buffer.TRIANGLE
{% endhighlight %}

on some lines of code.  These comments highlight changes you can make to change the note sounds.

Note: if you change the code, you will need to restart sketch in order for your changes to take effect.

### Experiment 1: Basic synth sounds

Find the section of `registerCustomInstruments` that defines custom instrument 0.  Note how the code uses `Buffer.SINE`.  This causes notes to be played as a sine wave.  Try changing this as described in the comment to use square, sawtooth, and triangle waves.  Which waveform is your favorite?

### Experiment 2: Using a note envelope

One thing that you will notice about custom instrument 0 is that the note sounds turn on and off very abruptly.  Rapid changes in volume tend to produce a clicking or popping sound.  These pops can be avoided by playing the notes with an *envelope*.  When a note envelope is used, notes start playing with a rise in volume over a specified *attack time*, and stop playing with a lowering of volume over a specified *release time*.

At the top of the program, change the line

{% highlight java %}
Instrument synth = custom(0); // <-- change this to select among the custom instruments
{% endhighlight %}

to

{% highlight java %}
Instrument synth = custom(1); // <-- change this to select among the custom instruments
{% endhighlight %}

Try restarting the program and playing some notes.  Note how the notes sound more natural.

In the section of `registerCustomInstruments` that defines custom instrument 1, you can adjust the attack time and release time parameters to change the note envelope.  These times are specified in milliseconds: for example, 100 milliseconds is one tenth of one second.

### Experiment 3: Portamento

*Portamento* describes the effect of "gliding" from note to note by changing the sound frequency somewhat gradually.  Using custom instrument 1, try changing the glide time parameter to a value other than 0.  The glide time is specified in milliseconds.  Suggestion: try values such as 40, 80, 100, and 200.

### Experiment 4: Overtones

TODO
