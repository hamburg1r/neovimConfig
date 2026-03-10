return {
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
	-- {
	-- 	'anuvyklack/pretty-fold.nvim',
	-- 	config = function()
	-- 		require('pretty-fold').setup()
	-- 	end
	-- },
	{
		'kevinhwang91/nvim-ufo',
		dependencies = { 'kevinhwang91/promise-async' },
		event = 'LspAttach',
		opts = {
			provider_selector = function(bufnr, filetype, buftype)
				-- For Flutter/Dart, prioritize LSP and then Treesitter
				if filetype == 'dart' then
					return { 'lsp', 'treesitter' }
				end
				-- Default to Treesitter for most languages, fallback to indent
				return { 'treesitter', 'indent' }
			end,
		},
		config = function(_, opts)
			vim.o.foldcolumn = '1' -- '0' is default, '1' provides a column for folds
			vim.o.foldlevel = 99   -- start with all folds open
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true -- enable folding

			require('ufo').setup(opts)
		end,
	},
}
