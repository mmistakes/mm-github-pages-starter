---
title: "MIPS Multicycle Datapath in Logisim-Evolution"
excerpt: "MIPS datapath made in logisim-evolution for the Computer's Architecture course."

header:
  teaser: /assets/images/MIPS1.png

gallery:
  - url: /assets/images/MIPS1.png
    image_path: assets/images/MIPS1.png
    alt: "MIPS Finite State Machine"

number: 3
---

I have developed a small MIPS simulator in logisim-evolution for my tutoring job for the "Computer's Architecture" course.

There are other examples on GitHub which we could have used, but none of them were suited for our intents.
My main focus was to make an easily modifiable simulator, so that we could use it for the exercises during the labs.
The exercises consist of adding new instructions or exceptions to the datapath, by modifying both the main structure and the FSM.
This simulator was developed so that the students could easily implement their solutions and test if everything works correctly.

In the [MIPS-Multicycle-Datapath repository](https://github.com/fdila/MIPS-multicycle-datapath) I have included both the simulator, 
exercises with solutions and slides used to present the simultator, including the instructions on how to modify it.

{% include gallery %}
