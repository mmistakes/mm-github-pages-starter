---
permalink: /seminars/
title: "EPQM: Seminars and Other Presentations"
excerpt: "Includes slides and video when available"
---

{% for seminar in site.data.seminars %}

## {{ seminar.title }}
**{{ seminar.occasion }}**

<div class="seminar-details">
{{ seminar.date | date:"%b %d, %Y" }}
{%- if seminar.slides_url -%}<a href="{{ seminar.slides_url }}" class="button">Slides</a>{%- endif -%}
{%- if seminar.video_url -%}<a href="{{ seminar.video_url }}" class="button">Video</a>{% endif %}
</div>
{{ seminar.comments | markdownify | remove: "<p>" | remove: "</p>" }}


{% endfor %}
