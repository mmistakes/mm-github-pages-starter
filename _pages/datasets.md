---
title: "Data"
permalink: /datasets/
date: 2020-04-09T00:00:00+00:00
---

The MRSHub is a place to share example datasets for optimization and testing of processing methods. For smaller datasets, you can use the MRSHub GitHub data repository. For larger datasets, consider hosting them in dedicated storage on your institutional server, or leveraging large-scale repositories like [NITRC](https://www.nitrc.org).

{% for dataset_collection in site.dataset_collection %}
  {% if dataset_collection.type contains "dataset" %}
  <h2>
      {{ dataset_collection.name }}
  </h2>
  <img src= "{{ site.url }}{{ site.baseurl }}{{ dataset_collection.image }}" alt="" align="right"/>
  <p>{{ dataset_collection.abstract | markdownify }}</p>
  <p>Sequence: {{ dataset_collection.sequence }}</p>
  <p>License: {{ dataset_collection.license }}</p>
  <a href="{{ dataset_collection.weblink }}">
  Website
  </a>   
  <a href="{{ dataset_collection.paper }}">
  Publication
  </a>
  {% endif %}
{% endfor %}
