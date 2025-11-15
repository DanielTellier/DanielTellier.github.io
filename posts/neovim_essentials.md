# Neovim Essentials

Practical guide to daily Neovim usage with real examples.

## Install/Setup

Clone my config:

```bash
git clone https://github.com/yourusername/nvim-config ~/.config/nvim
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

System clipboard integration:

```lua
-- Copy to system clipboard
"+y   # visual mode
"+yy  # normal mode (whole line)

-- Paste from system clipboard
"+p   # after cursor
"+P   # before cursor
```

## Key Mappings Setup

Create mappings in `lua/config/keymaps.lua`:

```lua
local map = vim.keymap.set

-- Leader key
vim.g.mapleader = ' '

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

Search and replace patterns:

```vim
:s/old/new/       # first occurrence on line
:s/old/new/g      # all on line
:%s/old/new/g     # all in file
:%s/old/new/gc    # all with confirmation
:'<,'>s/old/new/g # visual selection
```

Example: Rename variable across file:

```vim
:%s/oldVar/newVar/g
```

## Surround

Install nvim-surround plugin:

```lua
-- lua/plugins/surround.lua
return {
  'kylechui/nvim-surround',
  config = function()
    require('nvim-surround').setup({})
  end
}
```

Usage:

```
ys<motion><char>  # add surround
ds<char>          # delete surround
cs<old><new>      # change surround
```

Example: `ysiw"` surrounds word with quotes, `cs"'` changes to single quotes.

## Window Movement

Split and navigate:

```vim
:vsplit  # or Ctrl-w v (vertical)
:split   # or Ctrl-w s (horizontal)
Ctrl-w h/j/k/l   # navigate windows
Ctrl-w =         # equalize size
Ctrl-w q         # close window
```

## Search: Telescope

Install and configure:

```lua
-- lua/plugins/telescope.lua
return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local telescope = require('telescope')
    telescope.setup({
      defaults = {
        file_ignore_patterns = { "node_modules", ".git/" }
      }
    })
  end
}
```

### Find Files

```lua
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Find files' })
```

Type partial name, fuzzy matches.

### Live Grep

```lua
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = 'Live grep' })
```

Search text across entire project.

### Buffers

```lua
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { desc = 'Buffers' })
```

Switch between open files.

### Marks

```lua
map('n', '<leader>fm', '<cmd>Telescope marks<cr>', { desc = 'Marks' })
```

Jump to bookmarks. Create marks with `m<letter>`, jump with `'<letter>`.

### Help Tags

```lua
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { desc = 'Help' })
```

Search Neovim documentation.

## Integrated Terminal

Open terminal without leaving Neovim:

```vim
:terminal              # full window
:split | terminal      # horizontal split
:vsplit | terminal     # vertical split
```

Exit terminal mode: `Ctrl-\ Ctrl-n`

Keymap example:

```lua
map('n', '<leader>tt', ':split | terminal<CR>', { desc = 'Terminal' })
```

## Macros

Record repetitive actions:

```vim
qa        # start recording to register 'a'
...       # perform actions
q         # stop recording
@a        # replay macro
5@a       # replay 5 times
```

### Store Macros

Paste macro to file:

```vim
"ap       # paste register 'a' contents
```

Store in config:

```lua
-- Move comma-separated params to own lines
vim.fn.setreg('f', 'f,lli\b\r\027')
```

Now `@f` works every session.

## Git Integration

Use fugitive or built-in commands:

```lua
-- lua/config/keymaps.lua
map('n', '<leader>gs', ':Git<CR>', { desc = 'Git status' })
map('n', '<leader>gc', ':Git commit<CR>', { desc = 'Git commit' })
map('n', '<leader>gd', ':Git diff<CR>', { desc = 'Git diff' })
map('n', '<leader>gb', ':Git blame<CR>', { desc = 'Git blame' })
```

Or install fugitive:

```lua
-- lua/plugins/fugitive.lua
return { 'tpope/vim-fugitive' }
```

## Session Management

Save/restore workspace state:

```lua
-- Create session directory
vim.g.session_dir = vim.fn.stdpath("state") .. "/sessions"

-- Command to save sessions
vim.api.nvim_create_user_command('MakeSession', function(opts)
  local name = opts.args .. ".vim"
  local path = vim.g.session_dir .. "/" .. name
  vim.cmd("mksession! " .. vim.fn.fnameescape(path))
  print("Saved: " .. name)
end, { nargs = 1 })

-- Keymaps
map('n', '<leader>ss', ':MakeSession ', { silent = false, desc = 'Save session' })
map('n', '<leader>sl', ':source ' .. vim.g.session_dir .. '/', { silent = false, desc = 'Load session' })
```

Workflow: Open files, arrange splits, `:MakeSession project-name`. Later: `:source ~/.local/state/nvim/sessions/project-name.vim`.

## Which-Key Plugin

Visual keymap helper:

```lua
-- lua/plugins/which-key.lua
return {
  'folke/which-key.nvim',
  config = function()
    local wk = require('which-key')
    wk.setup({ preset = "helix" })

    -- Define keymap groups
    wk.add({
      { "<leader>f", group = "find" },
      { "<leader>g", group = "git" },
      { "<leader>c", group = "copilot" },
    })
  end
}
```

Press `<leader>` and wait - popup shows all available shortcuts.

## Config Setup

### Folder Structure

```
~/.config/nvim/
├── init.lua                  # Entry point
├── lua/
│   ├── config/
│   │   ├── options.lua       # Settings
│   │   ├── keymaps.lua       # Key mappings
│   │   ├── autocmds.lua      # Autocommands
│   │   └── lazy.lua          # Plugin loader
│   ├── plugins/              # One file per plugin
│   │   ├── telescope.lua
│   │   ├── lsp.lua
│   │   └── ...
│   └── utils.lua             # Helper functions
└── after/ftplugin/           # Language-specific
    ├── python.lua
    └── c.lua
```

### Settings

Basic options in `lua/config/options.lua`:

```lua
local opt = vim.opt

opt.number = true              -- line numbers
opt.relativenumber = true      -- relative numbers
opt.tabstop = 4               -- tab width
opt.shiftwidth = 4            -- indent width
opt.expandtab = true          -- spaces not tabs
opt.clipboard = "unnamedplus" -- system clipboard
opt.ignorecase = true         -- case insensitive search
opt.smartcase = true          -- case sensitive if uppercase used
```

### File Type Settings

Language-specific settings in `after/ftplugin/`:

```lua
-- after/ftplugin/python.lua
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.keymap.set('n', '<leader>r', ':!python %<CR>', { buffer = true })

-- after/ftplugin/c.lua
vim.opt_local.tabstop = 2
vim.opt_local.cindent = true
vim.cmd('compiler gcc')
```

### Plugin Management: Lazy

Bootstrap in `init.lua`:

```lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({ import = "plugins" })
```

Load config:

```lua
require('config.options')
require('config.keymaps')
require('config.autocmds')
```

### Adding Plugins

Create `lua/plugins/<name>.lua`:

```lua
return {
  'author/plugin-name',
  dependencies = { 'required/dependency' },
  config = function()
    require('plugin-name').setup({
      -- configuration
    })
  end
}
```

### Autocmds

Auto-run commands on events in `lua/config/autocmds.lua`:

```lua
-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = "%s/\\s\\+$//e",
})

-- Set filetype for .env files
vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  pattern = {"*.env", ".env.*"},
  callback = function()
    vim.bo.filetype = "sh"
  end,
})
```

### Creating Commands

Define custom commands:

```lua
vim.api.nvim_create_user_command('Format', function()
  vim.lsp.buf.format()
end, {})
```

Map to keymap:

```lua
map('n', '<leader>lf', ':Format<CR>', { desc = 'Format file' })
```

### Utility Functions

Create reusable functions in `lua/utils.lua`:

```lua
local M = {}

-- Consistent keymap helper
function M.map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Toggle line numbers
function M.toggle_numbers()
  if vim.wo.relativenumber then
    vim.wo.relativenumber = false
  elseif vim.wo.number then
    vim.wo.number = false
  else
    vim.wo.number = true
    vim.wo.relativenumber = true
  end
end

return M
```

Use in config:

```lua
local utils = require('utils')
utils.map('n', '<leader>tn', utils.toggle_numbers, { desc = 'Toggle numbers' })
```

## LSP Setup

Language server integration in `lua/plugins/lsp.lua`:

```lua
return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',           -- LSP installer
    'williamboman/mason-lspconfig.nvim', -- Mason <-> lspconfig bridge
  },
  config = function()
    require('mason').setup()
    require('mason-lspconfig').setup({
      ensure_installed = { 'pyright', 'lua_ls', 'clangd' }
    })

    local lsp = require('lspconfig')

    -- Python
    lsp.pyright.setup({})

    -- Lua
    lsp.lua_ls.setup({
      settings = {
        Lua = {
          diagnostics = { globals = { 'vim' } }
        }
      }
    })

    -- Keymaps
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover docs' })
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename' })
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code action' })
  end
}
```

Usage: `gd` jumps to definition, `K` shows docs, `<leader>rn` renames symbol.

## Copilot Setup

AI assistance in `lua/plugins/copilot.lua`:

```lua
return {
  'zbirenbaum/copilot.lua',
  config = function()
    require('copilot').setup({
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<C-j>",
          next = "<C-]>",
          prev = "<C-[>",
        }
      }
    })
  end
}
```

### Copilot Chat

Add chat interface:

```lua
return {
  'CopilotC-Nvim/CopilotChat.nvim',
  dependencies = {
    { 'zbirenbaum/copilot.lua' },
    { 'nvim-lua/plenary.nvim' },
  },
  opts = {
    model = 'claude-3.5-sonnet',
    prompts = {
      Review = {
        prompt = '/COPILOT_REVIEW Review code and suggest improvements',
      },
      Explain = {
        prompt = '/COPILOT_EXPLAIN Explain how this works',
      },
    },
  },
  config = function(_, opts)
    local chat = require('CopilotChat')
    chat.setup(opts)

    -- Keymaps
    vim.keymap.set('n', '<leader>ct', chat.toggle, { desc = 'Toggle Copilot Chat' })
    vim.keymap.set('v', '<leader>cr', ':CopilotChatReview<CR>', { desc = 'Review code' })
    vim.keymap.set('v', '<leader>ce', ':CopilotChatExplain<CR>', { desc = 'Explain code' })
  end
}
```

### Use Buffers in Chat

Reference open files in chat:

```
# In CopilotChat window
#buffers Review all open files for consistency

# Or specific buffer
#buffer:1 Explain this file
```

The `#buffers:listed` command shows all open buffers that can be referenced.

## Next Steps

1. Install config and explore each feature
2. Practice keymaps daily until muscle memory forms
3. Add one plugin at a time, master it before adding more
4. Customize keymaps to fit your workflow
