---
Title: Setting up a Reverse Proxy With Traefik Using Docker-Compose
Date: 2020-08-10 12:15 -0800
Categories: tech 2020 homelab
---

### Intro

I wanted a way to both view my containers within my homelab using a domain name, and also have a system to manage routing between containers. I discovered [Traefik](https://containo.us/traefik/) , Open source, easy to use, serverless, edge router. 

This post will serve as a guide to setting up a reverse-proxy using Traefik and Docker. There's a few requirements before we need to get started, you will need the following:

- A domain  
- Server environment/homelab
- Some Docker and dns knowledge

#### Part 1 - DNS

Everyone's favourite - DNS! To ensure that the end product is achievable we have to play around with dns. For dns record management and SSL certificates, look no further than [CloudFlare](https://www.cloudflare.com/). CloudFlare will provide secure SSL to our domain and be used to manage the subdomains that will be created shortly.

First, the domain provider that you are using will have to be set to use CloudFlare's nameservers. I'm using [Namecheap](namecheap.com) as my domain name provider. You can use any that you want, just make sure that they allow the use of wildcard(*) records. Namecheap provides a guide on how to setup DNS records with Cloudflare [here](https://www.namecheap.com/support/knowledgebase/article.aspx/9607/2210/how-to-set-up-dns-records-for-your-domain-in-cloudflare-account).

Essentially what we are doing here is adding CloudFlares nameservers to our domain provider:

![](/assets/images/nameservers.png)

