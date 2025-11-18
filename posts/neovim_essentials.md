# Neovim Essentials

Practical guide to daily Neovim usage with real examples.

## Install/Setup

Install Neovim:

```bash
# macOS
brew install neovim

# Ubuntu/Debian
sudo apt install neovim

# Arch Linux
sudo pacman -S neovim

# Or download from https://github.com/neovim/neovim/releases
```

Clone my config:

```bash
git clone https://github.com/DanielTellier/nvim-config ~/.config/nvim
nvim  # First launch installs plugins
```

## Key Movements

Master these first:

```
h j k l         # left, down, up, right
w b             # word forward/back
0 $             # line start/end
gg G            # file start/end
{ }             # paragraph up/down
Ctrl-d Ctrl-u   # half page down/up
f<char>         # find character forward
```

## Yank/Paste

Basic operations:

```
yy          # yank (copy) current line
y           # yank visual selection
yw          # yank word
y$          # yank to end of line
yap         # yank paragraph

p           # paste after cursor/line
P           # paste before cursor/line
```

System clipboard integration:

```
"+y         # copy to clipboard (visual mode)
"+yy        # copy line to clipboard
"+p         # paste from clipboard (after)
"+P         # paste from clipboard (before)
```

## Key Mappings

Basic keymaps:

```lua
vim.g.mapleader = ' '
local map = vim.keymap.set

-- File operations
map('n', '<leader>w', ':w<CR>', { desc = 'Save' })
map('n', '<leader>q', ':q<CR>', { desc = 'Quit' })

-- Window navigation
map('n', '<C-h>', '<C-w>h', { desc = 'Left window' })
map('n', '<C-j>', '<C-w>j', { desc = 'Down window' })
map('n', '<C-k>', '<C-w>k', { desc = 'Up window' })
map('n', '<C-l>', '<C-w>l', { desc = 'Right window' })
```

## Substitutions

```vim
:s/old/new/       # first on line
:s/old/new/g      # all on line
:%s/old/new/g     # all in file
:%s/old/new/gc    # with confirmation
:'<,'>s/old/new/g # visual selection
```

## Surround

```lua
return { 'tpope/vim-surround' }
```

Usage:

```
ys<motion><char>  # add surround (ysiw" surrounds word)
ds<char>          # delete surround (ds" removes quotes)
cs<old><new>      # change surround (cs"' changes quotes)
```

## Window Movement

Split and navigate:

```vim
:vsplit  # or Ctrl-w v (vertical)
:split   # or Ctrl-w s (horizontal)
Ctrl-w h/j/k/l   # navigate windows
Ctrl-w =         # equalize size
Ctrl-w q         # close window
```

## Navigation: Flash

Quick jump to any location on screen:

```lua
return {
  'folke/flash.nvim',
  keys = {
    { 's', function() require('flash').jump() end, mode = { 'n', 'x', 'o' }, desc = 'Flash' },
    { 'S', function() require('flash').treesitter() end, mode = { 'n', 'x', 'o' }, desc = 'Flash Treesitter' },
  },
}
```

Type `s` then two characters - labels appear, type label to jump.

## File Tree: Multi-Tree

File explorer with tab support:

```lua
return {
  'DanielTellier/multi-tree.nvim',
  keys = {
    { '<leader>em', ':MultiTree<CR>', desc = 'Open MultiTree' }
  },
}
```

Navigate file structure, open files in splits or tabs.

## Search: Telescope

Fuzzy finder for files, text, buffers:

```lua
return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-fzf-native.nvim',
  },
  config = function()
    require('telescope').setup({
      defaults = {
        mappings = {
          i = {
            ['<C-o>'] = 'select_horizontal',
            ['<C-v>'] = 'select_vertical',
            ['<C-t>'] = 'select_tab',
          },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        }
      }
    })
    require('telescope').load_extension('fzf')
  end
}
```

Common pickers: `find_files`, `live_grep`, `buffers`, `help_tags`, `marks`.

Mappings in picker: `<C-o>` horizontal split, `<C-v>` vertical split, `<C-t>` new tab.

## Integrated Terminal

```vim
:terminal              # full window
:split | terminal      # horizontal split
:vsplit | terminal     # vertical split
```

Exit terminal mode: `Ctrl-\ Ctrl-n`. Map to keymap: `map('n', '<leader>tt', ':split | terminal<CR>')`.

## Macros

```vim
qa        # start recording to register 'a'
...       # perform actions
q         # stop recording
@a        # replay macro
5@a       # replay 5 times
```

Store permanently in config:

```lua
vim.fn.setreg('f', 'f,lli\b\r\027')  -- Now @f works every session
```

## Git Integration

```lua
return { 'tpope/vim-fugitive' }
```

Keymaps:

```lua
map('n', '<leader>gs', ':Git<CR>', { desc = 'Git status' })
map('n', '<leader>gc', ':Git commit<CR>', { desc = 'Git commit' })
map('n', '<leader>gd', ':Git diff<CR>', { desc = 'Git diff' })
map('n', '<leader>gb', ':Git blame<CR>', { desc = 'Git blame' })
```

## Session Management

Save and restore workspace state:

```lua
vim.g.session_dir = vim.fn.stdpath("state") .. "/sessions"

vim.api.nvim_create_user_command('SaveSession', function(opts)
  vim.cmd("mksession! " .. vim.g.session_dir .. "/" .. opts.args .. ".vim")
end, { nargs = 1 })

-- Keymaps
map('n', '<leader>ss', ':SaveSession ', { desc = 'Save session' })
map('n', '<leader>sl', ':source ' .. vim.g.session_dir .. '/', { desc = 'Load session' })
```

Save workspace: `:SaveSession project-name`, restore: `:source ~/.local/state/nvim/sessions/project-name.vim`.

## Which-Key Plugin

Shows available keybindings in popup:

```lua
return {
  'folke/which-key.nvim',
  config = function()
    require('which-key').setup({ preset = "helix" })
    require('which-key').add({
      { "<leader>f", group = "find" },
      { "<leader>g", group = "git" },
      { "<leader>l", group = "lsp" },
      { "<leader>c", group = "copilot" },
    })
  end
}
```

Press `<leader>` - popup displays available shortcuts after short delay.

## Config Setup

### Folder Structure

```
~/.config/nvim/
├── init.lua                  # Entry point, bootstraps lazy.nvim
├── lua/
│   ├── base_plugins.lua      # Core plugins (which-key, flash, etc.)
│   └── plugins/              # One file per plugin
│       ├── telescope.lua
│       ├── lsp.lua
│       ├── copilot.lua
│       └── ...
├── after/ftplugin/           # Language-specific settings
└── compiler/                 # Custom compiler configs
```

### Settings

Common options in `init.lua` or separate config module:

```lua
vim.opt.number = true              -- line numbers
vim.opt.relativenumber = true      -- relative line numbers
vim.opt.tabstop = 4                -- tab width
vim.opt.shiftwidth = 4             -- indent width
vim.opt.expandtab = true           -- spaces not tabs
vim.opt.clipboard = "unnamedplus"  -- system clipboard
vim.opt.ignorecase = true          -- case insensitive search
vim.opt.smartcase = true           -- smart case sensitivity
```

### File Type Settings

`after/ftplugin/<language>.lua`:

```lua
-- python.lua
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.keymap.set('n', '<leader>r', ':!python %<CR>', { buffer = true })

-- c.lua
vim.opt_local.tabstop = 2
vim.opt_local.cindent = true
```

### Plugin Management: Lazy

Bootstrap in `init.lua`:

```lua
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Load plugins
require("lazy").setup({
  spec = {
    { import = "base_plugins" },
    { import = "plugins" },
  },
  ui = { border = "single" },
  checker = { enabled = true },
})
```

### Adding Plugins

`lua/plugins/<name>.lua`:

```lua
return {
  'author/plugin-name',
  dependencies = { 'dependency-name' },
  config = function()
    require('plugin-name').setup({ })
  end
}
```

### Autocmds

Automatic actions on events:

```lua
-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function() vim.highlight.on_yank() end,
})

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = "%s/\\s\\+$//e",
})
```

### Custom Commands

```lua
vim.api.nvim_create_user_command('Format', function()
  vim.lsp.buf.format()
end, {})

-- Use: :Format or map to keymap
vim.keymap.set('n', '<leader>lf', ':Format<CR>', { desc = 'Format' })
```

## LSP Setup

Language server integration with Mason:

```lua
return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
  },
  config = function()
    require('mason').setup()
    require('mason-lspconfig').setup()

    local lsp = require('lspconfig')

    -- Configure servers (pyright, lua_ls, clangd)
    lsp.lua_ls.setup({
      settings = { Lua = { diagnostics = { globals = { 'vim' } } } }
    })
    lsp.pyright.setup({})
    lsp.clangd.setup({})

    -- All LSP keymaps under <leader>l
    local map = vim.keymap.set
    map('n', '<leader>ld', vim.lsp.buf.definition, { desc = 'Definition' })
    map('n', '<leader>lh', vim.lsp.buf.hover, { desc = 'Hover' })
    map('n', '<leader>li', vim.lsp.buf.implementation, { desc = 'Implementation' })
    map('n', '<leader>lr', vim.lsp.buf.references, { desc = 'References' })
    map('n', '<leader>ls', vim.lsp.buf.rename, { desc = 'Rename' })
    map('n', '<leader>lc', vim.lsp.buf.code_action, { desc = 'Code action' })
  end
}
```

All LSP commands grouped under `<leader>l` prefix for consistency.

## Copilot Setup

AI-powered completion and chat interface:

```lua
return {
  'zbirenbaum/copilot.lua',
  config = function()
    require('copilot').setup({
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<Tab>",
          next = "<C-]>",
          prev = "<C-[>",
        }
      }
    })
  end
}
```

### Copilot Chat

Chat interface with custom prompts:

```lua
return {
  'CopilotC-Nvim/CopilotChat.nvim',
  dependencies = { 'zbirenbaum/copilot.lua', 'nvim-lua/plenary.nvim' },
  opts = {
    prompts = {
      -- Code prompts
      Explain = { prompt = '/COPILOT_EXPLAIN Explain how this works' },
      Review = { prompt = '/COPILOT_REVIEW Review for bugs and improvements' },
      Tests = { prompt = '/COPILOT_TESTS Generate tests for this code' },
      Refactor = { prompt = '/COPILOT_REFACTOR Refactor for readability' },
      FixCode = { prompt = '/COPILOT_FIX Fix bugs in this code' },

      -- Text prompts
      Summarize = { prompt = 'Summarize the selected text' },
      Spelling = { prompt = 'Fix spelling and grammar' },
      Wording = { prompt = 'Improve wording' },
      Concise = { prompt = 'Make text more concise' },
    },
  },
  keys = {
    { '<leader>ct', ':CopilotChatToggle<CR>', desc = 'Toggle chat' },
    { '<leader>ce', ':CopilotChatExplain<CR>', mode = 'v', desc = 'Explain' },
    { '<leader>cr', ':CopilotChatReview<CR>', mode = 'v', desc = 'Review' },
  }
}
```

Chat keybindings: `<CR>` submit, `q` close, `<C-x>` reset, `<C-y>` accept diff.

## Next Steps

1. Install config and explore each feature
2. Practice keymaps daily until muscle memory forms
3. Add one plugin at a time, master it before adding more
4. Customize keymaps to fit your workflow
