---
title: "Intro 1: Machine Learning for scientists"

toc: true
toc_sticky: true
---

<!-- TODO link to the slides of the ML workshops -->
_This blog series is based on workshops I have delivered to (bio)statisticians and clinicians at the University of Cambridge. The slides from my talks are here._

<!-- TODO reorganise assets folder -->
<!-- TODO references -->

# Why this series of articles?

So let's dive in.

# ML, what is it and how can you use it in your research?

The myth of AI and Machine Learning is widely spread: intelligent machines, electronic brains etc…
This is obvious when searching for "Machine Learning" on Google

{% include figure image_path="assets/images/blog_illustrations/ML_tutorials/google_results_ML.png" caption="First results when searching for 'Machine Learning' on Google."%}

The truth is, Machine Learning is a lot closer to statistics and data analysis than it is to futurist robots.

Just like in any data-based analysis, there is a simple rule of thumb: the more complex you expect your model (or the phenomenon) to be, the more data you need. And Machine Learning **is not a solution to that problem**, if anything, data is even more crucial to ML-based models.

"I don't have enough data for a statistical model, why don't I just do Machine Learning?" is something that should never be said...ever...ever.
But instead, say "the phenomenon is too complex to be fully apprehended by the statistical tools I have, maybe Machine Learning can help".

## AI is just a black box

One of the things that usually put off researchers, and especially thorough data analysts like (bio)statisticiens, is the belief that AI is just a black box, impossible to audit.

{% include figure image_path="assets/images/blog_illustrations/ML_tutorials/black_box.png" caption="Machine learning can sometimes look like a black box."%}

And yes, with the recent packages, we don't need to really describe what we are doing, but that's the same thing for a simple linear regession! When is the last time you actually coded a Least-square estimator for a regression? And that's for the best, it makes everyone's life easier, limits errors, make results more reproducibles etc.
What matters is to be able to understand the underlying algorithms.

{% include figure image_path="assets/images/blog_illustrations/ML_tutorials/basic_python_for_ML.png" caption="How to train a Support Vector Machine in a few lines of code."%}

But even when we understand how the algorithm works, it doesn't mean that it's easily interpretable (one can't really traceback what in the features led to that specific prediction). It's usually a trade-ff between complexity and interpretability... but the interpretability of AI will be the topic of a future post.

## AI or Machine Learning

It's important to know what we are talking about.

<!-- TODO AI of ML diagram -->
[insert diagram]

Artificial Intelligence covers all methods that try to mimic the human bahovior.

There are two ways to do that: by implementing expert rules designed by expert of the field.
e.g. the decisions trees used by MDs, it enables an algorithm to decide if a patient should go through surgery...that's AI!
The other way is for the algorithm to learn the rules itself, through experience (experience meaning data for computers).

And Deep Learning? It's a sub-category of Machine Learning that leverages huge neural networks (more on that later), to get an extra level of abstraction.

What will interest us here is Machine Learning (both Deep and "shallow").
The same way we distinguish between "classic" statistics and Machine Learning, I'll distinguish between Depp Learning and "classic" ML...but all these boundaries are very flexible!

## What is Machine Learning?

The definition of Machine Learning has evolved through the years. Three main definitions, from three ML eras, are interesting:

> Field of study that gives computers the ability to learn without being explicitly programmed. - Arthur Samuel, 1959

> Any computer program that improves its performance at some task through experience. - Tom Mitchell, 1997

> To develop methods that can automatically detect patterns in data, and then to use the uncovered patterns to predict future data or other outcomes of interest. - Kevin Murphy, 2012

## AI through the years

<!-- TODO use article from Science & Avenir -->

## Types of Machine Learning

Rather than types of Machine Learning, I prefer to talk about types of data... Just like statistics, Machine learning is a data-driven field: the type of data you have decide the type of models you will consider.

We start with labelled data: this is when you have a "gold standard" (also called "reference set", "training set" etc.) of labelled examples, where the label is the variable of interest.
For example, collection of x-rays labelled "cancer" or "non cancer", ...
In this case, we expect the model to use the labelled data to "learn" to predict the outcome of interest."Predict" is the operating word here, the main goal of this approach is prediction on new data. (This is where Machine Learning tends to differenciate itself from statistics, where often the goal is to explain a phenomenon.)
Because this approach requires examples with known outcomes, we call this approach "supervised learning". This is the most common approach in Machine Learning.
We can further divide this category based on the type of labels we have: if the label is continuous, we do regressions, if the labels are categorical, this is classification. I'm sure anyone amongst you who have done some statistics before will find this familiar... and this is only the start, there are many more "common grounds" to come.

The other end is when we don't have any labelled data, and this is called "Unsupervised learning". In this case, we try to find similitude between the data to cluster them together. We can also try to reduce the dimension to create new meaningful features or for easier data visualisation. Principal Component Analysis, well known to all the genetisists out there, is an example of unsupervised learning. The overall goal of unsupervised learning is to extract key features from the data.

Between the two, you can find "semi-supervised learning", for when you have some labelled examples, but not enough to use a fully supervised approach.

We can also distinguish multi-task learning, where algorithms will try to solve multiple tasks at the same time (pretty self explanatory): for example, impute the missing values of a dataset and perform classification on it, all at the same time.

Finally, reinforcement learning corresponds to a situation where your algorithm behaves like an agent interacting with its environment and trying to maximise some form of rewards. This is mainly use to teach (* Actually, the model is teaching itself) algorithms to play games like chess, Go etc.

## Which softwares?

The most widely used programming language for ML is Python, with its popular packages scikit-learn, Tensorflow, PyTorch etc.

R can also be used, don't worry!
