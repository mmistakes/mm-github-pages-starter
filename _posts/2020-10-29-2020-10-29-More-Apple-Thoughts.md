---
title: More Apple Thoughts
date: 2020-10-29 13:30
categories:
- x86
- arm
- apple 
---

I've been thinking more and more about Apple's move to "Apple Silicon" _nee ARM_ in their upcoming Macs.  I still stand my my earlier thoughts around the viability of having a non-x86 machine in the x86-centric world we (still) work in:

> Now, I know that there are a lot of reasons that this is less of a big deal than it may have been in the past, but this is still true: the **WORLD** runs on x86 still, _for the moment_.  It's that last bit that's important though.  With Amazon's Graviton CPU instances, and more and more ARM server development, x86 might not have the choke-hold it once had on the industry; however, the bulk of today's software still runs on x86 and there is a large back catalog of x86 software that still has to be accounted for.  In the Mac world, specifically, there are interesting facets to having LLVM be the default toolchain that can allow Apple to move compiled binaries across architectures. We also must remember that they're masters at having done this before (see above) and have made the transition as smooth as possible each time.  However, that fails to account for users needing x86 virtualization (Virtualbox or VMware, etc.) for all of the non-Mac software out there that is still x86.  I am not sure how that can easily be remedied on an ARM platform.

I think that this still stands. I've seen others talk about this as well, echoing the same concerns, too.  The fundamental issue relates to what we tend to call "legacy" software.  There are still quite a bit of applications that are native-only, and that require Windows (on x86) to run.  They are becoming fewer over time, but as legacy apps hit their steady-state "niche" the desire that organizations have to throw any money at fixing them goes **WAY** down.  Currently, the "just run it in a VM" mentality has been getting people by -- both for those who need to run things on MacOS as well as those who need to run things on _older versions of Windows_.  

Just the other day I had to install Windows 2000 (yep, THAT) to get an old .NET application to run correctly for a piece of hardware.  Now, this hardware is 100% functional, and is 100% modern in almost every feature _except software_ and since I don't have any open-source option for the software, I was stuck running Win2K in a VM to run the app (which ran _beautifully_ on my mac inside of VMware Fusion, FWIW!)

It just got me thinking, once again, about the riskiness of Apple's strategy -- it doesn't matter how long my battery life is, or how well my integrated hardware/software system is if I can't run the apps I need to in order to get my job done.  I don't want to switch, and I hope I won't have to.