# Vimscript to Lua

## Objective
Provide examples of converting vimscript to lua in a neovim configuration.

## Table of Contents
- [Folder Structures](#folder-structures)
- [Config References](#config-references)

## Folder Structures
- Vimscript
```shell
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
```
- Lua
```shell
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
```

- Lua Plugins
```shell
~/.config/nvim
├── doc
│   └── notes.md
├── init.lua
├── lua
│   ├── colorscheme.lua
│   ├── keymappings.lua
│   ├── lsp.lua
│   ├── plugins
│   │   ├── cmp.lua
│   │   ├── cokeline-nvim.lua
│   │   ├── floaterm-vim.lua
│   │   ├── lspsaga.lua
│   │   ├── lualine.lua
│   │   ├── null-ls.lua
│   │   ├── nvim-autopairs.lua
│   │   ├── nvim-metals.lua
│   │   ├── nvim-tree.lua
│   │   ├── nvim-ts-autotag.lua
│   │   ├── settings.lua
│   │   ├── tree-sitter.lua
│   │   └── vim-bbye.lua
│   ├── plugins.lua
│   └── settings.lua
└── plugin
    └── packer_compiled.lua
```

## Config References
- <a href=
  "https://github.com/DanielTellier/dotfiles/tree/master/vim"
  target="_blank">
  Vimscript Config
  </a>
- <a href=
  "https://github.com/DanielTellier/dotfiles/tree/master/nvim"
  target="_blank">
  Lua Config
  </a>

- <a href=
  "https://github.com/DanielTellier/dotfiles/tree/master/nvim/lua/plugins"
  target="_blank">
  Lua Plugins Config
  </a>
