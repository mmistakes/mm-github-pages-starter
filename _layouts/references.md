## References
<div class="footnotes" role="doc-endnotes" markdown=1>

{% for ref in site.data.references[{{page.refs}}] %}

[^{{ forloop.index }}]: {{ ref }}

{% endfor %}

</div>
