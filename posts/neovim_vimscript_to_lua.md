# Vimscript to Lua

## Objective
Provide examples of converting vimscript to lua in a neovim configuration.

## Table of Contents
- [Folder Structure](#folder-structure)
- [Config References](#config-references)

## Folder Structure
- Vimscript
```shell
~/.config/nvim<br>
├── after<br>
│   └── ftplugin<br>
│       └── c.vim<br>
├── autoload<br>
│   └── ft<br>
│       └── calter.vim<br>
├── compiler<br>
│   └── c.vim<br>
└── init.vim
```
- Lua
```shell
~/.config/nvim<br>
├── after<br>
│   └── ftplugin<br>
│       └── c.vim<br>
├── colors<br>
│   └── monokai.vim<br>
├── compiler<br>
│   └── c.vim<br>
├── doc<br>
│   └── notes.md<br>
├── init.lua<br>
├── lua<br>
│   ├── mappings.lua<br>
│   ├── plugins<br>
│   │   ├── finder.lua<br>
│   │   └── session.lua<br>
│   └── settings.lua<br>
└── plugin<br>
    ├── finder.vim<br>
    └── session.vim
```

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

