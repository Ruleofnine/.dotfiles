vim.pack.add({
	{ src = "https://github.com/williamboman/mason.nvim", name = "mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim", name = "mason-lspconfig.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig", name = "nvim-lspconfig" },
	{ src = "https://github.com/hrsh7th/nvim-cmp", name = "nvim-cmp" },
	{ src = "https://github.com/hrsh7th/cmp-nvim-lsp", name = "cmp-nvim-lsp" },
	{ src = "https://github.com/L3MON4D3/LuaSnip", name = "LuaSnip" },
	{ src = "https://github.com/saadparwaiz1/cmp_luasnip", name = "cmp_luasnip" },
})

vim.cmd.packadd("mason.nvim")
vim.cmd.packadd("mason-lspconfig.nvim")
vim.cmd.packadd("nvim-lspconfig")
vim.cmd.packadd("nvim-cmp")
vim.cmd.packadd("cmp-nvim-lsp")
vim.cmd.packadd("LuaSnip")
vim.cmd.packadd("cmp_luasnip")

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "clangd", "lua_ls" },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- GDScript LSP: Godot runs the server, nvim connects to it via netcat
vim.lsp.config("gdscript", {
	cmd = { "nc", "127.0.0.1", "6005" },
	filetypes = { "gdscript" },
	root_markers = { "project.godot", ".git" },
	capabilities = capabilities,
})

vim.lsp.config("clangd", {
	capabilities = capabilities,
})

vim.lsp.config("lua_ls", {
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

vim.lsp.enable("gdscript")
vim.lsp.enable("clangd")
vim.lsp.enable("lua_ls")

-- Telescope-powered definition picker with preview
local function lsp_keymaps(bufnr)
	local builtin = require("telescope.builtin")
	local opts = { buffer = bufnr }

	vim.keymap.set("n", "gd", function()
		builtin.lsp_definitions({
			previewer = true,
			layout_strategy = "horizontal",
			layout_config = { preview_width = 0.60 },
		})
	end, vim.tbl_extend("force", opts, { desc = "Goto definition (Telescope)" }))

	vim.keymap.set("n", "gr", function()
		builtin.lsp_references({ previewer = true })
	end, vim.tbl_extend("force", opts, { desc = "References (Telescope)" }))

	vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover" }))
end

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		lsp_keymaps(ev.buf)
	end,
})

vim.filetype.add({
	extension = {
		h = "c",
		gd = "gdscript",
		gdshader = "gdshader",
		gdextension = "gdextension",
	},
})

local cmp = require("cmp")
local luasnip = require("luasnip")

vim.g.cmp_enabled = true

cmp.setup({
	enabled = function()
		return vim.g.cmp_enabled
	end,
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	},
})

vim.keymap.set({ "i", "n" }, "<C-p>", function()
	vim.g.cmp_enabled = not vim.g.cmp_enabled
	vim.notify("Completion " .. (vim.g.cmp_enabled and "ENABLED" or "DISABLED"), vim.log.levels.INFO)
end, { desc = "Toggle completion (nvim-cmp)" })
