---
date: 2020-08-03 13:00:00 -0700
title: More Apple and ARM Thoughts
categories:
- x86
- ARM
- Apple

---
OK, I've had some time to digest and think about this some more.  I've also been watching the industry/community response to the announcement.

## Surprising industry reaction

The most interesting thing I've seen is kind of an "ARM is rising!" attitude.  Now, Intel has been struggling as of late, not just with delivering innovation in the consumer space (i.e. what matters to Apple) but also in it's semiconductor processes (see [here](https://arstechnica.com/gadgets/2020/07/heads-roll-at-intel-after-7nm-delay/) for more details.)  However, I didn't expect the "piling-on" of the industry onto Intel during its woes -- although I probably shouldn't have been surprised, it's kind of what the industry does (e.g. think of PowerPC and how it was in Xbox360 and Playstation 3 but _not_ in their successors.)  Now POWER is only in IBM's stable.

## A lot of the world is still x86 (for now)

Another thing that I saw (and 100% agree with) is the concern around virtualization/x86 compatibility.  This can have an impact in a couple of areas...

**First, local binaries:**  Rosetta 2 is fine for _local_ applications (emulating/transpiling local apps on the Mac) but what about running Windows VM's that need to be x86?  I mean, the primary reason I, and most other people, run Windows VM's is because there is software that isn't Mac native that is needed for our jobs.  It's naive to think that these apps will "magically" appear on ARM/macos or that there will even be a 100% ARM-compatible build of these tools, therefore the efficacy of running a windows x86 VM becomes quite important.  This issue could very well negate or even reverse the penetration Macs have made into the corporate space over the past few years.

**Second, software development:**  there is still the very real need around software development of applications that will run on x86 servers.  Now, there is a great deal more availability of cloud resources for development, and that can negate these concerns to a large degree; however, the whole tenet of running the same code in production as in development (as provided by containers/docker) now flies out the window.  Having a separate container for development (necessitated by ARM architecture) when you're running x86 in production becomes a net-new speed bump that wasn't there in the past.  Again, the rise of ARM in the datacenter helps this, but I doubt it will be a 100% transition and definitely not overnight, in any case.  More to think about here, for sure...

## Final thoughts

Final thoughts for today...I think that everyone saw this coming, and it was definitely a matter of _when_ and not _if_ this transition would occur. Apple has proven that when they control the whole hardware/software stack they can do amazing things.  This is the first time that they will be able to do this in the Mac space, so I expect Macs to become "Insanely Greater" in short order.  However, it doesn't matter how great they are if people can't/won't use them, and given that phones have largely taken over as people's primary computing device, it remains to be seen whether Apple has enough loyal followers in the Mac space to make it a success.