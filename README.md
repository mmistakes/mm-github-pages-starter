# Chatie Style Minimal Mistakes remote theme starter

Fork this repo for the quickest method of getting started with the [Minimal Mistakes Jekyll theme](https://github.com/mmistakes/minimal-mistakes).

Contains basic configuration to get you a site with:

- Sample posts.
- Sample top navigation.
- Sample author sidebar with social links.
- Sample footer links.
- Paginated home page.
- Archive pages for posts grouped by year, category, and tag.
- Sample about page.
- Sample 404 page.
- Site wide search.

Replace sample content with your own and [configure as necessary](https://mmistakes.github.io/minimal-mistakes/docs/configuration/).

---

## Usage

### Jekyll

Install all the Jekyll requirements and run it at localhost for blog preview.

```sh
make install
make serve
```

### Test

In order to make sure everything(file name, file size, etc) is ok, you can run the following command to check them before `git push`.

```sh
npm install
npm test
```

## Enhancements

### PDF Viewer

[Viewer.js](https://viewerjs.org/) is the best easy to use.

Others:

1. [reveal.js - The HTML Presentation Framework](https://revealjs.com) Used by slides.com
1. [PDF.js JSFiddle Example](https://jsfiddle.net/pdfjs/wagvs9Lf) from [PDF.js Examples 3](https://mozilla.github.io/pdf.js/examples/)
1. [Online PowerPoint to HTML5 Converter](https://www.digitalofficepro.com/powerpoint/powerpoint-to-html5-converter.html)
1. [React MDX-based presentation decks](https://github.com/jxnblk/mdx-deck)
1. [WikiPedia:Web-based slideshow](https://en.wikipedia.org/wiki/Web-based_slideshow)

### Slide (reveal.js)

1. [Example from ahxxm.github.io](https://github.com/ahxxm/ahxxm.github.io/blob/master/_posts/2016-09-06-slide-en.md)
1. [Jekyll: Create Slides with reveal.js](http://luugiathuy.com/2015/04/jekyll-create-slides-with-revealjs/)
1. [markdown → slides (reveal.js) → gh-pages (jekyll)](https://github.com/ungoldman/jekyll-reveal)
1. [A Jekyll-based framework for creating presentations based on Reveal.js and markdown.](https://github.com/dploeger/jekyll-revealjs)

## Resources

1. [Jekyll cheatsheet](https://devhints.io/jekyll)
1. [Jekyll Liquid Cheatsheet](https://gist.github.com/JJediny/a466eed62cee30ad45e2)
1. [Minimal Mistakes Official Examples](https://mmistakes.github.io/minimal-mistakes/year-archive/)

## Troubleshooting

### `scripts/fit-image.sh` Realted

```sh
sudo apt-get install imagemagic
sudo apt-get install webp
```

### Jekyll Related

If you have a question about using Jekyll, start a discussion on the [Jekyll Forum](https://talk.jekyllrb.com/) or [StackOverflow](https://stackoverflow.com/questions/tagged/jekyll). Other resources:

- [Ruby 101](https://jekyllrb.com/docs/ruby-101/)
- [Setting up a Jekyll site with GitHub Pages](https://jekyllrb.com/docs/github-pages/)
- [Configuring GitHub Metadata](https://github.com/jekyll/github-metadata/blob/master/docs/configuration.md#configuration) to work properly when developing locally and avoid `No GitHub API authentication could be found. Some fields may be missing or have incorrect data.` warnings.

## Author

[Huan LI (李卓桓)](http://linkedin.com/in/zixia) <zixia@zixia.net>

[![Profile of Huan LI (李卓桓) on StackOverflow](https://stackexchange.com/users/flair/265499.png)](https://stackexchange.com/users/265499)

## Copyright & License

- Code & Docs © 2019 - now Huan LI <zixia@zixia.net>
- Code released under the Apache-2.0 License
- Docs released under Creative Commons
