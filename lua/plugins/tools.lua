return {
	{
		'nvim-flutter/flutter-tools.nvim',
		lazy = false,
		dependencies = {
			'nvim-lua/plenary.nvim',
			'stevearc/dressing.nvim', -- optional for vim.ui.select
		},
		opt = {
			ui = {
				-- the border type to use for all floating windows, the same options/formats
				-- used for ":h nvim_open_win" e.g. "single" | "shadow" | {<table-of-eight-chars>}
				border = "rounded",
				-- This determines whether notifications are show with `vim.notify` or with the plugin's custom UI
				-- please note that this option is eventually going to be deprecated and users will need to
				-- depend on plugins like `nvim-notify` instead.
				-- notification_style = 'plugin',
			},
			decorations = {
				statusline = {
					-- set to true to be able use the 'flutter_tools_decorations.app_version' in your statusline
					-- this will show the current version of the flutter app from the pubspec.yaml file
					app_version = false,
					-- set to true to be able use the 'flutter_tools_decorations.device' in your statusline
					-- this will show the currently running device if an application was started with a specific
					-- device
					device = false,
					-- set to true to be able use the 'flutter_tools_decorations.project_config' in your statusline
					-- this will show the currently selected project configuration
					project_config = false,
				}
			},
			debugger = { -- integrate with nvim dap + install dart code debugger
				enabled = false,
				-- if empty dap will not stop on any exceptions, otherwise it will stop on those specified
				-- see |:help dap.set_exception_breakpoints()| for more info
				exception_breakpoints = {},
				-- Whether to call toString() on objects in debug views like hovers and the
				-- variables list.
				-- Invoking toString() has a performance cost and may introduce side-effects,
				-- although users may expected this functionality. null is treated like false.
				evaluate_to_string_in_debug_views = true,
				register_configurations = function(paths)
					require("dap").configurations.dart = {
						--put here config that you would find in .vscode/launch.json
					}
					-- If you want to load .vscode launch.json automatically run the following:
					-- require("dap.ext.vscode").load_launchjs()
				end,
			},
			flutter_path = vim.fn.system("which flutter"):gsub("\n", ""), -- <-- this takes priority over the lookup
			flutter_lookup_cmd = "dirname $(which flutter)",              -- example "dirname $(which flutter)" or "asdf where flutter"
			root_patterns = { ".git", "pubspec.yaml" },                   -- patterns to find the root of your flutter project
			fvm = false,                                                  -- takes priority over path, uses <workspace>/.fvm/flutter_sdk if enabled
			widget_guides = {
				enabled = false,
			},
			closing_tags = {
				highlight = "ErrorMsg", -- highlight for the closing tag
				prefix = ">",           -- character to use for close tag e.g. > Widget
				priority = 10,          -- priority of virtual text in current line
				-- consider to configure this when there is a possibility of multiple virtual text items in one line
				-- see `priority` option in |:help nvim_buf_set_extmark| for more info
				enabled = true -- set to false to disable
			},
			dev_log = {
				enabled = true,
				-- filter = nil, -- optional callback to filter the log
				-- takes a log_line as string argument; returns a boolean or nil;
				-- the log_line is only added to the output if the function returns true
				notify_errors = false, -- if there is an error whilst running then notify the user
				open_cmd = "15split",  -- command to use to open the log buffer
				focus_on_open = true,  -- focus on the newly opened log window
			},
			dev_tools = {
				autostart = false,         -- autostart devtools server if not detected
				auto_open_browser = false, -- Automatically opens devtools in the browser
			},
			outline = {
				open_cmd = "30vnew", -- command to use to open the outline buffer
				auto_open = false    -- if true this will open the outline automatically when it is first populated
			},
			lsp = {
				color = { -- show the derived colours for dart variables
					enabled = false, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
					background = false, -- highlight the background
					background_color = nil, -- required, when background is transparent (i.e. background_color = { r = 19, g = 17, b = 24},)
					foreground = false, -- highlight the foreground
					virtual_text = true, -- show the highlight using virtual text
					virtual_text_str = "■", -- the virtual text character to highlight
				},
				-- on_attach = my_custom_on_attach,
				-- capabilities = my_custom_capabilities, -- e.g. lsp_status capabilities
				--- OR you can specify a function to deactivate or change or control how the config is created
				capabilities = function(config)
					config.specificThingIDontWant = false
					return config
				end,
				-- see the link below for details on each option:
				-- https://github.com/dart-lang/sdk/blob/master/pkg/analysis_server/tool/lsp_spec/README.md#client-workspace-configuration
				settings = {
					showTodos = true,
					completeFunctionCalls = true,
					-- analysisExcludedFolders = { "<path-to-flutter-sdk-packages>" },
					renameFilesWithClasses = "prompt", -- "always"
					enableSnippets = true,
					updateImportsOnRename = true,      -- Whether to update imports and other directives when files are renamed. Required for `FlutterRename` command.
				}
			}
		},
	},
	{
		"rachartier/tiny-code-action.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope.nvim" },
		},
		event = "LspAttach",
		keys = Keymaps.tiny_code_action,
		opt = {
			--- The backend to use, currently only "vim", "delta" and "difftastic" are supported
			backend = "vim",
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
	{                     -- Useful plugin to show you pending keybinds.
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
}
