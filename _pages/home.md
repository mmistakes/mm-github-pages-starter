---
title: "MRSHub"
layout: splash
permalink: /
date: 2016-03-23T11:48:41-04:00
header:
  overlay_color: "#000"
  overlay_filter: "0.5"
  actions:
    - label: "Get started"
      url: "https://github.com/mrshub/"
excerpt: "A curated resource of magnetic resonance spectroscopy software."
intro:
  - excerpt: ''
feature_row:
  - image_path: assets/images/software.png
    alt: "LCModel"
    title: "Software Packages"
    excerpt: "Complete software packages for processing, analysing, and visualizing MRS data."
    url: /software
    btn_label: "Read More"
    btn_class: "btn--primary"
  - image_path: /assets/images/libraries.jpg
    alt: "Function Libraries"
    title: "Function Libraries"
    excerpt: "Code libraries with modular functions to process, manipulate, analyse, and display raw MRS data."
    url: /libraries
    btn_label: "Read More"
    btn_class: "btn--primary"
  - image_path: /assets/images/snippets.jpg
    alt: "Snippets"
    title: "Snippets"
    excerpt: "Small chunks of code for every possible purpose."     
    url: /snippets
    btn_label: "Read More"
    btn_class: "btn--primary"

---

{% include feature_row id="intro" type="center" %}

{% include feature_row %}
