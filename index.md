---
# You don't need to edit this file, it's empty on purpose.
# Edit theme's home layout instead if you wanna make some changes
# See: https://jekyllrb.com/docs/themes/#overriding-theme-defaults
layout: home_page2

permalink: /
title: "Loïc Lannelongue"
excerpt: "On this website, you can learn more about my research interests, my teaching and read blog articles."

last_modified_at: 25/04/2021

sidebar: true
author_profile: true
twitter: true

classes: wide

header:
  overlay_image: assets/images/homepage/banner02_processed.png
  actions:
    - label: "Go straight to research"
      url: /research/
    - label: "About me"
      url: /about/

highlights:
  - image_path: assets/images/homepage/screenshot_app_processed.png
    title: "Green Algorithms"
    excerpt: "This project aims at raising awareness on the carbon footprint of modern High Power Computing."
    url: /research/green-algorithms
    btn_label: "Read More"
    btn_class: ".btn"
  - image_path: assets/images/homepage/network_2_processed.png
    title: "Protein interactions"
    excerpt: "How to leverage modern Deep Learning tools to better perdict _in vivo_ protein-protein interactions?"
    url: /research/protein-protein-interactions
    btn_label: "Read More"
    btn_class: ".btn"

highlights1:
  - image_path: assets/images/homepage/screenshot_app_processed.png
    title: "Green Algorithms"
    excerpt: "This project aims at raising awareness on the carbon footprint of modern High Power Computing."
    url: /research/green-algorithms
    btn_label: "Read More"
    btn_class: ".btn"

highlights2:
  - image_path: assets/images/homepage/network_2_processed.png
    title: "Protein interactions"
    excerpt: "How to leverage modern Deep Learning tools to better perdict _in vivo_ protein-protein interactions?"
    url: /research/protein-protein-interactions
    btn_label: "Read More"
    btn_class: ".btn"

---

<!-- TODO responsiveness -->
<!-- TODO hide twitter feed on small devices (or put it at the end of the page) -->

<!-- On this website, you can learn more about my research interests, read the blog articles and find all my teaching material. Below are some highlights as well as recent blog articles. -->

## Highlights

{% include feature_row id="highlights"%}

<!-- {% include feature_row id="highlights1" type="left" %}

{% include feature_row id="highlights2" type="right" %} -->

<!-- {% twitter site.myTwitter maxwidth=300 limit=5 chrome=nofooter dnt=true %} -->