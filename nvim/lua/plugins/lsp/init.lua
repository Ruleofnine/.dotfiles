local profile = require("core.profile")

vim.pack.add({
	{
		src = "https://github.com/neovim/nvim-lspconfig",
		name = "nvim-lspconfig",
	},
})

vim.cmd.packadd("nvim-lspconfig")

require("plugins.lsp.keymaps")

if profile.is_server() then
	require("plugins.lsp.server")
else
	require("plugins.lsp.desktop")
end
