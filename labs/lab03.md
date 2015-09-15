---
layout: default
title: "Lab 3: Turtles and Fractals"
---

> *Big fleas have little fleas,*<br>*Upon their backs to bite 'em,*<br>*And little fleas have lesser fleas,*<br>*and so, ad infinitum.*

# Learning goals

* Use turtle graphics and Processing drawing functions to generate images from simple rules
* Appreciate how self-similarity at varying scales leads to "natural"-looking images
* Understand how to use a recursive method to generate a fractal image

# Getting started

To run the example programs in this lab, you will need to add the [Terrapin](http://terrapin.sourceforge.net/) library to your Processing sketchbook.  Here is how to do this on Windows (for example, in KEC 123):

* In Processing, choose **File&rarr;Preferences**, and set your sketchbook folder to whichever folder you are using to save your Processing programs
* In your Processing sketchbook folder (the one you configured in Preferences), create a folder called **libraries** (if it doesn't already exist), and then within **libraries**, create a folder called **Terrapin**
* Download [Terrapin.zip](../media/Terrapin.zip) and save it somewhere (such as your Downloads folder)
* Open a file browser window, navigate into the folder where you saved Terrapin.zip
* Right-click on Terrapin.zip, and choose **Extract All**
* Change the target directory to the **libraries/Terrapin** folder within your sketchbook directory (which is most likely the **sketchbook** directory in your H: drive)
* Choose **Extract**

Start (or restart) Processing.  Choose **Sketch** &rarr; **Import library...** &rarr; **Terrapin**.  You should see the code

{% highlight java %}
import terrapin.*;
{% endhighlight %}

in the text editor.  This line lets Processing know that you will be using the Terrapin library in your program.

# What to do

Your task is to use turtle graphics and Processing drawing functions to draw cool-looking images, and in particular, fractal images.  The general idea is that the program should use a procedure based on simple rules to create the image.

That's really the only task!  Just mess around and see if you can create some interesting images by modifying and extending some of the examples shown below.  Don't forget to save your favorite programs in your Processing sketchbook folder.

## Turtles

[Turtle graphics](https://en.wikipedia.org/wiki/Turtle_graphics) were invented as part of the [Logo](https://en.wikipedia.org/wiki/Logo_(programming_language) programming language.

The basic idea is that your program controls one or more "turtles".  Each turtle has a position (x and y coordinates), and an orientation (the angle specifying which way the turtle is facing.)  The program can give commands to the turtle: the most important commands are to instruct the turtle to move forward by a specified distance, and to rotate left or right.

Each turtle has a "pen".  The pen can be up or down.  If a turtle moves forward, and if the turtle's pen is down, then the turtle draws a line from its original position to its new position.  The color of the pen can be modified, allowing line segments to be drawn in a variety of colors.

## First example: spiral

Here is a simple example:

{% highlight java %}
import terrapin.*;

void setup() {
  size(800,600);
  background(235);
  noLoop();
}

void draw() {
  Terrapin t = new Terrapin(this);
  t.setLocation(400,300);
  
  t.setPenColor(15,40,199);
  
  for (int i = 0; i < 500; i++) { // repeat 500 times
    t.forward(i);
    t.left(44);
  }
}
{% endhighlight %}

This example produces the following output (click for full size):

> <a href="img/spiral.png"><img style="width: 200px; height: 150px;" alt="Spiral" src="img/spiral.png"></a>

So, what is going on here?

* The `setup` method sets the window size and background color, and uses `noLoop` so that the `draw` method is only executed once (this produces better image quality when the image consists of lines)
* The `draw` method creates a Terrapin (turtle), sets its location to 400,300 (at the center of the window), and sets its pen color to a shade of blue
* The for loop repeats, for values of the variable `i` from 0 to 499: move forward `i` pixels of distance, and then turn left 44 degrees

Try modifying this program.  What happens if you change the amount by which the turtle moves forward at each step?  (Try `i*2` instead of `i`.)  What happens if you change the turn angle to make it larger or smaller?  What happens if you use the `right` command instead of `left`?

## Second example: a fractal tree

Here is an example of a fractal:

{% highlight java %}
import terrapin.*;

float startLen = 150;
float decay = .75;
int angle = 35;

void setup() {
  size(800, 600);
  background(235);
  noLoop();
}

void draw() {
  Terrapin t = new Terrapin(this);
  t.setLocation(400,600);
  t.setRotation(270);
  t.setPenColor(0,89,14);
  
  drawTree(t, startLen);
}

void drawTree(Terrapin t, float dist) {
  if (dist > 5) {
    strokeWeight(4 * (dist/startLen));
    
    t.forward((int)dist);
    
    Terrapin copy = new Terrapin(t);
    
    t.left(angle);
    copy.right(angle);
    
    drawTree(t, dist * decay);
    drawTree(copy, dist * decay);
  }
}
{% endhighlight %}

This produces the following image (click for full size):

> <a href="img/fractaltree.png"><img style="width: 200px; height: 150px;" alt="Fractal Tree" src="img/fractaltree.png"></a>

Let's analyze this program.

At the top of the program, we define some _global variables_.  These are variables that are visible throughout the program.  The `startLen` variable defines the length of the first tree segment.  The `decay` variable controls how rapidly the length of the tree segments decreases as more segments are added.  The `angle` variable controls the angle of the "branches".

The `setup` method is the same as the previous program: it just sets the window size, background color, and calls `noLoop` to specify that the `draw` method should only be executed once.

The `draw` method creates an initial Terrapin (turtle), positions it at the bottom of the window, and orients it so that it is pointing straight up.  It also sets the drawing color to a shade of green.  Finally, it calls the `drawTree` method with the initial Terrapin and initial segment length as parameters.

The `drawTree` method is where the interesting stuff happens.  The `if` construct checks to see if the `dist` parameter is greater than 5: if not, then the method does nothing.  If `dist` is greater than 5, then the method moves the Terrapin `t` forward by `dist` number of pixels.  (Note that it is necessary to convert `dist` to an integer value.)  Next it creates a copy of the Terrapin `t`, called `copy`.  Both Terrapins (`t` and `copy`) are rotated by `angle` number of degrees, but in opposite directions.  Finally, the `drawTree` method is called with Terrapins `t` and `copy`, and with the `dist` parameter set to `dist * decay`.  (Since `decay` is a value less than 1, this causes `dist * decay` to be a smaller value than `dist`.)

Wait...what?

The `drawTree` method uses a technique called _recursion_.  The idea is that to draw a tree, we use a single turtle to draw an initial segment, and then "split" into two separate turtles, each oriented at a different angle, and then use these two turtles to draw *slightly smaller trees*.  In other words: a tree is a segment (you can think of this as the trunk, or a branch) that splits into two smaller trees.  However, these smaller trees _are formed in exactly the same way as the overall tree_.  Since the `drawTree` method draws a tree (whose size is based on the value of the `dist` parameter), it makes sense for the `drawTree` method to _call itself_ to draw the smaller trees.

In programming, recursion only works if it "bottoms out" at some point.  That is the purpose of the `if` construct: once the segment length (`dist`) falls below a specified minimum threshold, the process stops.  You can think of this as occurring at the "leaves" of the tree.  Without the `if` construct, the recursion would never "finish".

Try experimenting with this program.  What happens if you change the values of the `startLen`, `decay`, and/or `angle` variables?  What happens if you use a minimum segment length threshold other than 5?  Could you make the angle vary?  Could you introduce some randomness?

## Third example: squares

Fractals can be created by simple rules.  For example, let's say we want to create a fractal image in a square area.  Here are some possible rules

1. Draw a square in the upper-left quadrant
2. Recursively draw fractals in the lower-left, upper-right, and lower-right quadrants of the area

As with the fractal tree, we need to ensure that the procedure eventually "bottoms out".  So, if the width of the area in which a recursive fractal is drawn fall below a minimum threshold, we do nothing.

Here is the code:

{% highlight java %}
void setup() {
  size(800,600);
  background(235);
  noLoop();
}

void draw() {
  stroke(45,5,60);
  drawSquares(110,10,580,580);
}

// The parameters describe a square area with upper-left
// corner at x,y, width w, and height h
void drawSquares(float x, float y, float w, float h) {
  if (w > 2) {
    // Draw square in upper-left quadrant
    strokeWeight(3 * (w/580));
    rect(x, y, w/2, h/2);
    
    // Recursive fractals in the lower-left, upper-right,
    // and lower-right quadrants
    drawSquares(x, y + h/2, w/2, h/2);
    drawSquares(x + w/2, y, w/2, h/2);
    drawSquares(x + w/2, y + h/2, w/2, h/2);
  }
}
{% endhighlight %}

Note that this code does not use turtles, but instead uses normal Processing drawing functions.

Here is the image produced (click for full size):

> <a href="img/squares.png"><img style="width: 200px; height: 150px;" alt="Fractal squares" src="img/squares.png"></a>

Try modifying this program.  What happens if you comment out one of the recursive calls to `drawSquares`?  What happens if you change the stroke color before each recursive call?  What happens if you draw a different shape instead of a square?  What happens if you fill the squares with a solid color?  Could you create a similar fractal using a different shape, such as a triangle or rectangle?

I messed around a bit and came up with this variation (click for full size):

> <a href="img/squares-colors.png"><img style="width: 200px; height: 150px;" alt="Colorful fractal squares" src="img/squares-colors.png"></a>

## Fourth example: Virtual Mondrian

You've probably seen pictures of some of [Piet Mondrian](https://en.wikipedia.org/wiki/Piet_Mondrian)'s iconic tableau paintings:

> <a href="https://upload.wikimedia.org/wikipedia/commons/thumb/3/36/Tableau_I%2C_by_Piet_Mondriaan.jpg/800px-Tableau_I%2C_by_Piet_Mondriaan.jpg"><img alt="Tableau I" style="width: 200px;" src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/36/Tableau_I%2C_by_Piet_Mondriaan.jpg/800px-Tableau_I%2C_by_Piet_Mondriaan.jpg"></a>
>
> <span style="font-size: 80%;">"<a href="https://commons.wikimedia.org/wiki/File:Tableau_I,_by_Piet_Mondriaan.jpg#/media/File:Tableau_I,_by_Piet_Mondriaan.jpg">Tableau I, by Piet Mondriaan</a>" by <a href="//en.wikipedia.org/wiki/Piet_Mondrian" class="extiw" title="en:Piet Mondrian">Piet Mondrian</a> - <a rel="nofollow" class="external text" href="http://www.gemeentemuseum.nl/collection/item/6713">Gemeentemuseum Den Haag</a>. Licensed under Public Domain via <a href="https://commons.wikimedia.org/wiki/">Commons</a>.</span>

Is it possible that these paintings are fractals?  Here's an idea on how we might generate similar images.

1. Start with a square area.
2. Divide the area horizontally or vertically with a thick line.  The position of the divide is chosen randomly.
3. Recursively generate a Mondrian image on each side of the line, changing the direction of the split (i.e., switching from horizontal to vertical or vertical to horizontal).
4. As a way to "bottom out", if the size of the area is below a threshold, then stop.  With some non-zero probability, color these undivided areas red, yellow, or blue, or leave them light gray (the background color).

Here's the complete program:

{% highlight java %}
int WIDTH=600;
int HEIGHT=600;
int MIN=320;
int X = 5;
int LINEWIDTH = 16;
float COLOR_PCT = 33.0;

color RED = color(212, 41, 23);
color YELLOW = color(245, 202, 97);
color BLUE = color(26, 25, 153);

int saveCount = 1;

void setup() {
  size(600, 600);
  generate();
}

void generate() {
  background(233);
  doit(0, 0, WIDTH, HEIGHT, 0);
}

void doit(int left, int top, int right, int bottom, int dir) {
  if (dir == 0) {
    // vertical split
    // +-------+-------+
    // |       |       |
    // |       |       |
    // |       |       |
    // +-------+-------+
    int remain = right-left;
    if (remain >= MIN) {
      int split = left + makeSplit(remain);
      doit(left, top, split, bottom, 1);
      doit(split, top, right, bottom, 1);
      stroke(0);
      strokeWeight(LINEWIDTH);
      line(split, top, split, bottom);
    } else {
      noStroke();
      paintRect(left, top, right, bottom);
    }
  } else {
    // horizontal split
    // +---------------+
    // |               |
    // +---------------+
    // |               |
    // +---------------+
    int remain = bottom-top;
    if (remain >= MIN) {
      int split = top + makeSplit(remain);
      doit(left, top, right, split, 0);
      doit(left, split, right, bottom, 0);
      stroke(0);
      strokeWeight(LINEWIDTH);
      line(left, split, right, split);
    } else {
      noStroke();
      paintRect(left, top, right, bottom);
    }
  }
}

int makeSplit(int n) {
  float x = float(n)/X;
  return int(random(x, (X-1)*x));
}

void paintRect(int left, int top, int right, int bottom) {
  float toss = random(0, 100);
  if (toss >= COLOR_PCT) {
    return;
  }
  int flip = int(random(0,3));
  if (flip == 0) {
    fill(RED);
  } else if (flip == 1) {
    fill(YELLOW);
  } else if (flip == 2) {
    fill(BLUE);
  }
  rect(left, top, right-left, bottom-top);
}

void draw() {
}

void mousePressed() {
  generate();
}
{% endhighlight %}

Here is an example output (click for full size):

> <a href="img/virtual-mondrian.png"><img style="width: 150px; height: 150px;" alt="Virtual Mondrian" src="img/virtual-mondrian.png"></a>

Note that the program will generate a new image each time you click the mouse in the window.

You can also try out a [web version of this program](http://daveho.github.io/mondrian/).

Try experimenting with the program.  For example, you can change the values of some of the global variables.  You could also use different fill colors.
