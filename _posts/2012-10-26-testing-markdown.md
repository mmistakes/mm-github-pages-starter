---
title: "Testing Markdown"
date: 2012-10-26 14:11
categories:
  - markdown
---

Lightweight Markup Languages
============================

According to **Wikipedia**:

> A [lightweight markup language](http://is.gd/gns)
is a markup language with a simple syntax, designed 
to be easy for a human to enter with a simple text 
editor, and easy to read in its raw form. 

Some examples are:

* Markdown
* Textile
* BBCode
* Wikipedia

Markup should also extend to _code_: 

``` perl compute_average.pl
#!/usr/bin/perl

$count = 0;
while (<stdin>) {
    @w = split;
    $count++;
    for ($i=0; $i<=$#w; $i++) {
	$s[$i] += $w[$i];
    }
}

for ($i=0; $i<=$#w; $i++) {
    print $s[$i]/$count, "\t";
}

print "\n";
```
