---
Title: Homelab Update
Date: 2021-05-01 18:00 -0800
Categories: tech Lab 2021
---

![](/assets/images/Network_Diagram_MAY2021.png)

Major changes from the [last](https://aidanb.net/Homelab-Setup/) update. Extra funds and extra motivation drove me to create this current setup.

Features:

- Vlan segregation at the Router layer.
- Active Directory domain environment.
- Backups over iSCSI to Synology NAS.
- Docker-Compose stack that hosts many of my internal services like Home Assistant, Plex, a Minecraft server, etc.
- Pihole for domain-wide DNS and ad-blocking.

![](/assets/images/homelab_2021.jpg)
Physical setup. 

I've colour-coded the ethernet cables as well:

- Red = Host
- Black = Storage
- Green = Main Network Infra
- Blue = IoT

This has been a great setup for continuing self learning in my field. I also delved deep into Home Assistant and all of it's smart-home features - which gives me ideas for more blog posts featuring Home Assistant. 

Some Future Goals for the lab:

- Internal Gitlab for PowerShell scripts.
- Learn Jenkins for Script Automation.
- Upgrade from Docker to K8s.
- More PowerShell.



