# 小白的工程实践与思考档案

这是一个基于 Minimal Mistakes GitHub Pages Starter 改造的中文个人网站。

网站定位不是学术主页，也不是传统技术教程站，而是“小白的个人作品、学习复盘与思考档案”。

## 当前版本

V0.1：完成可部署的基础结构、中文导航、首页、作品页、复盘页、理解页、关于页、两篇示例文章和新手学习文档。

## 网站结构

- 首页 `/`：自我介绍、当前关注方向、精选项目和最新文章入口。
- 作品 `/projects/`：记录项目简介、动机、技术、进展、问题、学习和计划。
- 复盘 `/reviews/`：记录项目推进后的阶段复盘。
- 理解 `/notes/`：记录对学过知识的个人理解。
- 关于 `/about/`：介绍我是谁、学习方向、正在做的项目和联系方式。

## 本地运行方法

先安装 Ruby 和 Bundler，然后在仓库根目录执行：

```powershell
bundle install
bundle exec jekyll serve
```

本地预览地址通常是：

```text
http://127.0.0.1:4000/
```

## 发布方法

本仓库用于 GitHub Pages 个人主页。推送到 `master` 分支后，在 GitHub 仓库 Settings -> Pages 中选择从 `master` 分支发布。

发布地址：

```text
https://bloodest761-ship-it.github.io/
```

## 如何添加文章

在 `_posts` 目录中新建 Markdown 文件，文件名格式为：

```text
YYYY-MM-DD-article-name.md
```

示例：

```text
_posts/2026-07-05-arm-first-version-review.md
```

文章开头需要 YAML Front Matter，例如：

```yml
---
title: "文章标题"
date: 2026-07-05 20:00:00 +0800
categories:
  - reviews
tags:
  - 复盘
---
```

## 下一阶段计划

- 用真实项目经历替换“待补充”内容。
- 为机械臂项目补充照片、结构说明和调试记录。
- 为 YOLO 学习补充模型训练、转换和部署记录。
- 继续完善 ONNX、NCNN、Linux 和软件工程相关学习笔记。
- 根据内容增长情况，再决定是否拆分更细的项目页面。

更多 Jekyll 新手说明见 `LEARNING_GUIDE.md`。
