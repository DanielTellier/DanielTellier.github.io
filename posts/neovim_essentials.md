# Neovim: Guide to Efficient Text Editing

## Modes: Your Foundation

Neovim has 4 modes. Learn to switch between them:
- **Normal mode**: Navigate and edit (press `Esc`)
- **Insert mode**: Type text (press `i`)
- **Visual mode**: Select text (press `v`)
- **Command mode**: Run commands (press `:`)

Rule: Stay in Normal mode unless actively typing. This is where efficiency happens.

## Editing Key Movements

### Basic Movement

Instead of arrow keys, use:
- `h j k l` - left, down, up, right
- `w` - next word, `b` - previous word
- `0` - start of line, `$` - end of line
- `gg` - top of file, `G` - bottom of file

Practice: Open any file and navigate without arrow keys for 10 minutes daily.

### Text Object Movements

Edit text structures intelligently - works with quotes, brackets, functions, etc.

Pattern: operator + text object
- `dw` - delete word
- `ci"` - change inside quotes
- `da(` - delete around parentheses
- `yi{` - yank inside braces
- `c3iw` - change 3 words

Learn one operator (`d` delete, `c` change, `y` copy) and it works with every motion you know.

Example config using treesitter for enhanced text objects:
```lua
-- From treesitter config - operate on code structures
["af"] = "@function.outer",
["if"] = "@function.inner",
["ac"] = "@class.outer"
```

## Essential Daily Operations

### Quick File Navigation

Open files fast with built-in commands:
- `:e filename` - edit file
- `:find partial*name` - fuzzy find files (use tab completion)
- `Ctrl-^` - switch between last two files
- `:b partial` - switch to buffer by partial name

Practice: Navigate between 3 files without using a file tree for one week.

### Search and Replace Mastery

Search efficiently:
- `/pattern` - search forward
- `?pattern` - search backward
- `n` - next match, `N` - previous match
- `*` - search for word under cursor

Replace with precision:
- `:s/old/new/` - replace first occurrence on line
- `:s/old/new/g` - replace all on line
- `:%s/old/new/g` - replace all in file
- `:%s/old/new/gc` - replace all with confirmation

Rule: Always use `/pattern` to verify your search before replacing.

### Window Management

Split your workspace:
- `:split` or `Ctrl-w s` - horizontal split
- `:vsplit` or `Ctrl-w v` - vertical split
- `Ctrl-w w` - cycle between windows
- `Ctrl-w q` - close current window

Navigate splits:
- `Ctrl-w h/j/k/l` - move left/down/up/right
- `Ctrl-w =` - equalize window sizes

Practice: Edit one file while referencing another in a split.

### Copy/Paste Between Files

Use registers (Neovim's clipboard system):
- `"ay` - copy to register 'a'
- `"ap` - paste from register 'a'
- `"+y` - copy to system clipboard
- `"+p` - paste from system clipboard

Pattern: Copy from one file (`"+y`), switch files, paste (`"+p`).

## Configuration Architecture

### Config Structure

Organize configuration for maintainability and clarity

```
~/.config/nvim/
├── init.lua              # Entry point, lazy bootstrap
├── lua/
│   ├── config/
│   │   ├── options.lua   # vim.opt settings
│   │   ├── autocmds.lua  # autocommands
│   │   ├── lazy.lua      # config loader
│   │   └── keymaps/      # organized by feature
│   │       ├── base.lua      # core mappings
│   │       ├── telescope.lua # search mappings
│   │       └── git.lua       # git mappings
│   ├── plugins/          # one file per plugin
│   │   ├── telescope.lua     # fuzzy finder config
│   │   └── lsp.lua          # language server config
│   ├── utils.lua         # utility functions
│   └── base_plugins.lua  # essential plugins
├── after/ftplugin/       # filetype-specific config
│   ├── python.lua            # Python-only settings
│   └── c.lua                # C-only settings
└── compiler/             # custom compiler settings
```

### Lua Over Vimscript

Neovim uses Lua for configuration. Basic syntax you need:

```lua
-- Set options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4

-- Create keymaps
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Save file' })
vim.keymap.set('v', '<leader>y', '"+y', { desc = 'Copy to clipboard' })

-- Create autocommands
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  command = '%s/\\s\\+$//e'  -- Remove trailing whitespace
})
```

### Modular Structure

Organize your config in `~/.config/nvim/`:

```
init.lua              -- Entry point
lua/
  config/
    options.lua       -- vim.opt settings
    keymaps.lua       -- key bindings
    autocmds.lua      -- autocommands
  plugins/
    telescope.lua     -- plugin configurations
    lsp.lua
```

In `init.lua`:
```lua
require('config.options')
require('config.keymaps')
require('config.autocmds')
```

### Plugin Management with lazy.nvim

Install plugins declaratively:

```lua
-- lua/config/lazy.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({"git", "clone", "https://github.com/folke/lazy.nvim.git", lazypath})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
```

Plugin structure in `lua/plugins/telescope.lua`:
```lua
return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('telescope').setup({
      defaults = {
        file_ignore_patterns = { "node_modules", ".git/" }
      }
    })
  end
}
```

This pattern keeps each plugin's configuration isolated and manageable.

## Key Productivity Features

### Fuzzy Finding with Telescope

Install telescope for file/text discovery:

```lua
-- Keymaps for telescope
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
```

Essential telescope commands:
- `<leader>ff` - find files by name
- `<leader>fg` - search text across project
- `<leader>fb` - switch between open buffers
- `<leader>fh` - search help documentation

### LSP Integration

Language Server Protocol provides code intelligence:

```lua
-- Basic LSP setup
return {
  'neovim/nvim-lspconfig',
  config = function()
    local lsp = require('lspconfig')

    -- Example: Python LSP
    lsp.pyright.setup({})

    -- Key mappings for LSP
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)
  end
}
```

Essential LSP commands:
- `gd` - go to definition
- `K` - show documentation
- `<leader>rn` - rename symbol
- `<leader>ca` - code actions (imports, fixes)

### Terminal Integration

Access terminal without leaving Neovim:
- `:terminal` - open terminal in current window
- `:split | terminal` - terminal in horizontal split
- `Ctrl-\` `Ctrl-n` - exit terminal mode to normal mode

### Buffer Management

Work with multiple files efficiently:
- `:ls` - list open buffers
- `:bd` - delete current buffer
- `:bd filename` - delete specific buffer
- `Ctrl-^` - alternate between last two buffers

### Quickfix List

Navigate errors and search results:
- `:copen` - open quickfix window
- `:cnext` / `:cprev` - next/previous item
- `:cfirst` / `:clast` - first/last item
- `:cclose` - close quickfix window

The quickfix list populates automatically from grep, LSP diagnostics, and compiler errors.

## Customization Examples

### Creating Custom Keymaps

Design keymaps that follow vim conventions:

```lua
-- Leader key pattern
vim.g.mapleader = ' '

-- File operations
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Save file' })
vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = 'Quit' })

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to bottom window' })

-- Visual mode clipboard
vim.keymap.set('v', '<leader>y', '"+y', { desc = 'Copy to system clipboard' })
vim.keymap.set('v', '<leader>p', '"+p', { desc = 'Paste from system clipboard' })
```

Use the `desc` field for documentation and which-key integration.

### Writing Utility Functions

Create reusable functions for common tasks:

```lua
-- Toggle between relative and absolute line numbers
local function toggle_line_numbers()
  if vim.opt.relativenumber:get() then
    vim.opt.relativenumber = false
    vim.opt.number = true
  else
    vim.opt.relativenumber = true
  end
end

vim.keymap.set('n', '<leader>tn', toggle_line_numbers, { desc = 'Toggle line numbers' })

-- Quick compile and run
local function compile_and_run()
  vim.cmd('write')
  local filetype = vim.bo.filetype
  if filetype == 'python' then
    vim.cmd('!python %')
  elseif filetype == 'c' then
    vim.cmd('!gcc % -o %< && ./%<')
  end
end

vim.keymap.set('n', '<leader>cr', compile_and_run, { desc = 'Compile and run' })
```

### File-Type Specific Configuration

Configure behavior per language in `after/ftplugin/`:

```lua
-- after/ftplugin/python.lua
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = true

-- Python-specific keymap
vim.keymap.set('n', '<leader>r', ':!python %<CR>', {
  buffer = true,
  desc = 'Run Python file'
})

-- after/ftplugin/c.lua
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.cindent = true

-- C-specific compiler
vim.cmd('compiler gcc')
```

The `buffer = true` option makes keymaps local to that buffer only.

## Advanced Workflow Patterns

### Multi-File Editing

Work across multiple files efficiently:

```lua
-- Jump between files with tags
-- Generate tags: ctags -R .
vim.keymap.set('n', '<C-]>', '<C-]>', { desc = 'Jump to tag' })
vim.keymap.set('n', '<C-t>', '<C-t>', { desc = 'Jump back' })

-- Global search and replace across project
-- :grep "pattern" **/*.lua
-- :cfdo %s/old/new/g | update
```

Pattern: Use `:grep` to populate quickfix, then `:cfdo` to execute commands on all matches.

### Git Integration

Essential git commands without leaving Neovim:

```lua
-- Built-in git commands
vim.keymap.set('n', '<leader>gs', ':Git<CR>', { desc = 'Git status' })
vim.keymap.set('n', '<leader>gc', ':Git commit<CR>', { desc = 'Git commit' })
vim.keymap.set('n', '<leader>gp', ':Git push<CR>', { desc = 'Git push' })

-- View git blame
vim.keymap.set('n', '<leader>gb', ':Git blame<CR>', { desc = 'Git blame' })
```

Use fugitive.vim or built-in git commands for version control without context switching.

### Session Management

Save and restore editing sessions:

```lua
-- Session commands
vim.keymap.set('n', '<leader>ss', ':mksession! Session.vim<CR>', { desc = 'Save session' })
vim.keymap.set('n', '<leader>sr', ':source Session.vim<CR>', { desc = 'Restore session' })

-- Auto-save session on exit
vim.api.nvim_create_autocmd('VimLeavePre', {
  callback = function()
    vim.cmd('mksession! Session.vim')
  end
})
```

### AI Assistance Integration

Leverage AI for code generation and explanations:

```lua
-- GitHub Copilot integration
return {
  'github/copilot.vim',
  config = function()
    vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
      expr = true,
      replace_keycodes = false
    })
    vim.g.copilot_no_tab_map = true
  end
}
```

### Efficient Text Objects

Master vim's text objects for precise editing:
- `ci"` - change inside quotes
- `da(` - delete around parentheses
- `yi{` - yank inside braces
- `ca<` - change around angle brackets

Combine with counts: `c3iw` changes 3 words, `d2ip` deletes 2 paragraphs.

The pattern: operator + count + text object gives you surgical precision over any text structure.

## Creating and Using Macros

Record repetitive editing sequences and replay them

Basic macro workflow:
```vim
qa          " start recording macro in register 'a'
...         " perform actions
q           " stop recording
@a          " replay macro
@@          " repeat last macro
5@a         " run macro 5 times
```

Store a macro such as @f for later use:
```vim
"af    " Paste the f macro to the buffer
```

Place the pasted f macro into the below function:
```lua
-- Move comma separated parameters to own line for a function call/definition
vim.fn.setreg('f', 'f,lli\b\r\027')
```

## Session Management

Save and restore your entire workspace state - windows, buffers, cursor positions

Example session management setup:
```lua
-- From your utils.lua and autocmds
vim.g.session_dir = vim.fn.stdpath("state") .. "/sessions"

-- Create custom command for making sessions
vim.api.nvim_create_user_command('MakeSession', function(opts)
    local name = opts.args .. ".vim"
    local session_path = vim.g.session_dir .. "/" .. name
    vim.cmd("mksession! " .. vim.fn.fnameescape(session_path))
    print("Session saved as: " .. name)
end, { nargs = 1 })

-- Your keymaps for session workflow
utils.map('n', '<leader>im', ':MakeSession ',
    { silent = false, desc = "Make session" })
utils.map('n', '<leader>il', ':source ~/.local/state/nvim/sessions/',
    { silent = false, desc = "Load session" })
```

Session workflow:
1. Open project files, arrange windows/splits
2. `:MakeSession project-name` - saves everything
3. Later: `:source ~/.local/state/nvim/sessions/project-name.vim` - restores exactly where you left off
4. Sessions preserve: open files, window layout, cursor positions, working directory

## Adding Neovim Option Settings

Basic pattern (`lua/config/options.lua`):
```lua
local opt = vim.opt
opt.number = true           -- show line numbers
opt.relativenumber = true   -- relative line numbers for movement
opt.tabstop = 4            -- tab width
opt.clipboard = "unnamedplus"  -- system clipboard integration
opt.ignorecase = true      -- case insensitive search
opt.smartcase = true       -- case sensitive when uppercase used
```

## Lazy Setup

Bootstrap the modern Neovim plugin manager

Bootstrap (`init.lua`):
```lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({"git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", lazypath})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({ import = "plugins" })  -- load all plugins/ files
```

## Adding a Plugin via Lazy

Install and configure plugins declaratively

Your telescope setup pattern:
```lua
-- lua/plugins/telescope.lua
return {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },  -- required dependencies
    config = function()
        require("telescope").setup({
            defaults = {
                mappings = {
                    i = { ["<c-o>"] = actions.select_horizontal }
                }
            }
        })
        telescope.load_extension("fzf")  -- enable extensions
    end,
}
```

## Adding Key Mapping

Create custom shortcuts for any command

Using your utility pattern:
```lua
-- lua/utils.lua - utility function for consistent mapping
function M.map(modes, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.keymap.set(modes, lhs, rhs, options)
end

-- Usage in keymaps - creates <space>ff shortcut
utils.map('n', '<leader>ff', '<cmd>Telescope find_files<cr>',
    { desc = "Find files" })
```

## Creating Util Function

Write reusable functions for complex operations

Your toggle function example:
```lua
-- lua/utils.lua
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

-- Usage in keymap
utils.map('n', '<leader>tn', function()
    utils.toggle_numbers()
end, { desc = "Toggle numbers" })
```

## Adding Autocmds

Automatically run commands on events (file save, buffer open, etc.)

Your pattern with augroups:
```lua
-- lua/config/autocmds.lua
local utils = require('utils')

-- Highlight text when copying
vim.api.nvim_create_autocmd("TextYankPost", {
    group = utils.augroup("highlight_yank"),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Set filetype for environment files
vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
    group = utils.augroup("env_filetype"),
    pattern = {"*.env", ".env.*"},
    callback = function()
        vim.opt_local.filetype = "sh"
    end,
})
```

## Custom Commands + Keymaps

Create new :commands and bind them to keys

Your session management example:
```lua
-- Create command
vim.api.nvim_create_user_command('MakeSession', function(opts)
    local name = opts.args .. ".vim"
    local session_path = vim.g.session_dir .. "/" .. name
    vim.cmd("mksession! " .. vim.fn.fnameescape(session_path))
end, { nargs = 1 })

-- Map to keymap - now :MakeSession is accessible via <space>im
utils.map('n', '<leader>im', ':MakeSession ',
    { silent = false, desc = "Make session" })
```

## Which-Key Plugin

Visual popup showing available keymaps - no more memorization

Never memorize keymaps again:
```lua
-- lua/base_plugins.lua
{
    "folke/which-key.nvim",
    opts = { preset = "helix" },
    config = function(_, opts)
        local wk = require("which-key")
        wk.setup(opts)
    end,
}

-- Usage - creates groups and shows help popup when you press <leader>
wk.add({
    { "<leader>f", group = "find", mode = "n" },    -- <leader>f shows find options
    { "<leader>g", group = "git", mode = "n" }      -- <leader>g shows git options
})
```

## Copilot Integration

AI-powered code completion and chat assistance

Setup with custom prompts:
```lua
-- lua/plugins/copilot.lua
{
    "CopilotC-Nvim/CopilotChat.nvim",
    opts = {
        model = "claude-sonnet-4",
        prompts = {
            ["Review"] = {
                prompt = "Review code and suggest improvements",
                system_prompt = "You are an expert programmer..."
            }
        }
    }
}

-- Custom keymaps for AI assistance
utils.map("n", "<leader>ct", function()
    require("CopilotChat").toggle()
end, { desc = "Toggle Copilot" })

utils.map("v", "<leader>cr", "<cmd>CopilotChatReview<cr>",
    { desc = "Review code" })
```
