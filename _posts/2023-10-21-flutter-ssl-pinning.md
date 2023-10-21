---
title: "Bypassing SSL Pinning in Flutter apps"
date: 2023-12-21T22:14:10+07:00
categories:
  - blog
tags: 
  - tutorial
  - tips
  - mobile
  - pentesting
---
There are 2 main ways to bypass SSL pinning protection in mobile apps. 1 is by patching the app binary direcly, and the 2nd is by hooking the app's function call that handles the SSL cert chain verification. Same goes for Flutter apps..

# 1. Patching the Application File 
The most common approach of doing this for Flutter apps is by using [reFlutter](https://github.com/ptswarm/reFlutter). This works by patching the `socket.cc` and `dart.cc` of the Flutter Engine to bypass certificate validation, monitoring network traffic, and printing function calls as well.

To do it, first install reflutter using pip.
```
pip3 install reflutter
```

Then grab your target apps, and run them to `reflutter`.
```
reflutter main.apk
```
If it's working properly then it would shown something like this.
```
C:\Users\zr\apk>reflutter app-1.3.apk

 Choose an option:

 1. Traffic monitoring and interception
 2. Display absolute code offset for functions

 [1/2]? 1

Is this really a Flutter app?
There was no libapp.so (Android) or App (iOS) found in the package.

 Make sure there is arm64-v8a/libapp.so or App.framework/App file in the package. If flutter library name differs you need to rename it properly before patching.
 ```
 After that, you'll need to re-align and sign the patched APK. You can do this by [using uber-jar-signer](https://github.com/patrickfav/uber-apk-signer).
 ```
 C:\Users\zr\apk>java -jar C:\Tools\uber-jar-signer -a release.RE-aligned-debugSigned.apk
 ```
 After that you can proceed to install and run the application.