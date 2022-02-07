![github-top-lang][lang] ![lic] ![emojis-lic]
# Emojis for Godot

- [repo](https://github.com/rakugoteam/Emojis-For-Godot)
- [download](https://github.com/rakugoteam/Emojis-For-Godot/releases)
- docs (WIP)

Emoji mode use ![emojis-lic] [Twemoji](https://twemoji.twitter.com/).

This addon provides the following nodes to use emojis in Godot:
- **EmojiIcon**: A node that displays an Emoji.
- **EmojiButton**: A node that displays an Emoji as a button.

It's also adds **EmojiFinder** to the Godot editor's toolbar.
So you can find the emojis easily.

![EmojiFinder Screen Shot](assets/screenshot_ef.png)

## Using it with RichTextLabel

From version 1.3 you can use emojis in RichTextLabel.

This is the example code of using emojis in RichTextLabel:
```gdscript
extends RichTextLabel

var emojis = Emojis.new()
export var text_with_emojis := "some emoji :sunglasses:"
 
func _ready():
	bbcode_enabled = true
	bbcode_text = emojis.parse_emojis(text_with_emojis)
```
This is the result of the above code:

![RichTextLabel Example Screen Shot](assets/screenshot_rtl.png)

## Exporting
For emojis to work in exported projects, you need add `*.json` files to include files settings:
![include files settings](assets/screenshot_export.png)

[**TexturePacker**](https://www.codeandweb.com/texturepacker) is used to generate the emoji atlases.

[lic]: https://img.shields.io/github/license/rakugoteam/Emojis-For-Godot?style=flat-square&label=📃%20License&
[lang]: https://img.shields.io/github/languages/top/rakugoteam/Emojis-For-Godot?style=flat-square
[emojis-lic]: https://img.shields.io/badge/license-CC0%201.0-orange.svg?style=flat-square&label=📃%20Emojis%20License&

