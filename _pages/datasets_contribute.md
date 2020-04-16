---
title: "How to contribute data to MRSHub"
permalink: /datasets_contribute/
date: 2020-04-16T9:00:00+00:00
sidebar:
  nav: "datasets"
---

# Sharing data

Contributing MRS datasets that you acquired and/or simulated provides the community with new resources to...
* develop and improve data processing routines.
* benchmark quantification algorithms.
* have your findings scrutinized and reproduced.
* get credit for your work.
* gain recognition of your name and familiarity with your work.

# Submission guidelines

We distinguish between two types of dataset submission:
- **Example datasets**: Smaller datasets that can be hosted in a single GitHub repository, and have a total size of less than 200 MB. We can fork these data into the [MRSHub GitHub account](https://github.com/mrshub).
- **Large datasets**: Larger-scale datasets exceeding a total size of 200 MB. These datasets need to be hosted on an external file hoster, such as an institutional server, cloud service, or [NITRC](https://www.nitrc.org). Once you submit a large dataset, we will add an entry to the [MRSHub dataset collection](https://www.mrshub.org/datasets/)

When submitting your data, please attach basic information by filling in the following template. We will use this information to generate the entry for your contribution on the MRSHub datasets page.
- **Developer**: The name(s) you want to credit. (MANDATORY)
- **Name of the software**: The name of the dataset. (MANDATORY)
- **Abstract**: A brief description of the dataset you contribute. (MANDATORY)
- **Format**: The data formats used in your dataset (MANDATORY)
- **Sequence**: The MRS sequence(s) used to acquire the dataset (MANDATORY)
- **Credit**: Indicate how you would like to be credited for your data - for example, if a certain publication should be cited, or whether you would like to be acknowledged in publications using your data. (OPTIONAL)
- **Contact**: A way you can be contacted, for example an e-mail address, the website of your lab, or your LinkedIn/Researchgate/Google Scholar page. (OPTIONAL)

## Submitting through e-mail

Send an e-mail with the basic submission information. We will then create an entry for your submission to the [MRSHub dataset collection](https://www.mrshub.org/datasets/). If you submit an example dataset (<200 MB total file size), we will also create a repository in the [MRSHub GitHub account](https://github.com/mrshub).

## Submitting through the MRSHub forum

Create a new topic in the [MRSHub forum](https://forum.mrshub.org) with the basic submission information. We will then create an entry for your submission to the [MRSHub dataset collection](https://www.mrshub.org/datasets/). If you submit an example dataset (<200 MB total file size), we will also create a repository in the [MRSHub GitHub account](https://github.com/mrshub).

## Submitting directly via GitHub (EXAMPLE DATASETS ONLY)

Create a new topic in the [MRSHub forum](https://forum.mrshub.org) with a link to your example data repository. We will fork the repository into the [MRSHub GitHub account](https://github.com/mrshub).

# Organizing your dataset

Every researcher organizes their data in a different way, which often leads to confusion and a lot of time spent on figuring out someone else's organization structure.

The [Brain Imaging Data Structure (BIDS)](https://bids.neuroimaging.io/) specification is a consortium effort to standardize the way that neuroimaging data and metadata are organized into folder structures. When submitting your datasets to be featured on the MRSHub, please consider organizing them according to the [BIDS folder hierarchy](https://github.com/bids-standard/bids-starter-kit/wiki/The-BIDS-folder-hierarchy), and include useful metadata (age, sex, ...)

# De-identification

It is your responsibility to comply with the requirements to remove all protected health information (PHI) from file names, headers, and files themselves. If you include anatomical data in your dataset, make sure that you make use of appropriate defacing algorithms as well.

You can find a list of de-identification tools in the [MRSHub software collection](https://www.mrshub.org/software_deid).
