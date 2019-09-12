---
permalink: /projects/
title: "Projects"
author_profile: true
toc: true
toc_sticky: true
toc_label: "Quick Links"
toc_icon: "list-ul"
entries_layout: grid
---

{% include base_path %}


{% for post in site.portfolio %}
  {% include archive-single.html %}
{% endfor %}
