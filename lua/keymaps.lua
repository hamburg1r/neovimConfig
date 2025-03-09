Keymaps = {
	basic = {
		-- [[ Basic Keymaps ]]
		--  See `:help vim.keymap.set()`

		-- Clear highlights on search when pressing <Esc> in normal mode
		--  See `:help hlsearch`
		{ '<Esc>', '<cmd>nohlsearch<CR>' },
		{ '<C-[>', '<cmd>nohlsearch<CR>' },

		-- Diagnostic keymaps
		-- { '<leader>q', vim.diagnostic.setloclist, desc = 'Open diagnostic Quickfix list' },

		-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
		-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
		-- is not what someone will guess without a bit more experience.
		--
		-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
		-- or just use <C-\><C-n> to exit terminal mode
		{ '<Esc><Esc>', '<C-\\><C-n>', desc = 'Exit terminal mode', mode = { 't' } },

		{ "K", vim.lsp.buf.hover, desc = "Show hover" },
		-- { "gd", vim.lsp.buf.definition, desc = "Jump to definition" },
		{
			"<leader>ca",
			function()
				require("tiny-code-action").code_action()
			end,
			noremap = true,
			silent = true
		},
	},
	snacks = {
		-- { '', function () Snacks.picker.() end, desc = '' },
		{ '<leader>b/', function () Snacks.picker.buffer() end, desc = 'Find Buffer' },

		{ '<leader>ff', function () Snacks.picker.files() end, desc = 'Find Files' },
		{ '<leader>fg', function () Snacks.picker.grep() end, desc = 'Grep in Files' },
		{ '<leader>f:', function () Snacks.picker.commands() end, desc = 'Find Command' },

		{ '<leader>cdt', function () Snacks.picker.diagnostics() end, desc = 'Diagnostics List' },
		{ '<leader>cdb', function () Snacks.picker.diagnostics_buffer() end, desc = 'Buffer Diagnostics List' },

		{ '<leader>te', function () Snacks.picker.explorer() end, desc = 'Explorer' },
		{ '<leader>tw', function () Snacks.toggle.option("wrap", { name = "Wrap" }) end, desc = 'Wrap' },
		{ '<leader>tr', function () Snacks.toggle.option("relativenumber", { name = "Relative Number" }) end, desc = 'Relative Number' },
		{ '<leader>tl', function () Snacks.toggle.line_number() end, desc = 'Number Line' },
		{ '<leader>tc', function () Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }) end, desc = 'Conceallevel' },
		{ '<leader>tt', function () Snacks.toggle.treesitter() end, desc = 'Treesitter' },
		{ '<leader>th', function () Snacks.toggle.inlay_hints() end, desc = 'Inlay Hints' },
		{ '<leader>ti', function () Snacks.toggle.indent() end, desc = 'Indent' },
		{ '<leader>td', function () Snacks.toggle.dim() end, desc = 'Dim' },
		{ '<leader>tD', function () Snacks.toggle.diagnostics() end, desc = 'Diagnostics' },
		{ '<leader>tz', function () Snacks.toggle.zoom() end, desc = 'Zoom' },
		{ '<leader>tZ', function () Snacks.toggle.zen() end, desc = 'Zen' },

		{ '<leader>go', function () Snacks.lazygit.open() end, desc = 'Open LazyGit' },
	}
}

local function compress(m, t)
	for _, keymap in ipairs(t) do
		modes = keymap.mode or { 'n' }
		for _, mode in ipairs(modes) do
			local out = {}
			local opts = {}
			out[1] = mode
			out[2] = keymap[1]
			out[3] = keymap[2]
			for k, v in pairs(keymap) do
				if k ~= 'mode' and type(k) ~= 'number' then
					opts[k] = v
				end
			end
			if opts ~= {} then
				out[4] = opts
			end
			table.insert(m, out)
		end
	end
end

for k, v in pairs(Keymaps) do
	local keys = {}
	if k == 'basic' or k == 'snacks' then
		compress(keys, v)
	end

	for t, key in pairs(keys) do
		vim.keymap.set(key[1], key[2], key[3], key[4])
	end
end
