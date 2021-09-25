---
title: "Multi-Operation ALU VHDL"
excerpt: "Final project for the Industrial Informatics course, developing a small FSM and ALU"

header:
  teaser: /assets/images/MOALU0.png

gallery:
  - url: /assets/images/MOALU1.png
    image_path: assets/images/MOALU1.png
    alt: "Testbench 1"
  - url: /assets/images/MOALU2.png
    image_path: assets/images/MOALU2.png
    alt: "Testbench 2"
  - url: /assets/images/MOALU2.png
    image_path: assets/images/MOALU2.png
    alt: "Testbench 3"

number: 3
---

I have developed this project with my collegue Michele Pugno for the course "Industrial Informatics".
The goal of this project was to develop a component that could receive an op-code and 2 numbers as a serial input, perform
arithmetic/logic operations on the numbers, output the result in parallel and also transmit the 2 numbers as a serial output.

All the code was developed in VHDL and tested using ModelSim simulations.

VHDL code, requirements and a small report are available in the [Multi-Operation-ALU-VHDL repository](https://github.com/fdila/Multi-Operation-ALU-VHDL).

{% include gallery caption="Waveforms of the final testbenches"%}

