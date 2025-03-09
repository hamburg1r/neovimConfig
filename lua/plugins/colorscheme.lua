return {
	{ -- You can easily change to a different colorscheme.
		-- Change the name of the colorscheme plugin below, and then
		-- change the command in the config to whatever the name of that colorscheme is.
		--
		-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
		'folke/tokyonight.nvim',
		enabled = false,
		priority = 1000, -- Make sure to load this before all the other start plugins.
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require('tokyonight').setup {
				styles = {
					comments = { italic = false }, -- Disable italics in comments
				},
			}

			-- Load the colorscheme here.
			-- Like many other themes, this one has different styles, and you could load
			-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
			vim.cmd.colorscheme 'tokyonight-night'
		end,
	},

	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require('catppuccin').setup {
				transparent_background = true,
				show_end_of_buffer = true, -- shows the '~' characters after the end of buffers
				term_colors = false,       -- sets terminal colors (e.g. `g:terminal_color_0`)
				dim_inactive = {
					enabled = false,         -- dims the background color of inactive window
					shade = "dark",
					percentage = 0.15,       -- percentage of the shade to apply to the inactive window
				},
				no_italic = false,         -- Force no italic
				no_bold = false,           -- Force no bold
				no_underline = false,      -- Force no underline
				styles = {                 -- Handles the styles of general hi groups (see `:h highlight-args`):
					comments = { "italic" }, -- Change the style of comments
					conditionals = { "italic" },
					loops = {},
					functions = {},
					keywords = {},
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					properties = {},
					types = {},
					operators = {},
					-- miscs = {}, -- Uncomment to turn off hard-coded styles
				},
				color_overrides = {},
				custom_highlights = {},
				default_integrations = true,
				integrations = {
					blink_cmp = true,
					-- cmp = true,
					diffview = true,
					fidget = true,
					dap = true,
					indent_blankline = true,
					which_key = true,
					telescope = true,
					snacks = true,
					gitsigns = true,
					nvimtree = true,
					treesitter = true,
					notify = true,
					mini = {
						enabled = true,
						indentscope_color = "",
					},
					-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
				},
			}

			-- Load the colorscheme here.
			-- Like many other themes, this one has different styles, and you could load
			-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
			vim.cmd.colorscheme 'catppuccin'
		end,
	}
}
