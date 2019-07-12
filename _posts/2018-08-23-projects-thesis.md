---
title: "Development of image-based surgical planning software for bone-conduction implants"
categories:
  - Projects
tags:
  - software
  - image processing
  - matlab
  - research
  - medical imaging
  - bonebridge
  - temporal bone
  - surgical planning
  - computed tomography
  - bone conduction devices
link: https://pdfs.semanticscholar.org/a0b5/d64a473c5b472b510301769e41e34d926161.pdf
featured-image: BB.png
---
<header class="post-header">
   <h1 class="post-title">{{ page.title }}</h1>
   <time datetime="{{ page.date | date_to_xmlschema }}">{{ page.date | date: "%b %-d, %Y" }}</time>
   {% if page.author %} • {{ page.author }}{% endif %}
   <!-- call the featured-post-image.html template file -->
   {% if page.featured-image %}{% include post-featured-image.html image=page.featured-image alt=page.featured-image-alt %}{% endif %}
</header>

**Abstract**
The BONEBRIDGE bone-conduction device is used to treat conductive and mixed hearing losses. The size of its floating mass transducer (FMT) can preclude implantation in certain anatomies, necessitating comprehensive surgical planning. Current techniques are time consuming and difficult to transfer to the operating room. The objective of this thesis was to develop software for calculating skull thickness to the dura mater to find locations for the FMT and to the first air cells which guarantee sufficient bone for the implant screws to grasp. Temporal bone computed tomography (CT) images were segmented and processed and custom Matlab code was written to generate and test thickness colormaps. For validation, measurements performed by a trained otologist were compared to the algorithm estimations achieving sub-millimeter accuracy. Results suggest this software can be used in the surgical workflow to automate thickness estimation and aid in finding an ideal location for the BONEBRIDGE device and screws.

**Keywords**
Image Processing, BONEBRIDGE, Temporal Bone, Surgical Planning, Computed
Tomography, Bone Conduction Devices

**Recommended Citation**
>Salgado, Carlos D., "Development of image-based surgical planning software for bone-conduction implants" (2018). Electronic Thesis
and Dissertation Repository. 5535. [https://ir.lib.uwo.ca/etd/5535](https://ir.lib.uwo.ca/etd/5535)
