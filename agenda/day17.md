---
layout: default
title: "Day 17 Agenda"
---

# Agenda

Day 17 is music presentations.  If you did not present your visual art project, then you will be presenting your music project.

## Get ready

<img class="parimg" alt="Get ready" src="img/getready.png">

**Extremely important**: I need to have your composition in a form that is ready to play before class starts.  Here are your options.

It is your responsibility to make sure that your composition is ready to play when your presentation starts.  I will be happy to assist you in getting things set up, but you need to see me *before* presentation day.

<div class="clear"></div>

### Option 1

Save your composition as a **WAV** file.  This is the best and most straightforward option.  Depending on which lab you used as the starting point for your program, you will see a line of code defining a variable called `fws`.  It will look like one of the following:

{% highlight java %}
FunWithSound fws = new FunWithSound(this); // first possibility

MyFWS fws = new MyFWS(this); // second possibility
{% endhighlight %}

If you see the first possibility, add the following code to your program, just above the line that defines `fws`:

{% highlight java %}
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
      player.setIdleWaitUs(2000000L);
      player.saveWaveFile(fileName);
    } catch (Exception e) {
      println("Couldn't save wave file: " + e.toString());
    }
  }
}
{% endhighlight %}

Then, change the line defining `fws` so that it looks like the second possibility shown above.

Next, find the `mouseClicked` method.  Change it so that it looks like this:

{% highlight java %}
void mouseClicked() {
  //fws.play(c);
  fws.saveWaveFile(c, "H:/mycomposition.wav");
}
{% endhighlight %}

You should change `H:/mycomposition.wav` to a filename that is appropriate for your composition, and if you are running on your computer rather than a lab computer, you will probably want to use a drive other than `H:`.

Once your program has the required code, run the program, and when you click in the window, the program will save a **WAV** file rather than playing using the speakers or headphones.  Just copy this file onto your flash drive, and you are set.

<div class="callout">
Don't forget to bring the flash drive with your <b>WAV</b> file to class with you!
</div>

### Option 2

Post your composition using [SoundCloud](https://soundcloud.com/).  To do this, save your composition as a **WAV** file (as described above), upload it to SoundCloud (you'll need an account), and then save the URL.

This is also an excellent option.  SoundCloud is a great way to share your music via the web.

If you choose this option, you don't need to bring anything to class with you.

### Option 3

Play your composition using Processing.

<div class="callout">
If you choose this option, you will need to
<ol>
<li>Email me your processing code <i>before class</i></li>
<li>Bring a flash drive that has all required soundfonts and samples on it</li>
<li>Verify (before class) that your program will run correctly if the soundfonts and samples are loaded from your flash drive</li>
</ol>
</div>
