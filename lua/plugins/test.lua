return {
	"nvim-neotest/neotest",
	event = "VeryLazy",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"sidlatau/neotest-dart"
	},
	config = function()
		require('neotest').setup({
			adapters = {
				require('neotest-dart') {
					command = 'flutter',
					use_lsp = true
				}
			}
		})
	end
}