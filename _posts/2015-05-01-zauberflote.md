---
title: "Zauberflöte: A Transparent Peer-to-Peer CDN"
categories: academia
---

Zauberflöte is a peer-to-peer content delivery network. The system uses WebRTC to cache and distribute content between peers.

Zauberflöte provides an easily accessible way for developers to alleviate content delivery bandwidth concerns by marking DOM elements such that Zauberflöte will fetch these resources from peers with that resource.

The Zauberflöte system has server-side tracker and WebRTC signaling channel components, as well as client-side scripting that requests and delivers content between peers.

This version of the system implements basic chunking, parallelism, and fault tolerance.

In this paper, we describe the motivation for Zauberflöte and the design and implementation of the different components that comprise the system. We then detail future improvements that could be made to increase the robustness and performance of the overall system.

Preliminary data shows that the system performs well under medium and high workloads, and when the seeder-to-leecher ratio is high.

Future work could refine the system such that it works well in a wide variety of scenarios. Our results show that peer-to-peer CDNs are a promising low-cost alternative to CDNs that require an extensive network of server and server infrastructure.

[Github](https://github.com/anishathalye/zauberflote)

[Download the paper](/assets/docs/zauberflote-2015.pdf)
