---
Title: Setting up a Reverse Proxy With Traefik Using Docker-Compose
Date: 2021-03-20 4:30 -0800
Categories: tech 2021 homelab
---

### Intro

I wanted a way to both view my services running within my homelab remotely, secured via ssl, and also have a system to manage routing between containers. I discovered [Traefik](https://containo.us/traefik/) , Open source, easy to use, serverless, edge router. 

This post will serve as a guide to setting up a reverse-proxy using Traefik and Docker. There's a few requirements before we need to get started, you will need the following:

- A domain  
- Server environment/homelab
- Some Docker and dns knowledge

#### Part 1 - DNS

Everyone's favourite - DNS! To ensure that the end product is achievable we have to play around with dns. For dns record management and SSL certificates, look no further than [CloudFlare](https://www.cloudflare.com/). CloudFlare will provide secure SSL to our domain and be used to manage the subdomains that will be created shortly.

First, the domain provider that you are using will have to be set to use CloudFlare's nameservers. I'm using [Namecheap](namecheap.com) as my domain name provider. You can use any that you want, just make sure that they allow the use of wildcard(*) records. Namecheap provides a guide on how to setup DNS records with Cloudflare [here](https://www.namecheap.com/support/knowledgebase/article.aspx/9607/2210/how-to-set-up-dns-records-for-your-domain-in-cloudflare-account).

Essentially what we are doing here is adding CloudFlares nameservers to our domain provider:

![](/assets/images/nameservers.png)

Now in the DNS settings from your domain on CloudFlare we will first create the inital A record. This A record will have the content of your public facing WAN IP address, and the name will be your domain name.

![](/assets/images/arecord.png)

Next let's establish a method for the services using subdomains. Each service that will be deployed should start with the name of it followed by your domain name as a CNAME record. Let's start with Traefik. 

![](/assets/images/cnamerecord.png)

That's it for the dns side of things! 


#### Part 2 - Traefik Deployment

###### For this guide and my environment I'll be deploying Traefik with Docker - specifically Docker-Compose. This guide assumes you have Docker installed and working in your environment.

First things first - ports 443 and 80 will need to be port forwarded through your router from the server hosting Traefik.

Next create a new Docker network for proxy services with ```docker network create proxy```.

Now create a new directory for your new Traefik services with an acme.json and a traefik.yml. For example here is how my directories are structured:

![](/assets/images/directory_structure.png)

the acme.json file is where the ssl certs are created and stored by CloudFlare - this file will need Root privileges: ```sudo chmod 644 acme.json```. Nothing else needs to be done with acme.json.


In the traefik.yml however will need some config options. This is the main configuration file for traefik. Here is mine below:

```yaml
# Traefik configuration 
api:
  dashboard: true
# Specify http and https  
entryPoints:
  http:
    address: ":80"
  https:
    address: ":443"
# specify Docker as main provider and give it access to the Docker socket.
providers:
  docker:
    endpoint: "unix:///var/run/docker.sock"
    exposedByDefault: false
# Tell Traefik to look in acme.json for ssl certs.  
certificatesResolvers:
 http:
  acme:
    email: youremailhere@gmail.com
    storage: acme.json
    httpChallenge:
        entryPoint: http
```

In order for us to be authenticated into the frontend for Traefik you'll need to create a username and password using htpasswd:

install htpasswd on Ubuntu Server: ```sudo apt-get install apache2-utils```

Now create the user for traefik: ```htpasswd -nb user PASSWORD_HERE```

Save the output somewhere secure. You'll be using it shortly.

Now create the docker-compose.yml in the root of the traefik directory:

```Yaml
version: '3'

services:
  traefik:
    image: traefik:v2.0
    container_name: traefik_rp
    restart: unless-stopped
    # CloudFlare DNS servers
    dns:
      - 1.1.1.1
      - 1.0.0.1
    security_opt:
      - no-new-privileges:true
    # Tag the proxy network created earlier
    networks:
      - proxy
    ports:
      - 80:80
      - 443:443
    # Make sure to pass the acme.json and traefik.yml to the container as volumes.
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - ./traefik/acme/traefik.yml:/traefik.yml:ro
      - ./traefik/acme/acme.json:/acme.json
    # Important and needed 
    labels:
    # Enable traefik as a service
      - "traefik.enable=true"
      - "traefik.http.routers.traefik.entrypoints=http"
      - "traefik.http.routers.traefik.rule=Host(`traefik.example.xyz`)"
    # HTPASSWD 
      - "traefik.http.middlewares.traefik-auth.basicauth.users=YOURHTPASSUSER:PASSWORDHERE
      - "traefik.http.middlewares.traefik-https-redirect.redirectscheme.scheme=https"
      - "traefik.http.routers.traefik.middlewares=traefik-https-redirect"
      - "traefik.http.routers.traefik-secure.entrypoints=https"
      - "traefik.http.routers.traefik-secure.rule=Host(`traefik.example.xyz`)"
      - "traefik.http.routers.traefik-secure.middlewares=traefik-auth"
      - "traefik.http.routers.traefik-secure.tls=true"
      - "traefik.http.routers.traefik-secure.tls.certresolver=http"
      - "traefik.http.routers.traefik-secure.service=api@internal"

networks:
  proxy:
    external: true
```
 
 Now run ```docker-compose up -d``` to bring the container up! You may get a 500 error as it could take up to 24 hours for your domain to propagate.

 Go to traefik.yourdomain.xyz and login using the htpass credential, and you should see a dashboard like this:

 ![](/assets/images/traefik_dashboard.png)

 #### Part 3 - Adding other services to Traefik

 You'll now be able to use traefik to give ssl to your other services running in Docker containers!

 As an example of how to do this I'll showcase [Portainer](https://www.portainer.io/). Portainer is a web based gui platform for managing containers.

 Here's the docker-compose file for my Portainer service:

 ```yaml
version: '3'

services:
  portainer:
      image: portainer/portainer:latest
      container_name: portainer
      restart: unless-stopped
      security_opt:
        - no-new-privileges:true
      networks:
        - proxy
      volumes:
        - /etc/localtime:/etc/localtime:ro
        - /var/run/docker.sock:/var/run/docker.sock:ro
        - ./portainer/data:/data
      labels:
        - "traefik.enable=true"
        - "traefik.http.routers.portainer.entrypoints=http"
        - "traefik.http.routers.portainer.rule=Host(`portainer.example.xyz`)"
        - "traefik.http.middlewares.portainer-https-redirect.redirectscheme.scheme=https"
        - "traefik.http.routers.portainer.middlewares=portainer-https-redirect"
        - "traefik.http.routers.portainer-secure.entrypoints=https"
        - "traefik.http.routers.portainer-secure.rule=Host(`portainer.example.xyz`)"
        - "traefik.http.routers.portainer-secure.tls=true"
        - "traefik.http.routers.portainer-secure.tls.certresolver=http"
        - "traefik.http.routers.portainer-secure.service=portainer"
        - "traefik.http.services.portainer.loadbalancer.server.port=9000"
        - "traefik.docker.network=proxy"
  
networks:
  proxy:
    external: true
 ```

 Pretty easy! Just remember to add the new CNAME record for the service in CloudFlare or it you'll get a 404 error.

 
