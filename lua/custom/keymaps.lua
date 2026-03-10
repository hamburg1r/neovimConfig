local keymaps = {
	basic = {
		-- [[ Basic Keymaps ]]
		--  See `:help vim.keymap.set()`

		-- Clear highlights on search when pressing <Esc> in normal mode
		--  See `:help hlsearch`
		{ '<Esc>',       '<cmd>nohlsearch<CR>' },
		{ '<C-[>',       '<cmd>nohlsearch<CR>' },

		-- Diagnostic keymaps
		-- { '<leader>q', vim.diagnostic.setloclist, desc = 'Open diagnostic Quickfix list' },

		-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
		-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
		-- is not what someone will guess without a bit more experience.
		--
		-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
		-- or just use <C-\><C-n> to exit terminal mode
		{ '<Esc><Esc>',  '<C-\\><C-n>',                         desc = 'Exit terminal mode',       mode = { 't' } },
		{ "<leader>bs",  '<cmd>write<cr>',                      desc = '[S]ave' },
		{ "<leader>ba",  '<cmd>wall<cr>',                       desc = 'Save [A]ll' },
		{ "<leader>by",  '<cmd>%y *<cr>',                       desc = '[Y]ank' },

		{ "<leader>cdf", vim.diagnostic.open_float,             desc = '[F]loat' },
	},
	lsp = {
		-- Goto actions
		{ '<leader>cgd', function() Snacks.picker.lsp_definitions() end, desc = '[D]efinition' },
		{ '<leader>cgr', function() Snacks.picker.lsp_references() end, desc = '[R]eferences' },
		{ '<leader>cgi', function() Snacks.picker.lsp_implementations() end, desc = '[I]mplementation' },
		{ '<leader>cgt', function() Snacks.picker.lsp_type_definitions() end, desc = '[T]ype Definition' },
		{ '<leader>cgs', function() Snacks.picker.lsp_symbols() end, desc = 'Document [S]ymbols' },
		{ '<leader>cgw', function() Snacks.picker.lsp_workspace_symbols() end, desc = '[W]orkspace Symbols' },
		{ '<leader>cga', function() Snacks.picker.lsp_declarations() end, desc = 'Decl[A]ration' },

		-- Code actions / Refactoring
		{ '<leader>cr', vim.lsp.buf.rename, desc = '[C]ode: [R]ename' },
		{ '<leader>ca', vim.lsp.buf.code_action, desc = '[C]ode [A]ction', mode = { 'n', 'x' } },

		-- Hover / Documentation
		{ '<leader>ch', vim.lsp.buf.hover, desc = '[C]ode: [H]over' },
		{ 'K', vim.lsp.buf.hover, desc = 'Hover' },

		-- Toggle features
		{ '<leader>cth', function() Snacks.toggle.inlay_hints() end, desc = '[C]ode: [T]oggle Inlay [H]ints' },

		-- LSP Configuration / Calls
		{ '<leader>lcc', function() Snacks.picker.lsp_config() end, desc = '[L]SP [C]onfig' },
		{ '<leader>lci', function() Snacks.picker.lsp_incoming_calls() end, desc = '[L]SP [C]alls [I]ncoming' },
		{ '<leader>lco', function() Snacks.picker.lsp_outgoing_calls() end, desc = '[L]SP [C]alls [O]utgoing' },
	},
	custom = {
		{
			'<leader>\'u',
			function() CUSTOM.CustomFunctions.unicode_converter() end,
			mode = { "n", "v" },
			desc = 'Convert unicode to character'
		},
	},
	ssr = {
		{
			"<leader>cR",
			function() require("ssr").open() end,
			mode = { "n", "x", "v" },
			desc = "Structural search and replace",
		},
	},
	gitsigns = {
		{
			"]c",
			function()
				if vim.wo.diff then
					vim.cmd.normal({ "]c", bang = true })
				else
					require('gitsigns').nav_hunk('next')
				end
			end,
			desc = "Go to next diff hunk"
		},
		{
			"[c",
			function()
				if vim.wo.diff then
					vim.cmd.normal({ "[c", bang = true })
				else
					require('gitsigns').nav_hunk('prev')
				end
			end,
			desc = "Go to previous diff hunk"
		},
		{
			"<leader>ghs",
			function()
				require('gitsigns').stage_hunk()
			end,
			desc = "[S]tage"
		},
		{
			"<leader>ghr",
			function()
				require('gitsigns').reset_hunk()
			end,
			desc = "[R]eset"
		},
		{
			"<leader>ghs",
			function()
				require('gitsigns').stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end,
			mode = { "v" },
			desc = "[S]tage"
		},
		{
			"<leader>ghr",
			function()
				require('gitsigns').reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end,
			mode = { "v" },
			desc = "[R]eset"
		},
		{
			"<leader>ghS",
			function()
				require('gitsigns').stage_buffer()
			end,
			desc = "[S]tage Buffer"
		},
		{
			"<leader>ghR",
			function()
				require('gitsigns').reset_buffer()
			end,
			desc = "[R]eset Buffer"
		},
		{
			"<leader>ghp",
			function()
				require('gitsigns').preview_hunk()
			end,
			desc = "[P]review"
		},
		{
			"<leader>ghi",
			function()
				require('gitsigns').preview_hunk_inline()
			end,
			desc = "[I]nline Preview"
		},
		{
			"<leader>ghb",
			function()
				require('gitsigns').blame_line({ full = true })
			end,
			desc = "[B]lame Line (Full)"
		},
		{
			"<leader>ghd",
			function()
				require('gitsigns').diffthis()
			end,
			desc = "[D]iff Current File"
		},
		{
			"<leader>ghD",
			function()
				require('gitsigns').diffthis('~')
			end,
			desc = "[D]iff Last Commit"
		},
		{
			"<leader>ghQ",
			function()
				require('gitsigns').setqflist('all')
			end,
			desc = "[Q]uickfix All"
		},
		{
			"<leader>ghq",
			function()
				require('gitsigns').setqflist()
			end,
			desc = "[Q]uickfix Current"
		},
		{
			"<leader>tb",
			function()
				require('gitsigns').toggle_current_line_blame()
			end,
			desc = "[B]lame Current Line"
		},
		{
			"<leader>tw",
			function()
				require('gitsigns').toggle_word_diff()
			end,
			desc = "[W]ord Diff Highlighting"
		},
		{
			"ih",
			function()
				require('gitsigns').select_hunk()
			end,
			mode = { "o", "x" },
			desc = "Select hunk (text object)"
		}
	},
	git_conflict = {
		{ '<leader>gco', '<Plug>(git-conflict-ours)', desc = '[O]urs' },
		{ '<leader>gct', '<Plug>(git-conflict-theirs)', desc = '[T]heirs' },
		{ '<leader>gcb', '<Plug>(git-conflict-both)', desc = '[B]oth' },
		{ '<leader>gc0', '<Plug>(git-conflict-none)', desc = '[N]one' },
		{ '[x', '<Plug>(git-conflict-prev-conflict)', },
		{ ']x', '<Plug>(git-conflict-next-conflict)', },
	},
	tiny_code_action = {
		{
			"<leader>ca",
			function()
				require("tiny-code-action").code_action()
			end,
			noremap = true,
			silent = true,
			desc = "[A]ction"
		},
	},
	flutter_bloc = {
		{
			"<leader>cfb",
			function()
				require('flutter-bloc').create_bloc()
			end,
			desc = '[B]loc',
		},
		{
			"<leader>cfc",
			function()
				require('flutter-bloc').create_cubit()
			end,
			desc = '[C]ubit',
		},
		{
			"<leader>cf;",
			'<cmd>Telescope flutter commands<cr>',
			desc = '[;]Commands'
		},
	},
	-- needs some fixing
	dap = {
		{ '<F5>',       function() require('dap').continue() end,                                                    desc = 'Debug: Start/Continue' },
		{ '<F10>',      function() require('dap').step_over() end,                                                   desc = 'Debug: Step Over' },
		{ '<F11>',      function() require('dap').step_into() end,                                                   desc = 'Debug: Step Into' },
		{ '<F12>',      function() require('dap').step_out() end,                                                    desc = 'Debug: Step Out' },
		{ '<Leader>Bt', function() require('dap').toggle_breakpoint() end,                                           desc = '[T]oggle' },
		-- { '<Leader>B',  function() require('dap').set_breakpoint() end },
		{ '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, desc = '[P]oint' },
		{ '<Leader>dr', function() require('dap').repl.open() end,                                                   desc = '[R]EPL' },
		{ '<Leader>dl', function() require('dap').run_last() end,                                                    desc = '[L]ast Run' },
		-- Conditional breakpoint (you have the regular breakpoint but not conditional)
		{ '<Leader>Bc', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,        desc = '[C]onditional' },
		-- Clear all breakpoints
		{ '<Leader>dC', function() require('dap').clear_breakpoints() end,                                           desc = '[C]lear Breakpoints' },
		-- Terminate/stop debugging session
		{ '<Leader>dt', function() require('dap').terminate() end,                                                   desc = '[T]erminate' },
		-- Restart debugging session
		{ '<Leader>dR', function() require('dap').restart() end,                                                     desc = '[R]estart' },
		-- Go to cursor (run until cursor position)
		{ '<Leader>dc', function() require('dap').run_to_cursor() end,                                               desc = '[C]ursor' },
		-- Step back (if adapter supports it)
		{ '<S-F11>',    function() require('dap').step_back() end,                                                   desc = 'Debug: Step Back' },
		-- Reverse continue (if adapter supports it)
		{ '<S-F5>',     function() require('dap').reverse_continue() end,                                            desc = 'Debug: Reverse Continue' },
		-- Toggle DAP UI
		{ '<Leader>du', function() require('dapui').toggle() end,                                                    desc = '[U]I Toggle' },
		-- Evaluate expression
		{ '<Leader>de', function() require('dapui').eval() end,                                                      desc = '[E]val',       mode = { 'n', 'v' } },
		{
			mode = { 'n', 'v' },
			'<Leader>dh',
			function()
				require('dap.ui.widgets').hover()
			end,
			desc = '[H]over'
		}, {
			mode = { 'n', 'v' },
			'<Leader>dp',
			function()
				require('dap.ui.widgets').preview()
			end,
			desc = '[P]review',
		},
		{
			'<Leader>df',
			function()
				local widgets = require('dap.ui.widgets')
				widgets.centered_float(widgets.frames)
			end,
			desc = '[F]rames'
		}, {
			'<Leader>ds',
			function()
				local widgets = require('dap.ui.widgets')
				widgets.centered_float(widgets.scopes)
			end,
			desc = '[S]copes'
		},
	},
	snacks = {
		-- { '', function () Snacks.picker.() end, desc = '' },
		{ '<leader>bg',  function() Snacks.picker.lines() end,                                                desc = '[G]rep' },
		{ '<leader>bG',  function() Snacks.picker.grep_buffers() end,                                         desc = '[G]rep All' },
		{ '<leader>b/',  function() Snacks.picker.buffers() end,                                              desc = 'Find [/]' },
		{ '<leader>bdd', function() Snacks.bufdelete.delete() end,                                            desc = '[D]elete Current' },
		{ '<leader>bda', function() Snacks.bufdelete.all() end,                                               desc = 'Delete [A]ll' },
		{ '<leader>bdo', function() Snacks.bufdelete.other() end,                                             desc = 'Delete [O]ther' },

		{ '<leader>ff',  function() Snacks.picker.files() end,                                                desc = '[F]iles' },
		{ '<leader>fg',  function() Snacks.picker.grep() end,                                                 desc = '[G]rep' },
		{ '<leader>fp',  function() Snacks.picker.projects() end,                                             desc = '[P]rojects' },
		{ '<leader>fr',  function() Snacks.picker.recent() end,                                               desc = '[R]ecent' },
		{ '<leader>f:',  function() Snacks.picker.commands() end,                                             desc = '[:]Command' },

		{ '<leader>cdt', function() Snacks.picker.diagnostics() end,                                          desc = '[T]otal List' },
		{ '<leader>cdb', function() Snacks.picker.diagnostics_buffer() end,                                   desc = '[B]uffer List' },

		{ '<leader>te',  function() Snacks.picker.explorer() end,                                             desc = '[E]xplorer' },
		{ '<leader>tW',  function() Snacks.toggle.option("wrap", { name = "Wrap" }) end,                      desc = '[W]rap' },
		{ '<leader>tr',  function() Snacks.toggle.option("relativenumber", { name = "Relative Number" }) end, desc = '[R]elative Number' },
		{ '<leader>tl',  function() Snacks.toggle.line_number() end,                                          desc = '[L]ine Number' },
		{
			'<leader>tc',
			function()
				Snacks.toggle.option("conceallevel", {
					off = 0,
					on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2
				})
			end,
			desc = '[C]onceallevel'
		},
		{ '<leader>tt',     function() Snacks.toggle.treesitter() end,     desc = '[T]reesitter' },
		{ '<leader>ti',     function() Snacks.toggle.indent() end,         desc = '[I]ndent' },
		{ '<leader>td',     function() Snacks.toggle.dim() end,            desc = '[D]im' },
		{ '<leader>tD',     function() Snacks.toggle.diagnostics() end,    desc = '[D]iagnostics' },
		{ '<leader>tz',     function() Snacks.toggle.zoom() end,           desc = '[Z]oom' },
		{ '<leader>tZ',     function() Snacks.toggle.zen() end,            desc = '[Z]en' },

		{ '<leader>go',     function() Snacks.lazygit.open() end,          desc = '[O]pen LazyGit' },
		{ '<leader>gb',     function() Snacks.picker.git_branches() end,   desc = '[B]ranch' },
		{ '<leader>gd',     function() Snacks.picker.git_diff() end,       desc = '[D]iff' },
		{ '<leader>gl',     function() Snacks.picker.git_log() end,        desc = '[L]og' },
		{ '<leader>gL',     function() Snacks.picker.git_log_file() end,   desc = '[L]og File' },
		{ '<leader>g<c-l>', function() Snacks.picker.git_log_line() end,   desc = 'Log [L]ine' },
		{ '<leader>gs',     function() Snacks.picker.git_status() end,     desc = '[S]tatus' },
		{ '<leader>gS',     function() Snacks.picker.git_stash() end,      desc = '[S]tash' },

		{ '<leader>\'c',    function() Snacks.notifier.hide() end,         desc = '[C]lear' },
		{ '<leader>\'h',    function() Snacks.notifier.show_history() end, desc = '[H]istory' },
		{ '<leader>\'s',    function() Snacks.picker.notifications() end,  desc = '[S]how Picker' },

		{ '<leader>;h',     function() Snacks.picker.help() end,           desc = '[H]elp' },
		{ '<leader>;r',     function() Snacks.picker.registers() end,     desc = '[R]egisters' },
		{ '<leader>;k',     function() Snacks.picker.keymaps() end,      desc = '[K]eymaps' },
		{ '<leader>;m',     function() Snacks.picker.man() end,            desc = '[M]an Pages' },
		{ '<leader>;u',     function() Snacks.picker.undo() end,           desc = '[U]ndo' },
		{ '<leader>;/',     function() Snacks.picker() end,                desc = '[/]Snacks' },
		{ '<leader>.o',     function() Snacks.scratch.open() end,          desc = '[O]pen' },
		{ '<leader>.s',     function() Snacks.scratch.select() end,        desc = '[S]elect' },
	},
	conform = {
		{
			'<leader>lf',
			function()
				require('conform').format { async = true, lsp_format = 'fallback' }
			end,
			mode = '',
			desc = '[F]ormat',
		},
	}
}

return keymaps
