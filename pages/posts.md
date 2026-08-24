---
permalink: /posts/
---

# Publication News
{% for post in site.categories["manuscript"] %}
{% assign date = post.date | date: "%b %Y" | upcase %}
{% include update-item.html title=post.title date=.date url=post.url excerpt=post.excerpt %}
{% endfor %}

# Updates
{% for post in site.categories["news"] %}
{% assign date = post.date | date: "%b %Y" | upcase %}
{% include update-item.html title=post.title date=.date url=post.url excerpt=post.excerpt %}
{% endfor %}
