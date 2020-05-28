---
title: "Kristians opskrifter"
layout: splash
author: Kristian
header:
  overlay_color: "#000"
  overlay_filter: "0.15"
  overlay_image: /assets/images/layout/broed.jpg
excerpt: ""
permalink: /kristian/

---

<div class="feature__wrapper">
{% assign posts =  site.posts | where: 'author', page.author %}
  {% for post in posts %}
    {%include feature_item post=post %}
  {% endfor %}

</div>
