---
layout: default
title: EPQM@IISER Kolkata
featured: /pseudogapMottmetal/
---

{% assign post = site.posts | find: "permalink", page.featured %}

<section class="featured">
<a class="featured-image" href="{{ post.url }}">
<img src="/assets{{ post.permalink }}{{ post.hero-image }}" alt="{{ post.title }}">
</a>

<div class="featured-label">Featured Research
</div>
<h2>{{ post.title }}</h2>

<span class="date">
{{ post.date | date: "%b %Y" | upcase }}
</span>
<span class="home-excerpt">
 {{ post.excerpt | strip_html | truncatewords: 35 }}
</span>

<a class="featured-link" href="{{ post.url }}"> Read the research <span class="nf nf-fa-arrow_right"></span></a>
</section>

<div class="epqm-description">
## Emergent Phenomena in Quantum Matter
{{ site.description }}
</div>


<div class="home-header"><h1>Publication News</h1><a class="button notice" href="/posts#publication-news">See All News</a>
</div>
{% for post in site.categories["manuscript"] limit:4 %}
{% assign date = post.date | date: "%b %Y" | upcase %}
{% include update-item.html title=post.title date=date url=post.url excerpt=post.excerpt full=false %}
{% endfor %}

<div class="home-header"><h1>Updates</h1><a class="button notice" href="/posts#updates">See All Updates</a>
</div>
{% for post in site.categories["news"] limit:4 %}
{% assign date = post.date | date: "%b %Y" | upcase %}
{% include update-item.html title=post.title date=date url=post.url excerpt=post.excerpt full=false %}
{% endfor %}

<div class="home-header"><h1>The Good Stuff</h1></div>
<div class="gallery">
{% include gallery.html image="/assets/home/thumb1.jpeg" caption="Check out the gallery for some photographs of our group as well as the IISER Kolkata campus." %}
{% include gallery.html image="/assets/home/thumb2.jpeg" caption="Take a look at our suggested external resources for interesting content pertaining to physics or academia in general." %}
{% include gallery.html image="/assets/home/thumb3.jpg" caption="Check out our recommendations for works of fiction that should be experienced by everyone at least once." %}
</div>

<div class="home-header"><h1>Like What You see so far?</h1></div>
- Take a look at our [research interests](/research/) and [publications](/publications/) to get a better idea of what we do. 

- We have also uploaded some of our [seminars](/seminars/) on various topics in quantum condensed matter physics.

- If you want to get in touch with us, here are our [contact details](/about/#contact-details). If you are interested in joining us, please look at [openings](/about/#openings).
