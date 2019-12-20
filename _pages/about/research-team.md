---
permalink: /about/research-team/
title: "Research team"
---

{% for member in site.data.authors %}
{% assign fullname = member[1].name | slugify %}
{% assign fullbio = "/research-team/" | append: fullname | append: ".md" %}
<div class="bio" id="{{ fullname }}">
  <h2>{{ member[1].name }}<br/><small>{{ member[1].bio }}</small></h2>
  {% if member[1].avatar != blank %}
  <div class="author__avatar">
    <img src="{{ member[1].avatar }}" alt="{{ member[1].name }}" />
  </div>
  {% endif %}
  {% capture my_include %}{% include_relative {{ fullbio }} %}{% endcapture %}
  {{ my_include | markdownify }}
</div>
{% endfor %}
