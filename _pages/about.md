---
permalink: /about/
title: "Om os"
layout: splash
header:
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/layout/broed.png
  #actions:
  # - label: "Download"
  #    url: "https://github.com/mmistakes/minimal-mistakes/"
  #caption: "Photo credit: [**Unsplash**](https://unsplash.com)"
excerpt: "Hvad skal der stå her?"
intro: 
  - excerpt: 'Her skal stå noget om bloggen generelt'

Henrik:
  - image_path: /assets/images/layout/henrik.jpg
    alt: "placeholder image 2"
    title: "Henrik Bøgedal Breddam"
    excerpt: 'Her skal der stå lidt om henrik'
    url: "#test-link"
    btn_label: "Read More"
    btn_class: "btn--primary"
Helene:
  - image_path: /assets/images/layout/broed.png
    alt: "placeholder image 2"
    title: "Placeholder Image Right Aligned"
    excerpt: 'Her skal står lidt om Helene'
    url: "#test-link"
    btn_label: "Read More"
    btn_class: "btn--primary"
Kristian:
  - image_path: /assets/images/layout/broed.png
    alt: "placeholder image 2"
    title: "Placeholder Image Center Aligned"
    excerpt: 'Her skal stå lidt om Kristian'
    url: "#test-link"
    btn_label: "Read More"
    btn_class: "btn--primary"
---

{% include feature_row id="intro" type="center" %}


{% include feature_row id="Henrik" type="left" %}
Henriks posts
{% include feature_row id="Helene" type="right" %}

{% include feature_row id="Kristian" type="left" %}