---
title: "Electronics Experimentations"
excerpt: "Developing firmware for STM32 dev board and analog circuit study for the acquisition of SiPM signals."

header:
  teaser: /assets/images/exp_electronics1.png

gallery:
  - url: /assets/images/exp_electronics1.png
    image_path: assets/images/exp_electronics1.png
    alt: "SiPM signal"
  - url: /assets/images/exp_electronics2.png
    image_path: assets/images/exp_electronics2.png
    alt: "Analog PCB"
  - url: /assets/images/exp_electronics3.png
    image_path: assets/images/exp_electronics3.png
    alt: "SiPM"

number: 1
---

In the "Electronics Experimentations" course I have been able to work with an STM32 and electronics circuits.

During the laboratories I have been able to learn how to program an STM32 MCU without usign Hardware Abstraction Layer libraries,
but instead focusing on reading the datasheet and reference manual and understanding how various peripherals work at "register level".
In detail I have learned about the following peripherals:

- GPIOs
- Timers
- EXTI
- NVIC
- UART
- ADC
- DMA

During the labs I was also learned how operational amplifiers work, how to make simple circuits with them and how to measure and analyze signals
using an oscilloscope.

The final project consisted in modifying a PCB with the op-amps to amplify and shape a SiPM signal, acquiring the signal using an STM32 and transimt the data to
a computer to analyse the signals in MATLAB.

The code and final report for the course are available in the [Electronics Experimentations repository](https://github.com/fdila/electronics-experimentations).

{% include gallery %}

