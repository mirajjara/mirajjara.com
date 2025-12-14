---
layout: page
title: Writing
permalink: /writing/
---

A few posts a year — usually about engineering, systems, and what I’m learning.

{% assign posts_count = site.posts | size %}
{% if posts_count == 0 %}
_No posts yet._
{% else %}
<ul class="post-list">
  {% for post in site.posts %}
    <li>
      <span class="post-meta">{{ post.date | date: "%b %-d, %Y" }}</span>
      <h3><a class="post-link" href="{{ post.url | relative_url }}">{{ post.title | escape }}</a></h3>
    </li>
  {% endfor %}
</ul>
{% endif %}
