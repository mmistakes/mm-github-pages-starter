---
title: "Slide: Presentation in Jekyll with Reveal.js"
description: Web presentation in Jekyll using Reveal.js
layout: slide
theme: league
transition: fade
categories: slide
tags:
  - ahxxm
---
<!-- markdownlint-disable MD033 -->

<section data-markdown>

## Presentation in Jekyll Using Reveal.js

**Reveal.js** is a "HTML presentation framework."

[Click](http://lab.hakim.se/reveal-js) for an introduction.

Source: [ahxxm.github.io](https://github.com/ahxxm/ahxxm.github.io/blob/master/_posts/2016-09-06-slide-en.md)

</section>

<section data-markdown>

### Choose Your Pill

[slides.com](https://slides.com) could be better, it offers full functional web interface.

Good: easy to use, easy to use, easy to use.

Bad:

- **hard** to trace edit history
- default public: except you have a hard-to-guess username
- not quite geek(well..)

</section>

<section data-markdown>
### Install
We need a `slide` layout for presentations: just add this [slide.html](https://raw.githubusercontent.com/ahxxm/ahxxm.github.io/master/_layouts/slide.html) to `_layouts` directory.

Create new post using this layout:

```yaml
---
layout: slide
title: Presentation in Jekyll
description: Web presentation in Jekyll using Reveal.js
theme: league
transition: fade
permalink: /152.moew/
---

your post inside(format will be covered in next slide)
```

</section>

<section>

<section>

<h3>Usage</h3>
<p>Now you can write presentation slides:</p>
<ol class="leftol">
<li>presentation template in <b>_layouts</b>... done!</li>
<li>one section for one slide... ↓</li>
</ol>
</section>

<section data-markdown>
<script type="text/template">

### Markdown Section

Specify `data-markdown` attribute and write Markdown.

```html
<section data-markdown>
### Markdown Section
Specify `data-markdown` attribute and write Markdown.
</section>
```

</script>
</section>

<section data-markdown>
<script type="text/template">

### HTML Section

[Here](https://github.com/hakimel/reveal.js/blob/3.3.0/demo.html#L43") line 43-49 shows a HTML section.

```html
<section>
<p><a href="https://github.com/hakimel/reveal.js/blob/3.3.0/demo.html#L43">Here</a> line 43-49 shows a HTML section.</p>
</section>
```

</script>
</section>
</section>

<section>
  <section data-markdown>
### Presentation Layout
Pages are organized horizontally.

Use nested sections to create vertical pages, ↓
  </section>

  <section data-markdown>
Like [this](https://github.com/hakimel/reveal.js/blob/3.3.0/demo.html#L58).
  </section>
</section>

<section>
<h3>That's it!</h3>
<p>Check <a href="http://lab.hakim.se/reveal-js/">official demo</a> and <a href="https://github.com/hakimel/reveal.js/blob/3.3.0/demo.html">its code</a> for advanced usage.</p>
</section>

<section>
<h3>Tips</h3>
<ol>
<li>press "." -- the one near "?" -- to pause, it will black out contents</li>
<li>press "Esc" for an overview</li>
<li>only <b>.md</b> files will be rendered by Jekyll</li>
</ol>
</section>

<section>
<h3>More Tips</h3>
<ol>
<li>HTML style section on head of post will overwrite default ones(e.g. center aligned text)</li>
<li>use back quote <b>`</b> for HTML tag in markdown section.. is <b>not</b> viable, go write html or use <a href="https://github.com/hakimel/reveal.js/blob/3.3.0/demo.html#L107">special syntax</a></li>
<li><b>slide</b> and <b>fade</b> page transition animation are generally acceptable</li>
</ol>

<aside class="notes">Proper font choice and basic theme is enough, spend more time on make expression short and precise, other than adjusting cool visual effects.</aside>
<aside class="notes">As you might not agree, left aligned text are sometimes more readable.</aside>
</section>

<section data-markdown>

## Links

- [Jekyll: Create Slides with reveal.js](http://luugiathuy.com/2015/04/jekyll-create-slides-with-revealjs/)
- [hakimel/reveal.js](https://github.com/hakimel/reveal.js/)
- [Slides.com Knowledge Base](http://help.slides.com/knowledgebase)
- [CDNjs](https://cdnjs.com/libraries/reveal.js), speeds up site loading

</section>
