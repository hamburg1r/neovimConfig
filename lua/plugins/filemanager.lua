return {
	-- {
	-- 	'nvim-tree/nvim-tree.lua',
	-- 	keys = {
	-- 		{ '<leader>tt', '<cmd>NvimTreeToggle<cr>',   desc = 'Toggle NvimTree' },
	-- 		{ '<leader>tf', '<cmd>NvimTreeFocus<cr>',    desc = 'Focus NvimTree' },
	-- 		{ '<leader>tg', '<cmd>NvimTreeFindFile<cr>', desc = 'Focus File NvimTree' },
	-- 	},
	-- 	cmd = {
	-- 		"NvimTreeOpen",
	-- 		"NvimTreeFocus",
	-- 		"NvimTreeFindFile",
	-- 	},
	-- 	config = true,
	-- 	-- opts = {},
	-- },
	{
		'stevearc/oil.nvim',
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {},
		-- Optional dependencies
		dependencies = { { "nvim-mini/mini.icons", opts = {} } },
		-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
		-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
		lazy = true,
	}
}
