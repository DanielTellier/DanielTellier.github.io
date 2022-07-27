# Vimscript to Lua

## Objective
Provide examples of converting vimscript to lua in a neovim configuration.

## Table of Contents
- [Config References](#config-references)
- [Folder Structure](#folder-structure)

## Config References
- <a href=
  "https://github.com/DanielTellier/dotfiles/tree/master/nvim/nvim.old"
  target="_blank">
  Vimscript Config
  </a>
- <a href=
  "https://github.com/DanielTellier/dotfiles/tree/master/nvim"
  target="_blank">
  Lua Config
  </a>

## Folder Structure
<table>
  <tr>
  <th>Vimscript</th>
  <th>Lua</th>
  </tr>
  <tr>
  <td>
  <code>
  ~/.config/nvim
  ├── after
  │   └── ftplugin
  │       └── c.vim
  ├── colors
  │   └── monokai.vim
  ├── compiler
  │   └── c.vim
  ├── doc
  │   └── notes.md
  ├── init.lua
  ├── lua
  │   ├── mappings.lua
  │   ├── plugins
  │   │   ├── finder.lua
  │   │   └── session.lua
  │   └── settings.lua
  └── plugin
      ├── finder.vim
      └── session.vim
  </code>
  </td>
  <td>
  <code>
  ~/.config/nvim
  ├── after
  │   └── ftplugin
  │       └── c.vim
  ├── autoload
  │   └── ft
  │       └── calter.vim
  ├── compiler
  │   └── c.vim
  └── init.vim
  </code>
  </td>
  </tr>
</table>

