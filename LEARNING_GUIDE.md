# Jekyll 新手学习指南

这份文档面向完全不了解 Jekyll 的新手，用当前仓库作为例子说明这个网站是怎么工作的。

## 1. GitHub Pages 是什么

GitHub Pages 是 GitHub 提供的静态网站托管服务。

这个仓库名是 `bloodest761-ship-it.github.io`，它适合用来发布个人主页。代码推送到 GitHub 后，GitHub Pages 会把仓库里的 Jekyll 网站构建成可以访问的网页。

## 2. Jekyll 是什么

Jekyll 是一个静态网站生成器。它不会像后台系统那样运行数据库，而是把 Markdown、YAML 配置和主题模板生成静态 HTML 文件。

当前仓库使用 Jekyll 生成网站，核心配置在 `_config.yml`。

## 3. Minimal Mistakes 是什么

Minimal Mistakes 是一个 Jekyll 主题。它已经提供了导航栏、文章页、作者侧边栏、搜索、响应式布局等常用功能。

当前仓库在 `_config.yml` 中通过下面这一行使用主题：

```yml
remote_theme: "mmistakes/minimal-mistakes"
```

这表示网站不需要把主题源码全部放进仓库，而是在构建时使用远程主题。

## 4. Markdown 如何变成网页

Markdown 是一种简单的写作格式。比如 `_posts/2026-07-05-arm-first-version-review.md` 是一篇文章。

Jekyll 构建时会读取这个 Markdown 文件，把标题、日期、分类等 Front Matter 信息交给主题模板，再把正文转换成网页内容。

## 5. `_config.yml` 负责什么

`_config.yml` 是全站配置文件。

它负责网站标题、描述、作者信息、主题、插件、永久链接、搜索开关和默认页面设置。比如当前网站标题是：

```yml
title: "小白的工程实践与思考档案"
```

如果以后要改网站名称，优先改这里。

## 6. `_data/navigation.yml` 负责什么

`_data/navigation.yml` 负责顶部导航栏。

当前导航是：

```yml
main:
  - title: "首页"
    url: /
  - title: "作品"
    url: /projects/
```

如果以后要新增“资源”页面，就可以在这里增加一项。

## 7. `_pages` 负责什么

`_pages` 用来存放固定页面。

当前仓库里的例子包括：

- `_pages/projects.md`：作品页，对应 `/projects/`
- `_pages/reviews.md`：复盘页，对应 `/reviews/`
- `_pages/notes.md`：理解页，对应 `/notes/`
- `_pages/about.md`：关于页，对应 `/about/`

页面能被 Jekyll 处理，是因为 `_config.yml` 中包含了：

```yml
include:
  - _pages
```

## 8. `_posts` 负责什么

`_posts` 用来存放文章。

文章文件名必须符合：

```text
YYYY-MM-DD-title.md
```

例如：

```text
_posts/2026-07-05-onnx-ncnn-understanding.md
```

Jekyll 会根据文件名和 Front Matter 识别文章日期、标题、分类和链接。

## 9. YAML Front Matter 是什么

YAML Front Matter 是 Markdown 文件开头被三条横线包起来的配置区。

例如：

```yml
---
title: "我现在如何理解ONNX和NCNN"
date: 2026-07-05 11:00:00 +0800
categories:
  - notes
---
```

它告诉 Jekyll：这篇文章叫什么、什么时候发布、属于哪个分类。

## 10. 如何新增一篇文章

第一步，在 `_posts` 里新建文件，例如：

```text
_posts/2026-07-06-linux-learning-review.md
```

第二步，写入 Front Matter：

```yml
---
title: "一次 Linux 学习复盘"
date: 2026-07-06 20:00:00 +0800
categories:
  - reviews
tags:
  - Linux
---
```

第三步，在下面写正文。保存后本地构建，推送到 GitHub，网站就会更新。

## 11. 如何新增一个项目

第一版项目都写在 `_pages/projects.md`。

新增项目时，可以复制已有项目结构：

```md
## 项目名称

### 项目简介

待补充。

### 为什么开始

待补充。
```

如果以后项目很多，可以再拆成单独的项目页面，但 V0.1 先保持简单。

## 12. 如何修改网站标题和个人信息

网站标题、描述和作者信息在 `_config.yml`。

常改的位置包括：

```yml
title: "小白的工程实践与思考档案"
description: >-
  一个记录个人作品、学习复盘与思考档案的中文网站。
author:
  name: "小白"
  bio: "正在学习机器人、嵌入式、人工智能与软件工程的本科生。"
```

关于页的正文在 `_pages/about.md`，可以补充更真实的介绍和联系方式。

## 13. 如何提交代码并更新网站

修改完成后，通常执行：

```powershell
git status
git add .
git commit -m "Update personal site v0.1"
git push origin master
```

推送成功后，到 GitHub 仓库的 Settings -> Pages 检查发布来源是否是 `master` 分支。GitHub Pages 构建完成后，网站会更新到：

```text
https://bloodest761-ship-it.github.io/
```
