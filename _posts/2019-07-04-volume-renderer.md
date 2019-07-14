---
layout: post
color: deep-purple
cover: "https://user-images.githubusercontent.com/51087091/60770080-36be4d00-a0a5-11e9-833b-d831dbd88b33.png"
title:  "DICOM Bone Volume Render"
date:   2019-07-04 00:00:00
categories: projects
---
Written in C++, uses the Visualization Toolkit (VTK) to read a Computed Tomography DICOM (*.dcm) image file and render its bone data. Only intensities above 350 Hounfield Units (HU) are rendered to allow the viewing of air cells in the temporal bones.  

### Right Ear Test
![R90(05)100(1)](https://user-images.githubusercontent.com/51087091/60770080-36be4d00-a0a5-11e9-833b-d831dbd88b33.png)

### Left Ear Test
![L90(05)100(1)](https://user-images.githubusercontent.com/51087091/60770156-fca17b00-a0a5-11e9-89e0-3d612381d283.png)

In this dataset, the program allowed to determine that the left temporal bone had a larger amount of air cells than the right temporal bone. 

### Technology used: 
>C++, CMake, The Visualization Toolkit (VTK), OpenGL, Visual Studio 2019, Github, Git Bash 

<span style="background-color: #CAC8C0; color: #fff; display: inline-block; padding: 3px 10px; font-weight: bold; border-radius: 5px;"> 
<a href="https://github.com/socd06/DCMBoneVolRender" target="_blank" class="mui-btn">
<i class="fa fa-github"></i> GitHub Repository </a> </span>


