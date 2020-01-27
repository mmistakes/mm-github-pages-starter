---
title: Cross-Engine Query Execution in Federated Database Systems
date: 2016-05-01
categories: projects
feature: true
tags:
  - database systems
  - distributed systems
excerpt: 👨🏻‍🎓 In my Master's Thesis, I implemented and evaluated a Query Executor that can evaluate queries joining across relational, column-store, document, and time-series databases.<br/> <br/> I focused on cross-engine shuffle joins, taking into account the skew of the data distribution to minimize data transfer.
header:
  overlay_color: "#333"
  excerpt: "My Master's thesis :)"
  actions:
    - label: "Read the paper"
      url: "/assets/docs/thesis.pdf"
---

Duggan et al. created a reference implementation of the BigDAWG system: a new architecture for future Big Data applications, guided by the philosophy that “one size does not fit all”.

Such applications not only call for large-scale analytics, but also for real-time streaming support, smaller analytics at interactive speeds, data visualization, and cross-storage-system queries.

The importance and effectiveness of such a system has been demonstrated in a hospital application using data from an intensive care unit (ICU).

In my Master's Thesis, I implemented and evaluated a cross-system Query Executor. I focused on cross-engine shuffle joins, taking into account the skew of the data distribution.

[Download the paper](/assets/docs/thesis.pdf)
