---
permalink: /people/
layout: splash
title: "EPQM Members: Present Team and Alumni"
classes: wide
header:
    overlay_image: /assets/images/seminars/seminars_header.svg

---

{% for class in site.data.people %}

# {{ class[0] }}

{% include feature_row_people.html %}

{% endfor %}

{% include gallery %}

