# README

## Name

Jekyll Jupyter Notebook plugin

## Description

Jekyll Jupyter Notebook plugin adds [Jupyter](http://jupyter.org/) Notebook support to Jekyll. You can embed Jupyter Notebooks into your texts.

## Install

Add the following line to your site's `Gemfile`:

```ruby
gem "jekyll-jupyter-notebook"
```

Run the following command line to make the gem available:

```console
% bundle install
```

Add the following line to your site's `_config.yml`:

```yaml
plugins:
  - jekyll-jupyter-notebook
```

## Usage

Put a Jupyter Notebook (`sample.ipynb`) to the directory that has the target text (`my-text.md`) like the following:

```text
.
|-- my-text.md
`-- sample.ipynb
```

Put the following tag into the target text:

```markdown
{% jupyter_notebook "sample.ipynb" %}
```

If you use kramdown as Markdown parser and get strange result, try to surround `{% jupyter_notebook ...%}` with `{::nomarkdown}` and `{:/nomarkdown}` like the following:

```markdown
{::nomarkdown}
{% jupyter_notebook "sample.ipynb" %}
{:/nomarkdown}
```

## Authors

* Kouhei Sutou \<kou@clear-code.com\>

## License

Apache License 2.0. See doc/text/apache-2.0.txt and NOTICE.txt for details.

(Kouhei Sutou has a right to change the license including contributed patches.)
