---
layout: default
title: "Lab 1: Art with Processing"
---

# Learning goals

* Learn the basic elements of a Processing program
* Learn how to run programs in the Processing environment
* Learn how to use Processing drawing functions to create images

# What to do

Your task is to use Processing to create a picture.

Start with the sketch you made on graph paper.  Note that the horizontal and vertical lines are marked with numbers: these will help you to determine the coordinates, widths, and heights to pass to the Processing drawing functions.

Note that in Processing, the origin (x=0, y=0) is in the upper left of the window, not the lower left.  Points closer to the bottom of the window have *larger* y coordinates, not smaller.

## An example

Here is an example image:

> <a href="../agenda/img/citylights.png"><img style="width: 200px; height: 150px;" alt="City Lights" src="../agenda/img/citylights.png"></a>

Here is the Processing program that generated the image:

> [CityLights.pde](https://github.com/ycpcs/fys100-fall2015/blob/gh-pages/examples/CityLights.pde)

Feel free to use this program as a guide.

## Getting started

Start Processing.  Add the following code:

{% highlight java %}
void setup() {
  background(200);
  size(800, 600);
}

void draw() {
  stroke(0);
  strokeWeight(5);
  fill(255);
  ellipse(400,300,400,400);
  fill(0);
  ellipse(325,225,25,60);
  ellipse(475,225,25,60);
  arc(400,350,150,70,0,PI,CHORD);
}
{% endhighlight %}

Click on the run button, which looks like this:

> ![Run button](img/runbutton.png)

When this program runs, you should see the following (click for larger image):

> <a href="img/smiley.png"><img style="width: 200px; height: 150px;" alt="Smiley face" src="img/smiley.png"></a>

Here is a quick explanation of the program.

The `setup` method executes when the program starts.  In the code above, `setup` sets the window size to 800x600, and sets the background color to 200, which is a light gray.

The `draw` function is called automatically by Processing in order to display an image in the program's window.  In the above program, there are calls to `stroke` and `strokeWeight` to set the line drawing color (black) and thickness, `fill` to set a fill color (white initially, then black), `ellipse` to draw circles and ellipses, and `arc` to draw an arc (part of a circle).

## Your task

Your task is to translate your graph paper sketch into Processing code.  By putting calls to the Processing drawing functions in your program's **draw** method, you can draw different kinds of shapes and lines.

The textbook and the [Processing Reference](https://processing.org/reference/) are good sources of information about what drawing functions are available, and how to use them.  Here is a quick guide to some useful functions.

stroke

strokeWeight

fill

