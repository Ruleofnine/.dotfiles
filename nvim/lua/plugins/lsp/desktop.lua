vim.pack.add({
	{
		src = "https://github.com/williamboman/mason.nvim",
		name = "mason.nvim",
	},
	{
		src = "https://github.com/mason-org/mason-lspconfig.nvim",
		name = "mason-lspconfig.nvim",
	},
	{
		src = "https://github.com/hrsh7th/nvim-cmp",
		name = "nvim-cmp",
	},
	{
		src = "https://github.com/hrsh7th/cmp-nvim-lsp",
		name = "cmp-nvim-lsp",
	},
	{
		src = "https://github.com/L3MON4D3/LuaSnip",
		name = "LuaSnip",
	},
	{
		src = "https://github.com/saadparwaiz1/cmp_luasnip",
		name = "cmp_luasnip",
	},
	{
		src = "https://github.com/hrsh7th/cmp-buffer",
		name = "cmp-buffer",
	},
	{
		src = "https://github.com/f3fora/cmp-spell",
		name = "cmp-spell",
	},
	{
		src = "https://github.com/stevearc/conform.nvim",
		name = "conform.nvim",
	},
})

vim.cmd.packadd("mason.nvim")
vim.cmd.packadd("mason-lspconfig.nvim")
vim.cmd.packadd("nvim-cmp")
vim.cmd.packadd("cmp-nvim-lsp")
vim.cmd.packadd("LuaSnip")
vim.cmd.packadd("cmp_luasnip")
vim.cmd.packadd("cmp-buffer")
vim.cmd.packadd("cmp-spell")
vim.cmd.packadd("conform.nvim")

require("mason").setup()

require("mason-lspconfig").setup({
	ensure_installed = {
		"clangd",
		"lua_ls",
		"terraformls",
	},
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("gdscript", {
	cmd = { "nc", "127.0.0.1", "6005" },
	filetypes = { "gdscript" },
	root_markers = {
		"project.godot",
		".git",
	},
	capabilities = capabilities,
})

vim.lsp.config("clangd", {
	capabilities = capabilities,
})

vim.lsp.config("lua_ls", {
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

vim.lsp.config("terraformls", {
	capabilities = capabilities,
})

vim.lsp.enable({
	"gdscript",
	"clangd",
	"lua_ls",
	"terraformls",
	"nixd",
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

		["<CR>"] = cmp.mapping.confirm({
			select = true,
		}),

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

	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	}),
})

cmp.setup.filetype({ "markdown", "text" }, {
	completion = {
		autocomplete = {
			require("cmp.types").cmp.TriggerEvent.TextChanged,
		},
	},

	sources = cmp.config.sources({
		{
			name = "buffer",
			keyword_length = 4,
			option = {
				get_bufnrs = function()
					return {
						vim.api.nvim_get_current_buf(),
					}
				end,
			},
		},
		{
			name = "spell",
		},
	}),
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local builtin = require("telescope.builtin")
		local opts = { buffer = ev.buf }

		vim.keymap.set(
			"n",
			"gd",
			function()
				builtin.lsp_definitions({
					previewer = true,
					layout_strategy = "horizontal",
					layout_config = {
						preview_width = 0.60,
					},
				})
			end,
			vim.tbl_extend("force", opts, {
				desc = "Go to definition with Telescope",
			})
		)

		vim.keymap.set(
			"n",
			"gr",
			function()
				builtin.lsp_references({
					previewer = true,
				})
			end,
			vim.tbl_extend("force", opts, {
				desc = "References with Telescope",
			})
		)
	end,
})

require("conform").setup({
	formatters_by_ft = {
		terraform = { "terraform_fmt" },
		tf = { "terraform_fmt" },
		hcl = { "terraform_fmt" },
	},

	format_on_save = {
		timeout_ms = 3000,
		lsp_format = "fallback",
	},
})

vim.filetype.add({
	extension = {
		h = "c",
		gd = "gdscript",
		gdshader = "gdshader",
		gdextension = "gdextension",
		tf = "terraform",
		tfvars = "terraform",
		hcl = "hcl",
	},

	filename = {
		[".terraformrc"] = "hcl",
		["terraform.rc"] = "hcl",
	},
})

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = {
		"*.tf",
		"*.tfvars",
	},

	callback = function()
		if vim.fn.executable("tflint") ~= 1 then
			return
		end

		vim.system({ "tflint" }, {
			text = true,
		}, function(result)
			if result.code ~= 0 and result.stdout ~= "" then
				vim.schedule(function()
					vim.notify(result.stdout, vim.log.levels.WARN)
				end)
			end
		end)
	end,
})
