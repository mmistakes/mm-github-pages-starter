---
title: "New Rakugo Docs and The Question Patch"
date: 2021-02-28
published: true
categories:
  - news
  - devlog
tags:
  - update
---

New Rakugo Docs and Patch for _The-Question_.

## Here are new RakugoDocs

Now hosted on **ReadTheDocs** and use the same software as **GodotDocs**.
<https://rakugodocs.readthedocs.io>
![](assets/imgs_main/docs.png)

They use also [**MyST**](https://myst-parser.readthedocs.io) so I can write it using **Markdown** instead of **reStructuredText**.
New docs uses more topic based approach similar too Ren'Py docs.

## "The Question" Patch

Our Discord server user _dBatareykin_ find out there was some bugs in _The Question_ and helped me fix them:

- fix Sylive sprites
- add missing `step()` in _book_ dialogue
- fix use of **ShowManager** and tags by **Label** node
- move setting `book` value to menu in _rightaway_ dialogue
- update menus ifs in dialogues
- Rakugo.StoreManager -> Rakugo.store
- fix bug that made `show("bg black")` stop the game.

[**You can download new _The-Question_ here**](/download)
