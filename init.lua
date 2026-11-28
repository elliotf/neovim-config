--[[

TODO:
  get rid of linter auto-rewriting file
    or get used to it?
    it does the "trim trailing whitespace" but it might get me into trouble with codebases, causing excessive changes

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

What is Kickstart?

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:

  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

    If you don't know what this means, type the following:
      - <escape key>
      - :
      - Tutor
      - <enter key>

    (If you already know the Neovim basics, you can skip this step.)

  Once you've completed that, you can continue working through **AND READING** the rest
  of the kickstart init.lua.

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite Neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or Neovim features used in Kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help you understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your Neovim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
--]]

--local log = require('log')
--log:write('Starting')

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.o.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
--vim.o.mouse = 'a'
vim.o.mouse = ''

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
--vim.schedule(function()
--  vim.o.clipboard = 'unnamedplus'
--end)

-- Enable break indent : https://neovim.io/doc/user/options.html#'breakindent'
--vim.o.breakindent = true
vim.o.breakindent = false

-- Save undo history
--vim.o.undofile = true
vim.o.undofile = false

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
--vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.wo.list = false
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true
vim.o.cursorcolumn = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
--vim.keymap.set('n', '<space>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.cmd [[
  vmap <tab> >gv
  vmap <s-tab> <gv

  let g:lasttab = 1
  nnoremap `` :exe "tabn ".g:lasttab<CR>
  au TabLeave * let g:lasttab = tabpagenr()

  au BufLeave,FocusLost * silent! wall " automatically write buffer when switching away
]]

-- Be able to switch back and forth between recent tabs
--  let g:lasttab = 1
--  nnoremap `` :exe "tabn ".g:lasttab<CR>
--  au TabLeave * let g:lasttab = tabpagenr()
-- The overengineered version
local tab_mru = { vim.api.nvim_get_current_tabpage() }

vim.api.nvim_create_autocmd('TabEnter', {
  desc = 'Track tab MRU stack',
  callback = function()
    local cur = vim.api.nvim_get_current_tabpage()
    for i = #tab_mru, 1, -1 do
      if tab_mru[i] == cur then table.remove(tab_mru, i) end
    end
    table.insert(tab_mru, cur)
  end,
})

vim.keymap.set('n', '``', function()
  local cur = vim.api.nvim_get_current_tabpage()
  for i = #tab_mru, 1, -1 do
    local t = tab_mru[i]
    if not vim.api.nvim_tabpage_is_valid(t) then
      table.remove(tab_mru, i)
    elseif t ~= cur then
      vim.api.nvim_set_current_tabpage(t)
      return
    end
  end
end, { desc = 'Jump to previous tab' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- [[ Install and configure plugins with vim.pack ]]
--    See `:help vim.pack`
--
--  Plugins live in `stdpath('data')/site/pack/core/opt/`. Revisions are pinned
--  in `nvim-pack-lock.json` next to this file; keep it under version control.
--
--  Update all plugins (opens a review tab; `:write` to apply, `:quit` to cancel):
--    :lua vim.pack.update()
--  Show what is installed:
--    :lua vim.pack.update(nil, { offline = true })
--  Remove a plugin: delete it from `vim.pack.add` below, restart, then
--    :lua vim.pack.del { 'plugin-name' }

local function gh(repo)
  return 'https://github.com/' .. repo
end

-- Build steps. Must be registered before `vim.pack.add` so they also run on first install.
vim.api.nvim_create_autocmd('PackChanged', {
  desc = 'Run plugin build steps after install/update',
  group = vim.api.nvim_create_augroup('pack-build-hooks', { clear = true }),
  callback = function(ev)
    local name, kind, path = ev.data.spec.name, ev.data.kind, ev.data.path
    if kind ~= 'install' and kind ~= 'update' then
      return
    end

    if name == 'telescope-fzf-native.nvim' and vim.fn.executable 'make' == 1 then
      vim.system({ 'make' }, { cwd = path }, function(res)
        if res.code ~= 0 then
          vim.schedule(function()
            vim.notify('telescope-fzf-native build failed:\n' .. (res.stderr or ''), vim.log.levels.ERROR)
          end)
        end
      end)
    elseif name == 'nvim-treesitter' then
      if not ev.data.active then
        vim.cmd.packadd 'nvim-treesitter'
      end
      vim.cmd 'TSUpdate'
    end
  end,
})

-- Settings that plugins read when they load
vim.g.db_ui_use_nerd_fonts = 1

local plugins = {
  gh 'loctvl842/monokai-pro.nvim',

  gh 'towolf/vim-helm',
  gh 'crispgm/nvim-tabline',
  gh 'nvim-lualine/lualine.nvim',
  gh 'tpope/vim-fugitive',
  gh 'godlygeek/tabular',
  gh 'airblade/vim-gitgutter',
  gh 'mechatroner/rainbow_csv',

  gh 'nvim-mini/mini.icons',
  gh 'stevearc/oil.nvim',

  gh 'folke/which-key.nvim',

  -- use my fork of telescope because
  -- https://github.com/nvim-telescope/telescope.nvim/blob/7d324792b7943e4aa16ad007212e6acc6f9fe335/lua/telescope/pickers.lua#L561
  -- forcibly turns word wrap on. This might be due to how my custom actions open files
  { src = gh 'elliotf/telescope.nvim', version = 'elliotf' },
  gh 'nvim-lua/plenary.nvim',
  gh 'nvim-telescope/telescope-ui-select.nvim',

  gh 'folke/lazydev.nvim',
  gh 'neovim/nvim-lspconfig',
  gh 'mason-org/mason.nvim',
  gh 'mason-org/mason-lspconfig.nvim',
  gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
  gh 'j-hui/fidget.nvim',

  gh 'stevearc/conform.nvim',

  gh 'tpope/vim-dadbod',
  gh 'kristijanhusak/vim-dadbod-completion',
  gh 'kristijanhusak/vim-dadbod-ui',

  -- locked to this commit because latest versions break undo (I cannot undo changes)
  { src = gh 'L3MON4D3/LuaSnip', version = '458560534a73f7f8d7a11a146c801db00b081df0' },
  { src = gh 'saghen/blink.cmp', version = vim.version.range '1.*' },

  gh 'zk-org/zk-nvim',
  gh 'folke/todo-comments.nvim',

  { src = gh 'nvim-treesitter/nvim-treesitter', version = 'main' },
  gh 'nvim-treesitter/nvim-treesitter-context',
  gh 'rachartier/tiny-inline-diagnostic.nvim',
  gh 'rgroli/other.nvim',
}
if vim.fn.executable 'make' == 1 then
  -- If encountering errors, see telescope-fzf-native README for installation instructions
  table.insert(plugins, gh 'nvim-telescope/telescope-fzf-native.nvim')
end
if vim.g.have_nerd_font then
  -- Useful for getting pretty icons, but requires a Nerd Font.
  table.insert(plugins, gh 'nvim-tree/nvim-web-devicons')
end

vim.pack.add(plugins)

-- [[ Colorscheme ]] (first, so later UI plugins pick up its highlights)
require('monokai-pro').setup {
  filter = 'pro',
}
vim.cmd.colorscheme 'monokai-pro'
--  Alternatives tried:
--    'olimorris/onedarkpro.nvim' -- cursorline is messed up using this scheme
--    'navarasu/onedark.nvim' style = 'warmer' -- pretty good, but comments are *very* hard to read
--    'EdenEast/nightfox.nvim'

-- Other plugins considered:
--    'wincent/command-t', 'ctrlpvim/ctrlp.vim'
--    'sphamba/smear-cursor.nvim' -- using https://github.com/wezterm/wezterm/pull/7737 instead
--    'andymass/vim-matchup' with vim.g.matchup_matchparen_offscreen = { method = 'popup' }
--    'echasnovski/mini.nvim' (mini.ai, mini.surround, mini.statusline)
--    maybe look at:
--      https://github.com/hat0uma/csvview.nvim
--      https://github.com/emmanueltouzery/decisive.nvim

-- [[ Tabline ]] works, but is not pretty
vim.opt.showtabline = 2
require('tabline').setup {
  brackets = { '', '' },
  modify_indicator = '*',
  fnamemodify = function(input)
    local str = input or ''
    -- For whatever reason, using LSP features sometimes ends up in the
    -- file having the full path instead of the relative path. Let's trim
    -- the beginning to avoid wide tabs
    str = str:gsub('^/home/%a+/', '')
    str = str:gsub('^/Users/%a+/code/render/', '')
    local lookup = {
      ['code/'] = '',
      ['git/'] = '',
      ['work/'] = '',
    }
    str = str:gsub('^(%a+/)', function(pref)
      return lookup[pref] or pref
    end)

    local dir = string.match(str, '^(.*/)') or ''
    local file = string.match(str, '([^/]+)$') or ''
    local shortened = string.gsub(dir, '([^/]+)/', function(w)
      return w:sub(0, 2) .. '/'
    end)
    return shortened .. (file or '')
  end,
}

-- [[ Statusline ]]
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = true,
    refresh = {
      statusline = 100,
      tabline = 100,
      winbar = 100,
    },
  },
  sections = {
    lualine_a = {
      {
        'mode',
        fmt = function(mode)
          return mode == 'INSERT' and vim.go.paste == true and mode .. ' (paste)' or mode
        end,
      },
    },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { 'filename' },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {},
}

-- [[ File explorer ]]
require('mini.icons').setup {}
require('oil').setup {}

-- [[ Pending keybind hints ]]
require('which-key').setup {
  -- delay between pressing a key and opening which-key (milliseconds)
  -- this setting is independent of vim.o.timeoutlen
  delay = 0,
  icons = {
    -- set icon mappings to true if you have a Nerd Font
    mappings = vim.g.have_nerd_font,
    -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
    -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
    keys = vim.g.have_nerd_font and {} or {
      Up = '<Up> ',
      Down = '<Down> ',
      Left = '<Left> ',
      Right = '<Right> ',
      C = '<C-…> ',
      M = '<M-…> ',
      D = '<D-…> ',
      S = '<S-…> ',
      CR = '<CR> ',
      Esc = '<Esc> ',
      ScrollWheelDown = '<ScrollWheelDown> ',
      ScrollWheelUp = '<ScrollWheelUp> ',
      NL = '<NL> ',
      BS = '<BS> ',
      Space = '<Space> ',
      Tab = '<Tab> ',
      F1 = '<F1>',
      F2 = '<F2>',
      F3 = '<F3>',
      F4 = '<F4>',
      F5 = '<F5>',
      F6 = '<F6>',
      F7 = '<F7>',
      F8 = '<F8>',
      F9 = '<F9>',
      F10 = '<F10>',
      F11 = '<F11>',
      F12 = '<F12>',
    },
  },

  -- Document existing key chains
  spec = {
    { '<leader>s', group = '[S]earch' },
    { '<leader>t', group = '[T]oggle' },
    { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
  },
}

-- [[ Fuzzy Finder (files, lsp, etc) ]]
do
  -- See `:help telescope` and `:help telescope.setup()`
  local actions = require 'telescope.actions'
  local action_state = require 'telescope.actions.state'
  local custom_actions = {}

  -- based on a combination of
  -- https://github.com/nvim-telescope/telescope.nvim/issues/1048#issuecomment-889122232
  -- and
  -- https://github.com/nvim-telescope/telescope.nvim/issues/1048#issuecomment-1924898073
  function custom_actions.get_entries(prompt_bufnr)
    local picker = action_state.get_current_picker(prompt_bufnr)
    local multi_selection = picker:get_multi_selection()
    return #multi_selection > 1 and multi_selection or { action_state.get_selected_entry() }
  end

  function custom_actions.multi_action(prompt_bufnr, action)
    -- read selections before closing; the picker is gone after close
    local entries = custom_actions.get_entries(prompt_bufnr)
    actions.close(prompt_bufnr) -- tear down picker cleanly first

    local close_bufnr = -1
    local winid = vim.api.nvim_tabpage_list_wins(0)[1]
    local bufnr = vim.api.nvim_win_get_buf(winid)
    if vim.api.nvim_buf_get_name(bufnr) == '' and not vim.bo[bufnr].modified then
      close_bufnr = bufnr
    end

    for _, entry in ipairs(entries) do
      local cmd = string.format('%s +%d %s', action, entry.lnum or 1, vim.fn.fnameescape(entry.filename or entry.value))
      local ok, err = pcall(function()
        vim.cmd(cmd)
      end)
      if not ok then
        vim.notify(tostring(err), vim.log.levels.WARN)
      end
    end

    if close_bufnr > -1 and vim.api.nvim_buf_is_valid(close_bufnr) then
      pcall(vim.api.nvim_buf_delete, close_bufnr, {})
    end
  end

  function custom_actions.multi_vsplit(prompt_bufnr)
    custom_actions.multi_action(prompt_bufnr, ':vsplit!')
  end
  function custom_actions.multi_split(prompt_bufnr)
    custom_actions.multi_action(prompt_bufnr, ':split!')
  end
  function custom_actions.multi_tabs(prompt_bufnr)
    custom_actions.multi_action(prompt_bufnr, ':tabnew!')
  end

  require('telescope').setup {
    defaults = {
      --file_ignore_patterns = { "node_modules", ".git" },
      layout_strategy = 'bottom_pane',
      layout_config = {
        height = 0.6,
        preview_width = 0.5, -- 0.7 was too wide, especially for deeply nested files
      },
      theme = 'ivy',
      mappings = {
        i = {
          ['<C-j>'] = actions.move_selection_next,
          ['<C-k>'] = actions.move_selection_previous,
          ['<C-z>'] = actions.toggle_selection,
          ['<C-v>'] = custom_actions.multi_vsplit,
          ['<C-s>'] = custom_actions.multi_split,
          ['<C-t>'] = custom_actions.multi_tabs,
        },
        n = {
          ['<C-z>'] = actions.toggle_selection,
          ['<C-v>'] = custom_actions.multi_vsplit,
          ['<C-s>'] = custom_actions.multi_split,
          ['<C-t>'] = custom_actions.multi_tabs,
        },
      },
      wrap_results = false,
    },
  }

  -- Enable Telescope extensions if they are installed
  pcall(require('telescope').load_extension, 'fzf')
  pcall(require('telescope').load_extension, 'ui-select')

  -- See `:help telescope.builtin`
  local builtin = require 'telescope.builtin'
  vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
  vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
  vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
  vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = '[S]earch [F]iles' })
  vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
  vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
  vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
  vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
  vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
  vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
  vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

  -- It's also possible to pass additional configuration options.
  --  See `:help telescope.builtin.live_grep()` for information about particular keys
  vim.keymap.set('n', '<leader>s/', function()
    builtin.live_grep {
      grep_open_files = true,
      prompt_title = 'Live Grep in Open Files',
    }
  end, { desc = '[S]earch [/] in Open Files' })

  -- Shortcut for searching your Neovim configuration files
  vim.keymap.set('n', '<leader>sn', function()
    builtin.find_files { cwd = vim.fn.stdpath 'config' }
  end, { desc = '[S]earch [N]eovim files' })
end

-- [[ LSP ]]
-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
-- used for completion, annotations and signatures of Neovim apis
require('lazydev').setup {
  library = {
    -- Load luvit types when the `vim.uv` word is found
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
  },
}

-- Mason must be set up before its dependents
require('mason').setup {}
-- Useful status updates for LSP.
require('fidget').setup {}

--  This function gets run when an LSP attaches to a particular buffer.
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    -- Rename the variable under your cursor.
    map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

    -- TODO: add a shortcut to :LspRestart because some language servers don't pick up new definitions automatically
    -- it looks like this might be changing to `:lsp restart`, according to https://github.com/neovim/nvim-lspconfig/blob/master/README.md#commands

    -- Execute a code action, usually your cursor needs to be on top of an error
    -- or a suggestion from your LSP for this to activate.
    map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

    -- Find references for the word under your cursor.
    map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

    -- Jump to the implementation of the word under your cursor.
    map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

    -- Jump to the definition of the word under your cursor. To jump back, press <C-t>.
    map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

    -- WARN: This is not Goto Definition, this is Goto Declaration.
    map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    -- Fuzzy find all the symbols in your current document.
    map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

    -- Fuzzy find all the symbols in your current workspace.
    map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

    -- Jump to the type of the word under your cursor.
    map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

    -- Highlight references of the word under your cursor when your cursor rests there for a little while.
    -- When you move your cursor, the highlights will be cleared.
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
        end,
      })
    end

    -- Toggle inlay hints, if the language server supports them
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
      map('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, '[T]oggle Inlay [H]ints')
    end
  end,
})

-- Diagnostic Config
-- See :help vim.diagnostic.Opts
vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  } or {},
  virtual_text = {
    source = 'if_many',
    spacing = 2,
    format = function(diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
  },
}

do
  -- Broadcast blink.cmp's extra completion capabilities to the servers.
  local capabilities = require('blink.cmp').get_lsp_capabilities()

  -- Enable the following language servers. They will automatically be installed.
  --  Available override keys: cmd, filetypes, capabilities, settings. See `:help lspconfig-all`
  local servers = {
    --bzl = {}, -- seems dead, trying starpls instead
    starpls = {},
    -- clangd = {},
    pyright = {},
    rust_analyzer = {},
    --copilot = {},
    cssls = {},
    emmet_language_server = {},
    lua_ls = {
      settings = {
        Lua = {
          completion = {
            callSnippet = 'Replace',
          },
          -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
          -- diagnostics = { disable = { 'missing-fields' } },
        },
      },
    },
    marksman = {},
    openscad_lsp = {},
    gopls = {}, -- golang -- need to `brew install tree-sitter-cli`
    protols = {}, -- protobuf -- need to `mise use -g rust` and maybe `cargo install protols`
    svelte = {},
    --ts_ls = {},
    vue_ls = {},
    vtsls = {
      init_options = {
        hostInfo = 'neovim',
        preferences = {
          includeCompletionsForModuleExports = true,
          includeCompletionsForImportStatements = true,
          importModuleSpecifierPreference = 'relative',
        },
      },
    },
    yamlls = {},
    zk = {
      filetypes = {
        'markdown',
      },
    },
  }

  -- Ensure the servers and tools above are installed. See `:Mason`
  local ensure_installed = vim.tbl_keys(servers or {})
  vim.list_extend(ensure_installed, {
    'stylua', -- Used to format Lua code
  })
  require('mason-tool-installer').setup { ensure_installed = ensure_installed }

  -- Translates between nvim-lspconfig server names and mason.nvim package names (e.g. lua_ls <-> lua-language-server).
  -- Servers are enabled explicitly below, so only the ones in `servers` start.
  require('mason-lspconfig').setup {
    automatic_enable = false,
  }

  -- Merge our overrides onto nvim-lspconfig's defaults (from its `lsp/` dir) and enable each server.
  for name, server in pairs(servers) do
    server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
    vim.lsp.config(name, server)
    vim.lsp.enable(name)
  end
end

-- [[ Formatting ]] adapted from https://raw.githubusercontent.com/joeyagreco/dotfiles/fecfd8bb64a7d8a40f6e604e8c2cdcc196c367e9/.config/nvim/lua/plugins/conform.lua
-- https://github.com/stevearc/conform.nvim?tab=readme-ov-file#options
require('conform').setup {
  format_on_save = function()
    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat then
      return
    end
    return { timeout_ms = 500, lsp_format = 'fallback' }
  end,

  log_level = vim.log.levels.INFO,
  -- built in formatters: https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters
  formatters_by_ft = {
    -- ["*"] = { "injected" }, -- this messes with svelte. Maybe it's useful elsewhere (html?)
    css = { 'prettier' },
    go = { 'gofmt', 'goimports' },
    html = { 'prettier' },
    javascript = { 'biome', 'biome-organize-imports', 'prettier' },
    javascriptreact = { 'biome', 'biome-organize-imports', 'prettier' },
    -- https://github.com/rhysd/fixjson
    json = { 'fixjson' },
    jsonc = { 'prettier' },
    lua = { 'stylua' },
    proto = { 'buf' },
    python = { 'ruff_check', 'ruff_fmt' },
    sh = { 'shfmt' },
    terraform = { 'terraform_fmt' },
    hcl = { 'terraform_fmt' },

    markdown = { 'prettier', 'injected' }, -- install via `yay -S pgformatter`
    pgsql = { 'pg_format' }, -- install via `yay -S pgformatter`
    sql = { 'pg_format' },
    svelte = { 'svelte_fmt' }, -- globally install prettier, prettier-plugin-svelte
    toml = { 'taplo' },
    typescript = { 'biome', 'biome-organize-imports', 'prettier' },
    typescriptreact = { 'biome', 'biome-organize-imports', 'prettier' },
    xml = { 'xmlstarlet' },
    yaml = {},
    yml = {},
    zsh = { 'shfmt' },
  },
  formatters = {
    ruff_check = {
      inherit = false,
      stdin = true,
      command = 'ruff',
      -- for now, don't need the config file but if we need in future use this format to use it
      -- args = { "check", "-", "--config", RUFF_CONFIG_FILE, "--fix", "-q" },
      args = { 'check', '-', '--fix', '-q' },
    },
    ruff_fmt = {
      inherit = false,
      stdin = true,
      command = 'ruff',
      --args = { 'format', '-', '--config', RUFF_CONFIG_FILE, '-q' },
      args = { 'format', '-', '-q' },
    },
    pg_format = {
      prepend_args = {
        '-b', -- leading commas to reduce # of lines modified when adding/removing lines
        '-s', '2' -- two space indentation
      },
      -- Refer to 'pg_format --help' for available options
    },
    svelte_fmt = {
      command = 'prettier',
      args = { '--plugin', 'prettier-plugin-svelte', '--stdin-filepath', '$FILENAME' },
    },
  },
}

vim.keymap.set('', '<leader>f', function()
  require('conform').format { async = true, lsp_format = 'fallback' }
end, { desc = '[F]ormat buffer' })

-- https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#command-to-toggle-format-on-save
vim.api.nvim_create_user_command('ToggleAutoFormat', function()
  vim.g.disable_autoformat = not vim.g.disable_autoformat
end, {
  desc = 'toggle autoformat',
})

-- [[ Snippets ]]
-- `friendly-snippets` ('rafamadriz/friendly-snippets') has premade snippets if ever wanted:
--   require('luasnip.loaders.from_vscode').lazy_load()
-- For regex support in snippets, LuaSnip needs `make install_jsregexp` run in its directory.
do
  local ls = require 'luasnip'
  ls.config.set_config {
    updateevents = 'TextChanged,TextChangedI',
    --enable_autosnippets = true,
  }
  require('luasnip.loaders.from_lua').load {
    paths = { '~/.config/nvim/snippets' },
  }
end

-- [[ Autocompletion ]]
--- @module 'blink.cmp'
--- @type blink.cmp.Config
require('blink.cmp').setup {
  keymap = {
    -- 'default' for <c-y> to accept, 'super-tab' for tab to accept, 'enter' for enter to accept
    -- See :h blink-cmp-config-keymap for defining your own keymap
    --preset = 'default',
    preset = 'super-tab',
  },

  appearance = {
    -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    nerd_font_variant = 'mono',
  },

  completion = {
    -- By default, you may press `<c-space>` to show the documentation.
    documentation = { auto_show = false, auto_show_delay_ms = 500 },
  },

  sources = {
    default = { 'snippets', 'buffer', 'lsp', 'path', 'lazydev' },
    providers = {
      lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
      buffer = {
        opts = {
          get_bufnrs = vim.api.nvim_list_bufs,
        },
      },
      dadbod = { name = 'Dadbod', module = 'vim_dadbod_completion.blink' },
      snippets = {
        score_offset = 4, -- without this, LSP results are shown first sometimes
      },
    },
    per_filetype = {
      sql = { 'dadbod', inherit_defaults = true },
    },
  },

  snippets = {
    preset = 'luasnip',
  },

  -- See :h blink-cmp-config-fuzzy
  fuzzy = { implementation = 'lua' },

  -- Shows a signature help window while you type arguments for a function
  signature = { enabled = true },
}

-- [[ Notes ]]
require('zk').setup {}

-- Highlight todo, notes, etc in comments
require('todo-comments').setup {
  signs = false,
}

-- [[ Treesitter ]] See `:help nvim-treesitter`
-- Based on kickstart.nvim's vim.pack treesitter setup
do
  -- Parsers used only as injections inside other languages. Injections never
  -- trigger a FileType event, so the on-demand install below can't catch them.
  -- Every other parser installs the first time a file of that type is opened.
  local ensure_installed = {
    'css', -- <style> blocks in html/vue/svelte
    'comment', -- TODO/FIXME in files
    'diff', -- diffs in git commit messages (fugitive)
    'html', -- html blocks in markdown
    'javascript', -- <script lang="javascript"> in html/vue/svelte
    'luadoc', -- Lua doc comments (---@param etc.)
    'markdown_inline', -- inline markdown: bold, links, code spans
    'regex', -- regexes in languages
    'typescript', -- <script lang="ts"> in vue/svelte
  }
  require('nvim-treesitter').install(ensure_installed) -- no-op for parsers already installed

  ---@param buf integer
  ---@param language string
  local function treesitter_try_attach(buf, language)
    -- Buffer may have been closed while a parser was installing
    if not vim.api.nvim_buf_is_valid(buf) then
      return
    end
    -- Bail out if no parser can be loaded for this language
    if not vim.treesitter.language.add(language) then
      return
    end

    -- Treesitter highlighting (replaces regex syntax)
    vim.treesitter.start(buf, language)

    -- Treesitter indentation, only when the language ships an indent query;
    -- otherwise keep Vim's own indentexpr
    if vim.treesitter.query.get(language, 'indents') ~= nil then
      vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end

  local available_parsers = require('nvim-treesitter').get_available()
  vim.api.nvim_create_autocmd('FileType', {
    desc = 'Start treesitter, installing the parser on first use',
    group = vim.api.nvim_create_augroup('treesitter-on-demand', { clear = true }),
    callback = function(args)
      local buf, filetype = args.buf, args.match

      -- Map filetype to parser name (e.g. 'typescriptreact' -> 'tsx', 'sh' -> 'bash')
      local language = vim.treesitter.language.get_lang(filetype)
      if not language then
        return
      end

      local installed_parsers = require('nvim-treesitter').get_installed 'parsers'
      if vim.tbl_contains(installed_parsers, language) then
        -- Parser already installed: attach now
        treesitter_try_attach(buf, language)
      elseif vim.tbl_contains(available_parsers, language) then
        -- nvim-treesitter knows this parser: build it in the background, attach when done
        require('nvim-treesitter').install(language):await(function()
          treesitter_try_attach(buf, language)
        end)
      else
        -- Not from nvim-treesitter, but Neovim may bundle one (c, lua, vim, markdown, ...)
        treesitter_try_attach(buf, language)
      end
    end,
  })
end

-- Pin enclosing function/blocks to top of window
require('treesitter-context').setup {
  max_lines = 0, -- cap how much screen the header can take (0 = no limit)
  multiline_threshold = 1, -- show only the first line of each context node
  trim_scope = 'outer', -- when over max_lines, drop outermost scopes first
  --mode = 'cursor', -- context follows cursor line ('topline' = follows top of window)
  mode = 'topline', -- context follows cursor line ('topline' = follows top of window)
}

-- [[ Diagnostics ]] nice, but only shows diagnostics for the line that I am on
require('tiny-inline-diagnostic').setup {
  preset = 'powerline',
}
vim.diagnostic.config { virtual_text = false } -- Only if needed in your configuration, if you already have native LSP diagnostics

-- [[ Jump between source and test files ]]
require('other-nvim').setup {
  mappings = {
    -- builtin mappings: livewire, angular, laravel, rails, golang, python, react, rust, elixir, clojure
    'golang',
    'react',
    'rust',
    -- custom mapping
    --{
    --  pattern = '/path/to/file/src/app/(.*)/.*.ext$',
    --  target = '/path/to/file/src/view/%1/',
    --  transformer = 'lowercase',
    --},
  },
}
-- local function diffMergeBase(commit_like)
--   return function()
--     local base = vim.fn.systemlist({ 'git', 'merge-base', commit_like, 'HEAD' })[1]
--     if vim.v.shell_error ~= 0 or not base then
--       vim.notify('git merge-base failed: ' .. (base or ''), vim.log.levels.ERROR)
--       return
--     end
--     vim.cmd('Gvdiffsplit! ' .. base)
--   end
-- end

local function defaultBaseRef()
  for _, ref in ipairs { 'origin/main', 'origin/master' } do
    vim.fn.system { 'git', 'rev-parse', '--verify', '--quiet', ref }
    if vim.v.shell_error == 0 then
      return ref
    end
  end
end

local function diffMergeBase(commit_like)
  return function()
    local ref = commit_like or defaultBaseRef()
    if not ref then
      vim.notify('no origin/main or origin/master found', vim.log.levels.ERROR)
      return
    end

    local base = vim.fn.systemlist({ 'git', 'merge-base', ref, 'HEAD' })[1]
    if vim.v.shell_error ~= 0 or not base then
      vim.notify('git merge-base failed: ' .. (base or ''), vim.log.levels.ERROR)
      return
    end
    vim.cmd('Gvdiffsplit! ' .. base)
  end
end

--vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
--vim.wo.foldmethod = 'expr'
vim.wo.foldmethod = 'indent'
vim.g.disable_autoformat = true
vim.o.expandtab = true
vim.o.foldlevelstart = 99
vim.o.shiftwidth = 2
--vim.o.smartindent = false
vim.o.tabstop = 2
vim.wo.wrap = false
vim.opt.wrap = false
vim.g.markdown_recommended_style = 0 -- https://www.reddit.com/r/neovim/comments/z2lhyz/comment/ixjb7je/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button

-- lua vim.diagnostic.open_float() -- to view diagnostics fully
vim.keymap.set('n', '<leader>y', '"+y', { desc = 'copy to system register' })
vim.keymap.set('v', '<leader>y', '"+y', { desc = 'copy to system register' })
--vim.keymap.set('v', '<leader>y', '"+y :let @*=@+<CR>', { desc = 'copy to system and primary register' })
--vim.keymap.set('n', '<leader>y', '"+y :let @*=@+<CR>', { desc = 'copy to system and primary register' })
vim.keymap.set('n', '<leader>gbl', '<cmd>Git blame -wC<CR>', { desc = 'Git blame, ignoring whitespace' })
vim.keymap.set('n', '<leader>gdi', '<cmd>Gvdiffsplit!<CR>', { desc = 'Git diff' })
vim.keymap.set('n', '<leader>gdma', diffMergeBase(), { desc = '[G]it [d]iff vs merge-base of (origin/[ma]ster or origin/[ma]in)' })
vim.keymap.set('n', '<leader>ot', '<cmd>:OtherVSplit<CR>', { desc = '[O]pen [t]est for current buffer in a split' })

vim.keymap.set('n', '<leader>wm', '<C-w>|<C-w>_', { desc = 'Maximize the active split' })
vim.keymap.set('n', '<leader>we', '<C-w>=', { desc = 'Equalize all splits' })
vim.keymap.set('n', '<leader>wc', '<cmd>vertical resize 0<CR>', { desc = 'Vertically collapse current split' })
vim.keymap.set('n', '<leader>ww', '<cmd>set wrap!<CR>', { desc = 'Toggle Word Wrap' })

-- j and k move across visual lines instead of content lines (skipping entire blocks of wrapped text)
vim.keymap.set('n', 'j', 'gj', { silent = true })
vim.keymap.set('n', 'k', 'gk', { silent = true })
-- this is a long line to test word wrap functionality and show how the cursor moves when the line is wrapped and I potentially move down a line. I will now copy this segment another time to have a very long line. -- this is a long line to test word wrap functionality and show how the cursor moves when the line is wrapped and I potentially move down a line. I will now copy this segment another time to have a very long line.

vim.keymap.set('n', '<C-tab>', '<cmd>tabnext<CR>', { desc = 'Move to next tab' })
vim.keymap.set('i', '<C-tab>', '<Esc><cmd>tabnext<CR>i', { desc = 'Move to next tab' })
vim.keymap.set('n', '<C-S-tab>', '<cmd>tabprevious<CR>', { desc = 'Move to previous tab' })
vim.keymap.set('i', '<C-S-tab>', '<Esc><cmd>tabprevious<CR>i', { desc = 'Move to previous tab' })
vim.keymap.set('n', '<C-t>', '<cmd>tabnew<CR>', { desc = 'Create a new tab' })
vim.keymap.set('i', '<C-t>', '<Esc><cmd>tabnew<CR>i', { desc = 'Create a new tab' })
--vim.keymap.set('n', '<leader>S', function()
vim.keymap.set('n', '<leader>hl', function()
  local word = vim.fn.expand '<cword>' -- get the word under the cursor
  vim.fn.setreg('/', word) -- store the word in the search register
  vim.cmd 'set hlsearch' -- enable search highlighting to show matches
end, { desc = 'highlight the word under cursor' })

vim.keymap.set('n', '<leader>KM', function()
  local builtin = require 'telescope.builtin'
  builtin.keymaps {
    --layout_strategy = "horizontal",
    --layout_config = { width = 0.6, height = 0.5 },
    sorting_strategy = 'ascending',
    prompt_title = '🔑 Keymaps',
  }
end, { desc = 'see all keymaps' })

--  "nnoremap <C-S-tab> :tabprevious<CR>
--  "inoremap <C-S-tab> <Esc>:tabprevious<CR>i
--  "nnoremap <C-tab>   :tabnext<CR>
--  "inoremap <C-tab>   <Esc>:tabnext<CR>i
--  "nnoremap <C-t>     :tabnew<CR>
--  "inoremap <C-t>     <Esc>:tabnew<CR>

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
