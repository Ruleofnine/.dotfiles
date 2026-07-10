-- ~/.config/nvim/lua/plugins/writing.lua
vim.pack.add({
	"https://github.com/folke/zen-mode.nvim",
	"https://github.com/folke/twilight.nvim",
	"https://github.com/MeanderingProgrammer/render-markdown.nvim",
	"https://github.com/nvim-mini/mini.nvim",
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "text" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		vim.opt_local.breakindent = true
		-- Keep this on if files are not huge.
		vim.opt_local.spell = true
		vim.opt_local.spelllang = { "en_us" }
		-- This can interact with markdown rendering plugins.
		vim.opt_local.conceallevel = 0
	end,
})

vim.api.nvim_create_user_command("CompletionToggle", function()
	vim.g.completion_enabled = not vim.g.completion_enabled
	if vim.g.completion_enabled then
		vim.opt.completeopt = { "menu", "menuone", "noselect" }
		print("Completion: on")
	else
		vim.opt.completeopt = {}
		print("Completion: off")
	end
end, {})

vim.keymap.set("n", "<leader>sc", ":CompletionToggle<CR>", {
	desc = "Toggle completion",
})
vim.api.nvim_create_user_command("WritingFast", function()
	vim.opt_local.spell = false
	vim.opt_local.conceallevel = 0

	pcall(function()
		require("cmp").setup.buffer({
			enabled = false,
		})
	end)

	pcall(function()
		require("render-markdown").disable()
	end)

	pcall(function()
		require("twilight").disable()
	end)

	print("Writing fast mode: spell/cmp/render/twilight disabled")
end, {})
