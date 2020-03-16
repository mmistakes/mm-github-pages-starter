---
title: "Using HTML in ArcGIS JavaScript Popups"
categories:
  - ArcGIS
  - JavaScript
tags:
  - html
  - security
  - usability
  - update
  - popup
---

As a Technical Support Specialist at Esri, I have already received a few questions concerning changes to popups in the ArcGIS JavaScript API. As mentioned in the release notes [breaking changes](https://developers.arcgis.com/javascript/latest/guide/release-notes/#breaking-changes) section for version 4.14, an [HTML sanitizer](https://github.com/Esri/arcgis-html-sanitizer) was added to handle some security concerns. In this post I will talk about why it was added and how it will affect your development moving forward.

## Why sanitize HTML?
The main concern when allowing users to inject HTML into applications is Cross-Site Scripting (XSS) attacks. According to [OWASP](https://owasp.org/www-community/attacks/xss/):

> Cross-Site Scripting (XSS) attacks are a type of injection, in which malicious scripts are injected into otherwise benign and trusted websites. XSS attacks occur when an attacker uses a web application to send malicious code, generally in the form of a browser side script, to a different end user.

The HTML sanitizer used by the ArcGIS JavaScript API does a good job allowing some HTML, while removing potentially harmful code. For example, let's say you define your [Popup Template](https://developers.arcgis.com/javascript/latest/api-reference/esri-PopupTemplate.html) as 
```javascript
var template = {
    title:  "{OBJECTID}",
    content: "<i>The Name of this feature is {Name}</i><br><b><a href='https://services.arcgis.com/P3ePLMYs2RVChkJx/ArcGIS/rest/services/ACS_Marital_Status_Boundaries/FeatureServer/2'>Feature Service URL</a></b><br><img src='https://www.w3schools.com/images/w3schools_green.jpg' alt='W3Schools.com'>"
}
```
This clearly contains HTML. There is a link, an image, and bold/italicized text. However, the above popup will work fine because there is nothing 'dangerous' that may run a malicious script. Check out [this page](https://doc.arcgis.com/en/arcgis-online/reference/supported-html.htm) for a list of supported HTML tags.

The next code snippet contains a button with an onclick function.
```javascript
var template = {
    title:  "{OBJECTID}",
    content: "<input id='buttonId' class='btn btn-primary btn-block' type='button' value='Click Me' onclick='runCode({OBJECTID})' title='Clickable button in popup'>"
}
```
This code will be sanitized because it can be potentially harmful depending on what the onclick function does.


## What to do if your HTML is sanitized
The work around is to use a function to modify the [DOM node](https://www.w3schools.com/js/js_htmldom.asp) of the popup directly. This will get around the HTML sanitizer baked into the ArcGIS JavaScript API. So, in order to add a button to your popup you would define the template as
```javascript
var template = {
  content: function(){
    var div = document.createElement("div");
    div.className = "myClass";
    div.innerHTML = "<input id='buttonId' class='btn btn-primary btn-block' type='button' value='Click Me' onclick='runCode()' title='Clickable button in popup'>";
    return div;
  }
}
```
The above will work for most people. For the advanced users, you may have noticed a slight change between the two previous code snippets. The template which modifies the DOM node of the popup does not contain the [Arcade](https://developers.arcgis.com/javascript/latest/guide/arcade/) expressions. [Here is a sample](https://codepen.io/benesri/pen/ExjZoOg) that demonstrates how to use both Arcade and HTML in your popup.
