---
title: "Deidentification"
permalink: /software_deid/
date: 2020-04-16T13:00:00+00:00
sidebar:
  nav: "software"
toc: true
---

{% for software_collection in site.software_collection %}
  {% if software_collection.type contains "deidentification" %}
  <h2>
      {{ software_collection.name }}
  </h2>
  <img src= "{{ site.url }}{{ site.baseurl }}{{ software_collection.image }}" alt="" align="right"/>
  <p>{{ software_collection.abstract | markdownify }}</p>
  Developer: {{ software_collection.developer }} <br>
  Language: {{ software_collection.language }} <br>
  License: {{ software_collection.license }} <br>
  Credit: {{ software_collection.credit }} <br>
  <a href="{{ software_collection.mrshub_url }}">
  MRSHub Code
  </a> &nbsp;
  <a href="{{ software_collection.original_url }}">
  Original URL
  </a> &nbsp;
  <a href="{{ software_collection.paper }}">
  Publication
  </a>
  {% endif %}
{% endfor %}
