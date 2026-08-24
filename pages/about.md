---
layout: pages
permalink: /about/
title: "All About EPQM: Research, Members, Contact Details"

---

## What Is EPQM?

**EPQM** (Emergent Phenomena in Quantum Matter) is a research group at IISER Kolkata led by Dr. **Siddhartha Lal** in the Department of Physical Sciences at the Indian Institute of Science Education and Research (IISER) Kolkata, India. We engage in theoretical research on various topics in the **condensed matter physics of quantum matter**, ranging from strongly-correlated electronic systems, quantum magnetism, topological phases of matter, non-Fermi liquids and low-dimensional systems.

Here is an example of what we work on. One of our primary goals is to understand the fascinating and complex phenomenology displayed by many materials studied in the laboratory. An excellent example is the **phenomenon of high-temperature superconductivity** displayed by the Cuprate family of materials. These materials are planar: they are comprised of a set of planes of Copper and Oxyegen atoms that are almost isolated from one another. In their pure form, these materials are **Mott insulators** (i.e., insulators whose physics is driven by strong inter-electron repulsion) that turn into a superconductor at low temperatures upon doping with holes.
Even the normal metallic state shown by them at high temperatures with hole doping is unfamiliar, i.e., it is clearly not the Fermi liquid we understand well, and has come to be known as a **strange metal**. The community working towards understanding these phenomena largely agrees that they arise from strong and local electronic correlations of the electrons running about in the planes. The relevant simplest model in which to seek answers is the **two-dimensional Hubbard model** on the square lattice. And that is we did in some of our recent works (see the [publications](/research/#publications) page for the links). 

But this is far from being a simple task: we seek to understand the quantum physics of an Avogradro number of electrons (that is roughly 6 followed by 23 zeros!) that are interacting with one another. And their physics appears to lie in a regime where the electronic potential energy (due to electron repulsion) is of the same order as their kinetic energy. Thus, approaches that rely on perturbation theory of any kind are bound to fail. Take a look at this [video](https://youtu.be/6gVd-XVjOBU) for a little more context.    

In keeping with this, our work has often involved the development of non-perturbative methods like a novel **renormalisation group method**, twist operator-based techniques and momentum-space entanglement renormalisation group approaches. We also use familiar field-theoretic, many-body theoretic and quantum statistical mechanical methods in conjunction with those we build. Many of our results derive ideas from areas of mathematics such as **topology**, number theory, graph theory as well as quantum information theory, non-linear dynamics and even machine learning.

For more information, please take a look at our [research work](/research/) and our [publications](/publications/).

## Openings
EPQM is a family, and we take joy and pride in working together and helping one another's growth in their pursuits. If you think you will enjoy being part of EPQM, we want to hear from you. So please read and follow the instructions (relevant to you) given below (show more).

### BS-MS students at IISER Kolkata looking for a 5th-year Research Project
Please contact me during the winter break between your 7th and 8th semesters, or sometime during your 8th semester (the sooner the better). That way, we can have enough time to discuss common interests, share background reading material and converge on something to work on. The best way to contact me is to drop by my office (RC 112-O, next door to the DPS Office) for a chat.

### Integrated PhD students at IISER Kolkata looking for a M.S. Research Project
Please contact me during the winter break between your 1st and 2nd semesters, or sometime during your 2nd semester (the sooner the better). That way, we can have enough time to discuss common interests, share background reading material and converge on something to work on. The best way to contact me is to drop by my office (RC 112-O, next door to the DPS Office) for a chat.

### Post-M.Sc. students looking to join EPQM for their Ph.D. 
Please contact me by email to check whether EPQM has an opening. For your candidature to be considered, please include your **complete CV** (detailing your academic background along with grades, marks etc.) and a **Statement of Purpose** that details your motivation for wanting to work with me. Applicants who have their own fellowship (e.g., valid JRF fellowship from CSIR or UGC) will be preferred.

### Post-doctoral candidates looking to join EPQM upon completing their Ph.D.
Please contact me by email to check whether EPQM has an opening. For your candidature to be considered, please include your **complete CV** (detailing your academic background, your publications etc.) and a **Statement of Purpose** that details your doctoral research and your motivation for wanting to work with me. IISER Kolkata's own Post-doctoral fellowships are advertised occasionally, so please check the IISER Kolkata website for details (or check with me). If I have extramural funding for a Post-doctoral fellowship, I will advertise it here; at present, I do not have any such funding. If you'd like to apply for a National Post-Doctoral Fellowship (NPDF) from the Science and Engineering Research Board (SERB) to work with me, please write to me well ahead of time. That way, we can have enough time to discuss common interests, share background reading material, converge on something to work on and write a proposal. 


## The Good Stuff

### Gallery
Check out the [gallery](/gallery/) for some photographs of our group as well as the IISER Kolkata campus.

### External Resources
Take a look at our suggested [external resources](/external-resources/) for funny/interesting/useful links pertaining to academia in general or (condensed matter) physics in particular.

### Fiction Recommendations
Check out our [recommendations](/fiction-recommendations/) for "a single work of fiction that should be experienced by everyone at least once".

## Contact Details

**Email**: slal@iiserkol.ac.in

**Telephone**: +91-33-61360000  Extn.:1290

EPQM<br>
Research Complex, Office 112-O,<br>
Department of Physical Sciences,<br>
IISER Kolkata<br>
Mohanpur-741246, West Bengal, India.

<div class="gallery" markdown=0>
<img src="/assets/logos/epqm_logo_combined.svg"/>
<img src="/assets/logos/IISER-K_Logo.png"/>
<img src="/assets/logos/dps-logo.svg"/>
</div>

## Members Of EPQM

{% assign leader = site.data.members | find: "Category", "Leader" %}
{% include memberInfo.html member=leader %}

{% assign rs = site.data.members | where: "Category", "Research Scholar" %}
{% if rs %}
### Research Scholars
<div class="members">
{% for member in rs %}
{% include memberInfo.html member=member %}
{% endfor %}
{% endif %}
</div>

{% assign pdf = site.data.members | where: "Category", "Postdoctoral Researcher" %}
{% if pdf %}
### Postdoctoral Researcher
<div class="members">
{% for member in pdf %}
{% include memberInfo.html member=member %}
{% endfor %}
{% endif %}
</div>

{% assign ms = site.data.members | where: "Category", "MS Student" %}
{% if ms %}
### MS Students
<div class="members">
{% for member in ms %}
{% include memberInfo.html member=member %}
{% endfor %}
{% endif %}
</div>

{% assign alum = site.data.members | where: "Category", "Alumni" %}
{% if ms %}
### Alumni
<div class="members">
{% for member in ms %}
{% include memberInfo.html member=member %}
{% endfor %}
{% endif %}
</div>
