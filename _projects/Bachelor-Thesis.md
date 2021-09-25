---
title: "Bachelor's Thesis: my differential drive robot"
excerpt: "STM32 firmware developing for the control system for a differential drive robot."

header:
  teaser: /assets/images/otto0.png

gallery:
  - url: /assets/images/otto1.png
    image_path: assets/images/otto1.png
    alt: "Otto"

number: 4
---

During my internship in Iralab (the robotics' lab of my university) I have developed the firmware and ROS driver for the control system of Otto, our differential drive robot.

I wrote the code for a STM32 Nucleo dev board, using the Hardware Abstraction Layer provided by ST.
More specifically I have:
- worked with timers to read the encoders' signals efficiently
- worked with timers to send the correct signals to the H-Bridge to control the 2 DC motors
- developed the PID control for the DC motors
- developed the serial communication interface to receive commands from a PC and send the robot data to the PC.

I have also written the ROS node used to communicate with the robot, and to calculate the odometry of the robot.

Unfortunately the code isn't open source, but you can still read my [final report](https://github.com/fdila/bachelor-thesis) and watch this [small demo video](https://youtu.be/fEhBCXqMYPw)

{% include gallery %}
