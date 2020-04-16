---
title: "MRSHub"
layout: splash
permalink: /
date: 2020-04-09T12:00:00-04:00
header:
  overlay_color: "#000"
  overlay_filter: "0.5"
  actions:
    - label: "Python code repository"
      url: "https://github.com/mrshub/code-python"
    - label: "MATLAB code repository"
      url: "https://github.com/mrshub/code-matlab"
    - label: "C/C++ code repository"
      url: "https://github.com/mrshub/code-cpp"
    - label: "Other code repository"
      url: "https://github.com/mrshub/code-other"

excerpt: "A curated resource of software and data for magnetic resonance spectroscopy researchers."
#intro:
#  - excerpt: 'Test'
feature_row:
  - image_path: /assets/images/code.jpg
    alt: "Software & Code"
    title: "Software & Code"
    excerpt: "The MRSHub code repository collects software packages and functions to process, manipulate, analyse, and display MRS data."
    url: /software
    btn_label: "To the MRSHub code repository"
    btn_class: "btn--primary"
  - image_path: assets/images/forum.jpg
    alt: "MRSHub Forum"
    title: "Forum"
    excerpt: "The MRSHub forum is a place for the MRS community to seek support, exchange ideas, ask questions, and collaborate."
    url: https://forum.mrshub.org
    btn_label: "To the MRSHub forum"
    btn_class: "btn--primary"
  - image_path: /assets/images/data.jpg
    alt: "Data"
    title: "Data"
    excerpt: "The MRSHub data repository collects MRS datasets for demonstration and testing of new methods."     
    url: /datasets
    btn_label: "To the MRSHub data repository"
    btn_class: "btn--primary"

---

{% include feature_row id="intro" type="center" %}

{% include feature_row %}
