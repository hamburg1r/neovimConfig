return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			bigfile = { enabled = true },
			dashboard = { enabled = true },
			dim = { enabled = true },
			explorer = {
				enabled = true,
			},
			git = { enabled = true },
			gitbrowse = { enabled = true },
			image = { enabled = true },
			indent = {
				enabled = true,
				only_current = true,
				animate = {
					enabled = true,
				},
				chunk = {
					enabled = false,
				},
				scope = {
					enabled = true,
					underline = true,
				},
			},
			input = { enabled = true },
			lazygit = {
				enabled = true
			},
			notifier = {
				enabled = true,
				timeout = 3000,
			},
			picker = {
				enabled = true,
				layout = {
					cycle = true,
					preset = function()
						return vim.o.columns >= 120 and "default" or "dropdown"
					end,
				},
				sources = {
					explorer = {
						layout = {
							layout = {
								width = 30,
							},
						},
					},
					projects = {
						dev = { '~/repo' },
						patterns = { '.git', 'package.json', 'pubspec.yaml', 'flake.nix' }
					}
				},
				win = {
					input = {
						keys = {
							["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
							["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
							["<c-f>"] = { "list_scroll_down", mode = { "i", "n" } },
							["<c-b>"] = { "list_scroll_up", mode = { "i", "n" } },
						},
					},
				},
			},
			quickfile = { enabled = true },
			scope = { enabled = true },
			scratch = {
				enabled = true,
			},
			scroll = { enabled = false },
			statuscolumn = {
				enabled = true,
				-- folds = {
				-- 	open = true,
				-- },
			},
			words = { enabled = true },
			styles = {
				notification = {
					-- wo = { wrap = true } -- Wrap notifications
				}
			}
		},
		keys = Keymaps.snacks,
		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					-- Setup some globals for debugging (lazy-loaded)
					_G.dd = function(...)
						Snacks.debug.inspect(...)
					end
					_G.bt = function()
						Snacks.debug.backtrace()
					end
					vim.print = _G.dd -- Override print to use snacks for `:=` command
				end,
			})
		end,
	},
	-- {
	-- 	"folke/snacks.nvim",
	-- 	priority = 1000,
	-- 	lazy = false,
	-- 	---@type snacks.Config
	-- 	opts = {
	-- 		-- your configuration comes here
	-- 		-- or leave it empty to use the default settings
	-- 		-- refer to the configuration section below
	-- 		bigfile = { enabled = true },
	-- 		dashboard = { enabled = false },
	-- 		explorer = { enabled = true },
	-- 		indent = { enabled = true },
	-- 		input = { enabled = true },
	-- 		picker = { enabled = true },
	-- 		notifier = { enabled = true },
	-- 		quickfile = { enabled = true },
	-- 		scope = { enabled = true },
	-- 		scroll = { enabled = true },
	-- 		statuscolumn = { enabled = true },
	-- 		words = { enabled = true },
	-- 	},
	-- }
}
