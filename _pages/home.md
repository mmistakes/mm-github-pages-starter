---
title: "MRSHub"
layout: splash
permalink: /
date: 2016-03-23T11:48:41-04:00
header:
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/unsplash-image-1.jpg
  actions:
    - label: "Get started"
      url: "https://github.com/mmistakes/minimal-mistakes/"
excerpt: "A curated resource of magnetic resonance spectroscopy software, data analysis tutorials, and educational material."
intro:
  - excerpt: ''
feature_row:
  - image_path: assets/images/lcmodel.png
    alt: "LCModel"
    title: "Software"
    excerpt: "A comprehensive survey of software to process and analyse MRS data - from brief code snippets to automated processing and modeling pipelines."
    url: "#test-link"
    btn_label: "Read More"
    btn_class: "btn--primary"
  - image_path: /assets/images/tutorials.jpg
    alt: "Tutorials"
    title: "Tutorials"
    excerpt: "Interactive tutorials, example code and best practices in modern MRS data analysis."
    url: "#test-link"
    btn_label: "Read More"
    btn_class: "btn--primary"
  - image_path: /assets/images/education.jpg
    alt: "Education"
    title: "Education"
    excerpt: "Online resources, book recommendations, and other material to get introduced to MRS."     
    url: /education
    btn_label: "Read More"
    btn_class: "btn--primary"

---

{% include feature_row id="intro" type="center" %}

{% include feature_row %}
