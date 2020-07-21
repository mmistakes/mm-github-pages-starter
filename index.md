---
# You don't need to edit this file, it's empty on purpose.
# Edit theme's home layout instead if you wanna make some changes
# See: https://jekyllrb.com/docs/themes/#overriding-theme-defaults
layout: home_page2

permalink: /
title: "<br>Welcome<br><br>"

last_modified_at: 21/07/2020

sidebar: true
author_profile: true
twitter: true

classes: wide

header:
  <!-- overlay_image: /assets/images/header_blue.jpg -->
  overlay_image: assets/images/homepage/header_02_processed.png

highlights:
  - image_path: assets/images/homepage/screenshot_app_processed.png
    title: "Green Algorithms"
    excerpt: "This project aims at raising awareness on the carbon footprint of modern High Power Computing."
    url: /research/green-algorithms.md
    btn_label: "Read More"
    btn_class: ".btn"
  - image_path: assets/images/homepage/network_2_processed.png
    title: "Protein interactions"
    excerpt: "How to leverage modern Deep Learning tools to better perdict _in vivo_ protein-protein interactions?"
    url: /research/protein-protein-interactions.md
    btn_label: "Read More"
    btn_class: ".btn"
  - image_path: assets/images/homepage/ML_typewriter_processed.png
    title: "Tutorials"
    excerpt: "A serie of blog posts to ease scientists into machine learning."
    url: /blog
    btn_label: "Read More"
    btn_class: ".btn"

---
<!-- TODO check everything with Grammarly -->
<!-- TODO update credits -->
<!-- TODO responsiveness -->
<!-- TODO Check link of buttons -->

On this website, you can learn more about my research interests, read the blog articles and find all my teaching material. Below are some highlights as well as recent blog articles.

<!-- TODO: Resize all pictures -->
<!-- TODO: Picture for highlight PPIs -->
{% include feature_row id="highlights"%}

<!-- {% twitter site.myTwitter maxwidth=300 limit=5 chrome=nofooter dnt=true %} -->