-- lua/plugins/lsp/server.lua

-- Lua language server
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},

			diagnostics = {
				globals = { "vim" },
			},

			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},

			telemetry = {
				enable = false,
			},
		},
	},
})

-- Nix language server
vim.lsp.config("nil_ls", {})

vim.lsp.enable({
	"lua_ls",
	"nil_ls",
})
