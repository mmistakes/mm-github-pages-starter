---
permalink: /fiction-recommendations/
title: "EPQM Recommendations: Remarkable Works of Fiction"
excerpt: "Works of fiction that we feel everyone should experience at least once"
header:
    overlay_image: /assets/images/seminars/seminars_header.svg
toc: true
---

We asked EPQM members to contribute a single work of fiction that they feel is remarkable and should be watched/read by everyone. Here is what they came up with.

{% for rec in site.data.fiction %}
## Contributor: {{ rec["Contributor."] }}
**Work**. [{{ rec["Work."] }}]({{ rec["link"] }})

**Category**. {{ rec["Category."] }}

_{{ rec["Why watch this?"] }}_

{% assign img = rec['image'] %}
{% include figure.html image=img %}

{{ rec["Pitch"] }}
{% endfor %}

