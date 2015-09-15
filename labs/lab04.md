---
layout: default
title: "Lab 4: Make it move!"
---

# Learning goals

* Animate elements of an image by varying their positions, sizes, and/or colors over time

# What to do

Your task is to animate one or more elements of your image.

This task will depend on having a method with x and/or y parameters that draws an element at a specified position: see [Lab 2](lab02.html).

The following example illustrates how to do this.

## The building has landed

The example image from [Lab 2](lab02.html) seems like a peaceful city scene (click for full size):

> <a href="img/citylights-morebuildings.png"><img style="width: 200px; height: 150px;" src="img/citylights-morebuildings.png"></a>

You may not have realized that there is a backstory: one of the buildings is not a building at all.  It's actually an alien spaceship! Click the link below to see the animation:

> [Building animation](code/building.html)

## Animation basics

The basic principle of animation is very straightforward: the program should draw a series of slightly different images, with small delay between each image.  If the delay between images is small, our eyes will perceive the changes between images as motion.

Processing is designed for animation: by default, your program's `draw` method is called 10 times per second.  So, if each time `draw` executes it draws a slightly different scene, we have animation!  We will refer to the slightly different images drawn by the `draw` method as the program executes as *frames*.

To animate a single element of the image, as we did in the building animation, all we need to do is draw the element in a different position in each frame.  The perceived motion of the element will depend on how the element's position is changing.  In the building example, we wanted the building to move from the top of the scene towards the bottom.  So, we need to make the moving building's y coordinate increase.

Doing this is simple: we can add a *global variable* to the program to keep track of where the moving building should be displayed.  Our global variable will look like this:

{% highlight java %}
int spaceshipY = -140;
{% endhighlight %}

It is a global variable as long as we define it outside any of the program's methods.  Global variables are "visible" to *all* of the methods in the program, so they can be referred to in any method.  Note that for this global variable, we have defined it as an `int` (integer), and given it an initial value (-140).

To implement the animation, we just need to make two small changes to the program.  First, in the `drawBuildings` method, we will change the line of code that calls the `drawBuildingOne` method to draw the animated building.  This is the original line of code:

{% highlight java %}
drawBuildingOne(120,400);  // use x=120,y=400 for this copy
{% endhighlight %}

We will change it as follows:

{% highlight java %}
drawBuildingOne(120,buildingY);  // this is the moving building!
{% endhighlight %}

Note that rather than drawing the building at a fixed y coordinate, we specify its y coordinate as whatever the current value of the `buildingY` variable is.

The last change we need to make is that the value of `buildingY` needs to be updated for each frame of the animation.  This is easily accomplished by adding some code to the beginning of the `drawBuildings` method, which is executed once per frame (because it is called by the `draw` method).  We will add the following code to the top of the method:

{% highlight java %}
if (buildingY < 400) {
  buildingY++;
}
{% endhighlight %}

This code uses an `if` construct to check whether `buildingY` is less than 400.  If it is, then it increases the value of `buildingY` by 1.  (That is what the `++` does.)  The purpose of the `if` construct is to make the building stop moving when `buildingY` reaches 400.  If we didn't do this, the building would keep moving down indefinitely, and eventually move past the bottom of the scene.

Here is the complete code: [CityLightsAnimation.pde](https://github.com/ycpcs/fys100-fall2015/blob/gh-pages/labs/code/CityLightsAnimation.pde)
