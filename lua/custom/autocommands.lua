-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "NvimTree",
	callback = function()
		vim.opt_local.scrolloff = 0
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup('neotest-custom-events', { clear = true }),
	pattern = "dart",
	callback = function()
		local filename = vim.api.nvim_buf_get_name(0)
		if filename:match("_test.dart$") then
			vim.api.nvim_exec_autocmds("User", {
				pattern = "NeotestDartFile",
				data = { filename = filename },
			})
		end
	end,
	desc = "Fires NeotestDartFile event for Dart test files",
})

--  Set autocommands for Language Server Protocol (LSP)
--  This is used to set up LspAttach which executes the lsp keymaps
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
	callback = function(event)
		require('custom.keymaps').lsp(event.buf)
	end,
})

