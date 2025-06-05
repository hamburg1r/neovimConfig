-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
	vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 100

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 15

vim.g.python_recommended_style = false

-- Tab related settings;
vim.opt.autoindent = true
vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.opt.smarttab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.shiftround = true

-- Use highlighting when doing a search;
vim.opt.showmatch = true
-- Highlight while searching;
vim.opt.hlsearch = true
-- Incremental search that shows partial matches;
vim.opt.incsearch = true

-- Always try to show a paragraph’s last line
vim.opt.display = vim.opt.display + 'lastline'
-- Use an encoding that supports unicode
vim.opt.encoding = 'utf-8'
-- Avoid wrapping a line in the middle of a word
vim.opt.linebreak = true
-- The number of screen lines to keep above and below the cursor
-- vim.opt.scrolloff = 1;
-- The number of screen columns to keep to the left and right of the cursor
-- vim.opt.sidescrolloff = 5;
-- Enable line wrapping
vim.opt.wrap = true -- use :set wrap! to disable wrap
-- Set the commands to save in history default number is 20.;
-- vim.opt.history = 1000;
-- Disables fold at startup;
vim.opt.foldenable = false;
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

vim.opt.termguicolors = true

-- Swap files folder;
vim.opt.dir = vim.fn.expand '~/.cache/nvim/swaps/'

vim.opt.undodir = vim.fn.expand '~/.cache/nvim/undodir/'
vim.opt.confirm = true

-- Shows last used command in status line
-- vim.opt.showcmd=true

-- Global status bar
vim.opt.laststatus = 3
