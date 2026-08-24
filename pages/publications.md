---
permalink: /publications/
title: "EPQM: Publications and Preprints"
---

<a class="button" href="{{ site.data.links.arxiv }}">Arxiv</a>
<a class="button" href="{{ site.data.links.google-scholar }}">Google Scholar</a>

{% for item in site.data.publications %}
{% assign authors = item.authors | join: ", " %}
{% include update-item.html title=item.title date=item.reference url=item.url excerpt=authors %}
{% endfor %}
