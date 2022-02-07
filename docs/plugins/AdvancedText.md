# AdvancedText

- [repo](https://github.com/rakugoteam/AdvancedText)
- [download](https://github.com/rakugoteam/AdvancedText/releases)
- docs (WIP)

Extends RichTextLabel and adds support for Markdown and RenPy
Soon there will be docs for most of the features.

## Features
- Supports Markdown and RenPy
- Variables use `<var>` in Markdown, Renpy and BBCode
- Adds headers supports RenPy and BBCode
- Support [Emojis For Godot](https://github.com/rakugoteam/Emojis-For-Godot) use `:emoji:`
- Adds **MarkupTextEditor** tool to the editor for easy editing text in nodes and files

### Nodes
- **AdvancedTextLabel** - A label that supports Markdown and RenPy
- **CodeEdit** - A text edit that supports Markdown, RenPy, BBCode, GDScript and JSON all with code highlighting

### Examples
- **AdvancedTextButton** - how combine **AdvancedTextLabel** with a **Button**
- **EditTextOnClick** - how combine **AdvancedTextButton** with a **CodeEdit**, so you can edit the text on click
- **EditTextOnClickPopup** - the same as **AdvancedTextButton** but with use popup
- **TextBrowser** - a simple text browser that supports Markdown, RenPy and BBCode, links to other text files in project and web links