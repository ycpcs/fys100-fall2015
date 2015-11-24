---
layout: default
title: "Lab 14: Outbreak"
---

# Learning goals

* Explore simulation as a way of modeling and understanding natural phenomena

# What to do

A *simulation* is a program which simulates a natural phenomenon.  The idea is that the program uses a *model* of the phenomenon being studied, such that the model is a representation of particular aspects of the phenomenon being studied.  For example, in a weather simulation, the model might use representations of temperature, air pressure, humidity, and cloud cover over a field of simulated locations.  A simulation's model will also contain rules about how the simulation evolves over time.  For example, in a weather simulation, one of the rules might be that if two adjacent locations, if the air pressure is different, wind occurs to equalize the pressure (because air moves from regions with higher pressure to regions with lower pressure).

A simulation's model will also typically have *parameters*, which are values influencing how the model's rules are applied over time.  These parameters often come from known physical constants, in which case we set the parameters in order to match physical reality.  However, in some cases, changing the parameters may allow us to understand a broad class of phenomena: different combinations of parameters correspond to different "scenarios".

In this lab, we will experiment with the parameters of an "Outbreak" simulation, in order to learn about how factors in disease transmission affect a population of individuals.  See the *Outbreak* and *Experiments* sections for details about the simulation, and the experiments we will run.

## Outbreak

In this lab, we will experiment with parameters for a simulation of disease transmission in a population of inviduals.  Here is the code (which you should copy into Processing):

> [Outbreak.pde](https://github.com/ycpcs/fys100-fall2015/blob/gh-pages/examples/Outbreak.pde)

The initial conditions of the simulation are as follows:

* There is a population of individuals occupying a 600x600 area
* The initial locations of the individuals are distributed randomly
* Each individual has some probability of being sick initially, so the initial population is a mixture of healthy and sick individuals
* Each individual is either healthy or sick

At each time step of the simulation:

* Each individual will move: randomly if there are no sick individuals nearby, and as far as possible from sick individuals if there are some nearby
* With some probability, a healthy individual that is in proximity to a sick individual will become sick
* With some probability, a healthy individual that is *not* in proximity to a sick individual will become sick
* With some probability, a sick individual will recover and become healthy

When you run the program, it will display an animation showing the progress of the simulation.  There will be about 10 simulated time steps per second.  The simulation looks like this (click for full size):

> <a href="img/outbreak.png"><img style="width: 303px;" alt="Outbreak screenshot" src="img/outbreak.png"></a>

Black dots are healthy individuals, red dots are sick individuals.  The pink circles around sick individuals represent the radius in which disease transmission can occur.  The overall percentage of sick individuals is also displayed.

At the top of the program, you will notice definitions of the following simulation parameters:

> Parameter name | Description
> -------------- | -----------
> `MAXCROWD` | Individuals will always try to stay at least this distance from other individuals
> `PARANOIA` | If any sick individuals are this close (or closer), try to move away from them
> `NORMAL_MOVE_DIST` | How far individuals move normally, when they are not trying to get away from sick individuals
> `ESCAPE_MOVE_DIST` | How far individuals move when they are trying to escape from sick individuals
> `NUM_MOVES` | How many randomly-generated moves each individual will consider per time step
> `INIT_SICK` | Probability that an individual is sick initially
> `RECOVERY` | Probability per time step that a sick individual will spontaneously recover
> `SPONTANEOUS_INFECT` | Probability per time step that a healthy individual will spontaneously become sick
> `INFECT_RADIUS` | Radius surrounding a sick individual where transmission to a healthy individal may occur
> `INFECT` | Probability per time step of a healthy individual being infected by a sick individual that is close proximity

## Experiments

More stuff.
