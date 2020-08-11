---
date: 2020-06-21 18:18:11 -0700
title: Apple and ARM eh?
categories:
- x86
- arm
- apple

---
So, the whole world seems to think that Apple is going to ditch x86 and move to their home-grown ARM processors in their Mac line as of WWDC this year.  On the one hand, I think that it is probably an inevitable move, especially given the Apple worldview of wanting to own their whole supply chain and of viewing their products as a hardware+software system, vs a platform+OS.  

I'm of mixed opinions on whether it is a good idea, though.  Let's break down the PRO's and CON's...

## PRO's:

* Full vertical integration of a key product line:  
  This is probably the biggest one right here.  We've seen with the iPhone and the iPad how effective Apple is at delivering a fully-optimized solution where there is really no line between the hardware and software.  This is exactly what they want -- the ability to deliver an _experience_ and specific _capabilities_ not a _platform_ with _features_. This is probably their biggest driver, TBH
* Margins:  
  While technically part of the previous note (i.e. vertical integration) I think it speaks to a different motivation.  Not having to pay Intel for x86 CPU's means there's one fewer supplier in the mix, which gives them not only better profit margins on the product, but also more flexibility to price the product competitively in the market.
* Performance:  
  The single-core performance of the Apple A-class CPU's has been killing the competition for years now.  While there is room for multi-core performance, I think it is safe to say that when starting to optimize for the Mac use case, Apple probably hasn't unveiled all their tricks with this architecture yet.  What's more, this would be their 3rd architecture shift (m64k -> PPC -> x86 -> ARM) so they are more skilled than most at understanding how their platform plays across different architectures and probably has a good handle on what would truly make the _best_ Mac CPU.
* Power:  
  Now, I tend to think of power consumption as a performance metric, but I think that most people separate it out, so I'll do the same thing.  ARM CPU's are historically less power-hungry than x86 CPU's so there is the real possibility of being able to refactor the power and space budgets in mobile Macs to account for this.  We can either look forward to smaller Macs that have the same power budgets and/or longer lasting Macs in the same form factors we are used to.  This isn't just limited to an x86 -> ARM transition, either.  I'd expect mobile Macs to use a SoC (system-on-chip) design that is optimized for their role (consumer/pro/creative/etc.) and this, coupled with complete macOS control, means that we could even see greater gains than predicted.

## CON's:

* It's not x86:  
  Now, I know that there are a lot of reasons that this is less of a big deal than it may have been in the past, but this is still true: the **WORLD** runs on x86 still, _for the moment_.  It's that last bit that's important though.  With Amazon's Graviton CPU instances, and more and more ARM server development, x86 might not have the choke-hold it once had on the industry; however, the bulk of today's software still runs on x86 and there is a large back catalog of x86 software that still has to be accounted for.  In the Mac world, specifically, there are interesting facets to having LLVM be the default toolchain that can allow Apple to move compiled binaries across architectures. We also must remember that they're masters at having done this before (see above) and have made the transition as smooth as possible each time.  However, that fails to account for users needing x86 virtualization (Virtualbox or VMware, etc.) for all of the non-Mac software out there that is still x86.  I am not sure how that can easily be remedied on an ARM platform.
* End-user perception:  
  Related quite a bit to the previous item is the fact that end-users will no longer have the "warm fuzzies" that they can always run Linux or Windows on a Mac.  Now, while Linux is still in the cards for ARM-based laptops, and Windows is _sorta_ there with ARM, a lot will depend on how closed or open the platform ends-up being.  x86 Macs use UEFI, so they can boot other operating systems with a little effort.  If Apple goes with UEFI for ARM, then things are still relatively smooth, but if they go more like they have for the iPhone and iPad, then these platforms will essentially be closed, and that could have a rather negative effect on user perception.  The Mac faithful will go along with things, regardless, and be vocal (as they should) on where Apple can improve, but if the perception of a more casual user is that the platform is limited or closed, then it could cool-down the enthusiasm for Macs.

Overall, I'm on the fence.  I can see it from both sides and this is all still rampant speculation on everyone's part until the facts emerge.  I can see Apple doing an ARM transition across the line, and I can also see them doing a partial transition with x86 staying in some models to account for x86-specific things that need to be done.  I don't know if it is in-character for Apple to have a split-architecture product line, but since they've had x86 and ARM living together for years already, it's not unprecedented -- just new in the same product family, where it to be intentional and not a transitional situation.

Anyways, we'll see come this week.  