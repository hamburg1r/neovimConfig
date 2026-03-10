-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('custom-highlight-yank', { clear = true }),
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

-- vim.api.nvim_create_autocmd("FileType", {
-- 	group = vim.api.nvim_create_augroup('neotest-custom-events', { clear = true }),
-- 	pattern = "dart",
-- 	callback = function()
-- 		local filename = vim.api.nvim_buf_get_name(0)
-- 		if filename:match("_test.dart$") then
-- 			vim.api.nvim_exec_autocmds("User", {
-- 				pattern = "NeotestDartFile",
-- 				data = { filename = filename },
-- 			})
-- 		end
-- 	end,
-- 	desc = "Fires NeotestDartFile event for Dart test files",
-- })

--  Set autocommands for Language Server Protocol (LSP)
--  This is used to set up LspAttach which executes the lsp keymaps
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('custom-lsp-attach', { clear = true }),
	callback = function(event)
		CUSTOM.CustomFunctions.setup_keymap(CUSTOM.keymaps, {'lsp'}, event.buf)
	end,
})

-- -- Autocommands for conform.nvim to format on save and read
-- vim.api.nvim_create_autocmd({ 'BufWritePre', 'BufReadPost' }, {
-- 	group = vim.api.nvim_create_augroup('custom-conform-autoformat', { clear = true }),
-- 	callback = function(args)
-- 		require('conform').format({ bufnr = args.buf, lsp_format = 'fallback', async = true })
-- 	end,
-- 	desc = 'Autoformat with conform.nvim on save and read',
-- })
