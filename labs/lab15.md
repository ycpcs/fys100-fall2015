---
layout: default
title: "Lab 15: Light Sensor"
---

# Learning goals

* Learn about embedded systems and possible uses for them
* Experiment with sensors and actuators to control and monitor the environment

# What to do

In this lab we will experiment with writing programs for the Arduino, an embedded controller.

First, read the *Embedded controllers* and *Arduino* sections.  Then read the *Hardware setup* and *Software setup* sections to find out how to get started with the Arduino development software and the [SparkFun RedBoard](https://www.sparkfun.com/products/12757) hardware.  Finally, read *Color sensor* for an explanation of the task you will work on.

## Embedded controllers

An *embedded controller* is a computer that is meant to be "embedded" in a larger device or system.  Unlike "standalone" computing devices such as PCs, laptops, tablets, and smartphones, where the software exists to serve the needs of a human user, software for embedded systems operates automonously.

There are a *huge* number of applications for embedded controllers.  In fact, you probably use devices with embedded controllers every day.

A typical embedded controller uses *sensors* to monitor the physical environment and *actuators* to control the physical environment.  For example, an embedded controller in a coffeemaker could use a temperature sensor to keep track of the current water temperature, and activate/deactivate a heating element to keep the temperature at an optmimum temperature for brewing coffee.

Most embedded controllers are not as powerful as a traditional computer.  This is because for many applications, the controller has a relatively simple task to perform, and a small amount of processing power is sufficient.

## Arduino

The [Arduino](https://www.arduino.cc/) is a very popular family of embedded controllers.  The [Arduino IDE](https://www.arduino.cc/en/Main/Software) is the software development environment, allowing you to write programs for Arduino controllers and upload them to the controller hardware.  The Arduino IDE is based on Processing, so it should seem quite familiar.  In fact, the way that programs are written for the Arduino is quite similar to Processing, as we will see.

The particular variation of Arduino we will be using is the [SparkFun RedBoard](https://www.sparkfun.com/products/12757), which is a clone of the [Arduino UNO](https://www.arduino.cc/en/Main/ArduinoBoardUno).

One thing you should understand about Arduino and embedded controllers in general is the distinction between the *host* and *target* computers.  The *host* is the PC you use to write the program to be executed on the embedded controller.  The *target* is the embedded controller itself.  When you are ready to run your program on the controller, you will need to upload the compiled program from the host computer to the target (controller.)  The good news is that the Arduino software makes this really easy to do.

## Hardware setup

For this lab, you will work in a group of 2 or 3.  Each group will use one hardware kit.

The hardware kit contains:

* A SparkFun RedBoard: this is the Arduino (compatible) controller
* A solderless breadboard, which contains a circuit with an [RGB color sensor](https://www.adafruit.com/products/1334) and three LEDs (one red, one green, and one blue)
* A [SparkFun serial 16x2 LCD](https://www.sparkfun.com/products/9395)
* A USB Mini-B cable

Here what the kit looks like (click for full size):

> Yeah

You should carefully remove the components from the container.  Be careful to keep the wires connecting the RedBoard and the solderless breadboard intact.

You will need to connect the LCD to the other components as follows:

* The yellow wire should connect to Digital Output 2 on the RedBoard
* The black wire should connect to the ground (blue `-`) row of connections on the breadboard
* The red wire should connect to the +5V (red `+`) row of connections on the breadboard

When connected, the entire setup should look like this (click for full size):

> Uh-huh

At this point, you can use the USB Mini-B cable to connect the RedBoard to the PC you are using.  Some LEDs should light up, and once the embedded program is running you should see the messages `red`, `green`, and `blue` on the LCD.

## Software setup

<div class="callout">
Please follow these instructions very carefully.
</div>

Start by downloading the following zipfile:

> [arduino.zip](../media/arduino.zip)

Right-click on the zipfile and choose **Extract all**.  Choose **H:\\** as the directory in which to extract the contents.  Make sure you see a dialog that looks like this:

> The dialog

Next, start the **Arduino** program from the Windows start menu (**Start &rarr; Programs &rarr; Arduino**).  You should see a window that looks a lot like the Processing main window.  Choose **File &rarr; Preferences**.  In the preferences dialog, choose **H:\\arduino** as your sketchbook location.  Close the Arduino program and restart it.

When the Arduino program restarts, open **H:\\arduino\\RGBSensor\\RGBSensor.ino**.  You should now see the code for the **RGBSensor** program: this is the program that is running on the RedBoard.

Running the program.

Modifying the program.

## Things to try

Things to try, what results to write down.
