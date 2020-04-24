---
title: "Sharing your code on MRSHub"
permalink: /software_contribute/
date: 2020-04-19T9:00:00+00:00
classes: wide
sidebar:
  nav: "software"


---

Contributing useful code that you wrote to solve a recurring task is a great way to...
* assist the community in creating tools and propel transparent science.
* avoid duplication of efforts.
* get credit and gain recognition of your work.

# Submission guidelines

There are three easy ways to submit your work for being featured on the MRSHub: e-mail, the MRSHub forum, or directly via GitHub. We will then generate entries for your contribution on the [MRSHub software collection page](https://www.mrshub.org/software/), and add the code to a separate repository in the [MRSHub GitHub account](https://github.com/mrshub).

Apart from your code, valid submissions through any of these three pathways require two text files, and an optional image file to be shown next to the entry associated with your submission:

* `SUBMISSION.md` containing the following basic information:

| Field | Mandatory? | Description |
| ----  | ---------- | ----------- |
| Developer | Yes | The name(s) you want to credit with development |
| Name of software | Yes | A unique, descriptive name for the software/piece of code |
| Abstract | Yes | A brief abstract of the purpose, scope, and functions of the code you contribute |
| Languages | Yes | The primary programming language(s) of your contribution |
| Credit | No | Indicate if and how you would like to be credited for your software - for example, if a certain publication should be cited, or whether you would like to be acknowledged in publications using your code. Can also include general information about licensure. |
| Contact | No | A way you can be contacted, for example an e-mail address, the website of your lab, or your LinkedIn/Researchgate/Google Scholar page. Please note, this information will be made available on the MRSHub website, so if you would rather your e-mail not be made public, please don't include. |
| Publication | No | A publication you want to associate with the submission |
| URL | No | A URL to a project page, code repository etc. associated with the submission |

* `LICENSE.md` containing a [license file](https://choosealicense.com/). You can find template license agreements for many widely used licenses when you create a GitHub repository. Commonly used licenses are BSD-2, BSD-3, MIT, and GPL. **For MRSHub submissions, unless you include your own licensing agreement, we assume that you want to share under the [BSD-3 license (approved by the Open Source Initiative)](https://opensource.org/licenses/BSD-3-Clause), will add the appropriate license file to the MRSHub repository of your code.**

* If you want, you can add a square image (in .PNG or .JPG format) to your submission. We will use this image to be displayed next to its entry on the [MRSHub software collection page](https://www.mrshub.org/software/), and to its repository in the [MRSHub GitHub account](https://github.com/mrshub).

## Submitting through e-mail

Create a .zip file containing the code folder and example data, `SUBMISSION.md` and `LICENSE.md`. Send this .ZIP file via e-mail or include a link to a file hoster where we can access it.

## Submitting through the MRSHub forum

Create a new topic in the [MRSHub forum](https://forum.mrshub.org) with the basic submission information. Preface the title of the topic with [CODE SUBMISSION]. Upload a .ZIP file containing the code folder, example data, `SUBMISSION.md` and `LICENSE.md` to a file hoster where we can access it, and include the link in your topic.

## Submitting directly via GitHub

Create a new topic in the [MRSHub forum](https://forum.mrshub.org) with a link to your repository. Include the code folder, example data, `SUBMISSION.md` and `LICENSE.md` in the repository . We will fork the repository into the [MRSHub GitHub account](https://github.com/mrshub). Whenever you update your own repository and wish to have the new features included in the MRSHub repository, submit a pull request from your personal repository to the MRSHub repository, or let us know in the forum topic belonging to your initial submission.

# Good coding practices

"Code is more often read than written." (Guido van Rossum)

We understand that most MRSHub users and contributors are MR physicists, neuroscientists, or clinical researchers first, and code developers second. Any line of code can potentially be useful to someone else. Don't fret if you think your code "isn't perfect"! If you can save someone else a chunk of time they'd otherwise spend duplicating your effort, your code is good enough!

HOWEVER, to maximize the impact and usability of your submission, please try and make your code as generalizable, readable, and understandable as you can. Annotate and comment as much of your code as possible. Provide an example dataset along the code itself, and show the output of your code so users know what the code is supposed to accomplish.

Many programmers have written about good coding practices:
* [Guidelines for writing clean and fast code in MATLAB](https://www.mathworks.com/matlabcentral/fileexchange/22943-guidelines-for-writing-clean-and-fast-code-in-matlab)
* [How to Write Beautiful Python Code With PEP 8](https://realpython.com/python-pep8/), following the official [PEP 8 Style Guide for Python Code](https://www.python.org/dev/peps/pep-0008/)
* [How to write Clean, Beautiful and Effective C++ Code](https://medium.com/@MKahsari/how-to-write-clean-beautiful-and-effective-c-code-d4699f5e3864)
* [Advanced R - Style Guide](http://adv-r.had.co.nz/Style.html)
