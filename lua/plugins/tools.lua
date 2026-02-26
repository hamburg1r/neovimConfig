local Keymaps = CUSTOM.keymaps

return {
	{
		"rachartier/tiny-code-action.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope.nvim" },
		},
		event = "LspAttach",
		keys = Keymaps.tiny_code_action,
		opts = {
			--- The backend to use, currently only "vim", "delta" and "difftastic" are supported
			backend = "delta",
			backend_opts = {
				delta = {
					-- Header from delta can be quite large.
					-- You can remove them by setting this to the number of lines to remove
					header_lines_to_remove = 4,

					-- The arguments to pass to delta
					-- If you have a custom configuration file, you can set the path to it like so:
					-- args = {
					--     "--config" .. os.getenv("HOME") .. "/.config/delta/config.yml",
					-- }
					args = {
						"--line-numbers",
					},
				},
				difftastic = {
					-- Header from delta can be quite large.
					-- You can remove them by setting this to the number of lines to remove
					header_lines_to_remove = 1,

					-- The arguments to pass to difftastic
					args = {
						"--color=always",
						"--display=inline",
						"--syntax-highlight=on",
					},
				},
			},
			telescope_opts = {
				layout_strategy = "vertical",
				layout_config = {
					width = 0.7,
					height = 0.9,
					preview_cutoff = 1,
					preview_height = function(_, _, max_lines)
						local h = math.floor(max_lines * 0.5)
						return math.max(h, 10)
					end,
				},
			},
			-- The icons to use for the code actions
			-- You can add your own icons, you just need to set the exact action's kind of the code action
			-- You can set the highlight like so: { link = "DiagnosticError" } or  like nvim_set_hl ({ fg ..., bg..., bold..., ...})
			signs = {
				quickfix = { "󰁨", { link = "DiagnosticInfo" } },
				others = { "?", { link = "DiagnosticWarning" } },
				refactor = { "", { link = "DiagnosticWarning" } },
				["refactor.move"] = { "󰪹", { link = "DiagnosticInfo" } },
				["refactor.extract"] = { "", { link = "DiagnosticError" } },
				["source.organizeImports"] = { "", { link = "TelescopeResultVariable" } },
				["source.fixAll"] = { "", { link = "TelescopeResultVariable" } },
				["source"] = { "", { link = "DiagnosticError" } },
				["rename"] = { "󰑕", { link = "DiagnosticWarning" } },
				["codeAction"] = { "", { link = "DiagnosticError" } },
			},
		}
	},
	{
		'figsoda/nix-develop.nvim',
		cmd = {
			"NixDevelop",
			"NixShell",
		},
	},
	{                 -- Useful plugin to show you pending keybinds.
		'folke/which-key.nvim',
		event = 'VimEnter', -- Sets the loading event to 'VimEnter'
		opts = {
			-- delay between pressing a key and opening which-key (milliseconds)
			-- this setting is independent of vim.opt.timeoutlen
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
				{ '<leader>c', group = '[C]ode',     mode = { 'n', 'x' } },
				{ '<leader>d', group = '[D]ocument' },
				{ '<leader>r', group = '[R]ename' },
				{ '<leader>s', group = '[S]earch' },
				{ '<leader>w', group = '[W]orkspace' },
				{ '<leader>t', group = '[T]oggle' },
				{ '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
			},
		},
	},
	{
		"direnv/direnv.vim",
		lazy = false
	},
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		config = true
		-- use opts = {} for passing setup options
		-- this is equivalent to setup({}) function
	},
	{
		"cshuaimin/ssr.nvim",
		keys = Keymaps.ssr,
		-- module = "ssr",
		-- Calling setup is optional.
		config = function()
			require("ssr").setup {
				border = "rounded",
				min_width = 50,
				min_height = 5,
				max_width = 120,
				max_height = 25,
				adjust_window = true,
				keymaps = {
					close = "q",
					next_match = "n",
					prev_match = "N",
					replace_confirm = "<cr>",
					replace_all = "<leader><cr>",
				},
			}
		end
	},
	-- {
	-- 	"chrisgrieser/nvim-origami",
	-- 	event = "VeryLazy",
	-- 	opts = {}, -- required even when using default config
	--
	-- 	-- recommended: disable vim's auto-folding
	-- 	init = function()
	-- 		vim.opt.foldlevel = 99
	-- 		vim.opt.foldlevelstart = 99
	-- 	end,
	-- },
}
