# Bitwiser Material theme for Jekyll.
A minimal material design theme using [muicss](https://www.muicss.com).

## Features

* Clean, simple and responsive layout
* Code formatting.
* Sitemap included.
* Google analytics.
* Disqus commenting (Loaded lazily).
* Share post to facebook and twitter.
* Robots.txt included.
* Custom 404 error page.
* Clean material theme.
* Awesome navigation menu on small screens.
* Post specific color or cover image.

Theme website: http://bitwiser.in/bitwiser-material/

Demo post: http://bitwiser.in/bitwiser-material/demo.html

Usage: [http://bitwiser.in/bitwiser-material/usage.html](http://bitwiser.in/bitwiser-material/usage.html)

Download latest Zip: [Here](https://goo.gl/VWBbHF)

Or browse releases: [Releases](https://github.com/brijeshb42/bitwiser-material/releases)

Report issues: [Issues](https://github.com/brijeshb42/bitwiser-material/issues/new)

If you are using this theme, do not forget to :star: this repo or tweet [@brijeshb42](https://twitter.com/brijeshb42).

Pull requests are also welcome :thumbsup:.


## Getting Started

(Assuming you know what Jekyll and Github pages are.)

* Download this theme's zip file from [here](https://goo.gl/VWBbHF) or clone the repository using ```git clone https://github.com/brijeshb42/bitwiser-material.git```.

* Install ```ruby``` and then do ```gem install jekyll```. This theme uses the latest ```jekyll``` version. So if you already have it installed, then upgrade it.

* ```_config.yml``` describes all the variables which you are required to set. The description begins with double hash(```##```). And the value to be set is commented below it using ```#```.

* Edit ```_config.yml``` according to your requirements.
	* ```title``` : ```Your website name```
	* ```disqus``` : ```disqusForumName```
		If this value is present, disqus commenting will be automatically added to all your blog posts.
	* ```ga_id``` : ```googleAnalyticsID```
		If this value is present, google analytics will be added to your website/blog.
		If ```ga_id``` is present, make sure that ```ga_domain``` is also present.
	* ```description```: ```A short description of your website to be included in meta tag of your homepage```
	* ```keywords``` : ```a few frequently used keywords on your site```
	* ```links``` : This variable has a few commonly used social networks' links
		* ```facebook```: ```facebookId```
		* ```twitter``` : ```twitterHandle```
		* ```email```: ```email@example.com```
		* ```github```: ```githubUsername```

* After setting the values in ```_config.yml```, you can start adding posts in the ```_posts``` directory. Remove the example posts from the directory. The name of files in this directory should be according to specifications by ```jekyll```, i.e, ```YYYY-MM-DD-your-post-title.md```. **Note** that the file name extenion can be anything from md, markdown, mkd, textile or html.

* Replace the image files ```favicon.png``` and ```sharer.png``` with images of your own.

* Test the site on local machine using ```jekyll serve``` in the theme directory.

* If all works well, ```git push``` your changes to your github pages repository ```https://github.com/githubUserName/githubUserName.github.io```

* Then visit your blog at [http://githubUserName.github.io](http://githubUserName.github.io).

* If you want to use a custom domain, then edit the ```CNAME``` file and add your own domain ```example.com```. Make sure your domain points to github ip address.


### New Feature

* In every blog post, custom header color or cover image can be added.
* While creating a blog post, just add extra `color` or `cover` or both attributes in th front matter of the post alongside `title` and `date`.
* Value of `color` can be anything in `[grey, orange, yellow, amber, light-blue, lime, teal, blue, black-87, blue-grey, brown, indigo, purple, deep-purple, red, pink]`.
* See the demo of all the colors [here](http://bitwiser.in/bitwiser-material/2015/07/12/color-choices.html)
* And the value of `cover` can be an absolute url of an image or a relative url like `/img/post-cover.jpg`. If using relative url, make sure the image is added in the `img` directory.
