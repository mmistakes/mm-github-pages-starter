---
title: Principles of Shared Code
date: 2019-09-17
categories: speaking
tags:
  - android
  - kotlin
  - kotlin multiplatform
excerpt: "Denver Startup Week 2019: Sept. 17, 2019. Free event!"
header:
  overlay_color: "#333"
  actions:
    - label: "See more"
      url: "https://www.denverstartupweek.org/schedule/5959-a-journey-in-shared-code-with-kotlin-multiplatform"
---
Writing effective, sustainable, and flexible multiplatform code has been the White Whale of many a software engineer's career. At Quizlet, we've spent several years exploring and refining how to use shared code to develop a high-quality learning experience for over 50 million monthly active users.

In this talk, you'll learn the guiding principles behind Quizlet's approach to shared code, regardless of which technologies you use.

We'll begin by exploring the business need for shared code at Quizlet. You'll learn about popular approaches to dealing with shared code across the industry, and we'll share how we identified which areas of our codebase that were good candidates for sharing cross-platform, and which were best left for platform-specific code.

We'll detail our initial foray into shared code using Javascript, and explain both its benefits and drawbacks.

We'll then switch gears and explore Kotlin Multiplatform -- Quizlet's current technology of choice for shared code. We'll share all the spicy details:

* How we evaluated Kotlin Multiplatform as a technology
* How writing and distributing Kotlin Multiplatform code works
* Our path to successfully migrating our shared codebase into this new paradigm
* The impacts of switching to Kotlin Multiplatform for both our developers and end-users (spoiler alert: better mobile developer experience, huge reductions to app size and crash rates on mobile platforms, and minimal overhead on web)
