---
title: A Journey in Shared Code with Kotlin Multiplatform
date: 2019-07-03
categories: speaking
feature: true
tags:
  - android
  - kotlin
  - kotlin multiplatform
excerpt: "droidcon Berlin: July 3, 2019. <br>My first time speaking at a conference!"
header:
  overlay_color: "#333"
  teaser: /assets/images/droidcon_berlin_2019.jpg
  actions:
    - label: "Video"
      url: "https://www.droidcon.com/media-detail?video=374874028"
    - label: "See the Slides"
      url: "https://speakerdeck.com/ankushg/a-journey-in-shared-code-with-kotlin-multiplatform-droidcon-berlin-2019"
---

{% include video id="374874028" provider="vimeo" %}

Hear the story of how we shipped Kotlin Multiplatform across Android, iOS, and the Web to power Quizlet’s learning experience for over 50 million users per month.

By pinpointing the best areas of our already mature codebase to share (and intentionally skipping over many others), Quizlet was able to use Kotlin Multiplatform to share the “secret sauce” of our product without shackling our Android, iOS, and Web clients to a predetermined architecture.

We drastically reduced the size of our Android app, achieved performance and stability wins across both iOS and Android, simplified our Web build process, and unlocked the ability for mobile and backend engineers to work confidently on this shared code -- but we also faced several speed bumps along the way.

Learn how we overcame challenges such as platform-specific quirks of the Kotlin standard library, constantly evolving tooling, and many more to make the magic happen!
