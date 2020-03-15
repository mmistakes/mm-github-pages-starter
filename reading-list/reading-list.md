---
title: "Reading List"
permalink: /reading-list/
author_profile: true
---

<div class="container">
  {% for entry in site.data.reading.list %}
  <div class="year-container">
    <div class="year">
      <h4>{{ entry.year }}</h4>
      <div class="number">{{ entry.books | size }} books</div>
    </div>
    <div class="books">
      <ul class="reading-list {{ entry.year }}">
        {% for book in entry.books %}
        <li>
          <a href="{{ book.link }}" alt="_blank" rel="nofollow noopener">{{
            book.title
          }}</a>
          by {{book.author}}   |   {{book.date_read}}   |   {{book.rating}}
        </li>
        {% endfor %}
      </ul>
    </div>
  </div>
  {% endfor %}
</div>

<link rel="stylesheet" href="styles.css">
