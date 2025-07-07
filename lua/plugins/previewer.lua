return {
	"OXY2DEV/markview.nvim",
	lazy = false,
	dependencies = {
		"saghen/blink.cmp"
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = "cd app && ./install.sh",
	},
	{
		'barrett-ruth/live-server.nvim',
		cmd = { 'LiveServerStart', 'LiveServerStop' },
		opts = {
			port = 8080,
			quiet = false,
			browser_command = "firefox",
		}
	},
}
