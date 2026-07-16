local function lsp_keymaps(bufnr)
	local opts = { buffer = bufnr }

	vim.keymap.set(
		"n",
		"K",
		vim.lsp.buf.hover,
		vim.tbl_extend("force", opts, {
			desc = "LSP hover",
		})
	)

	vim.keymap.set(
		"n",
		"gd",
		vim.lsp.buf.definition,
		vim.tbl_extend("force", opts, {
			desc = "Go to definition",
		})
	)

	vim.keymap.set(
		"n",
		"gr",
		vim.lsp.buf.references,
		vim.tbl_extend("force", opts, {
			desc = "LSP references",
		})
	)

	vim.keymap.set(
		"n",
		"<leader>rn",
		vim.lsp.buf.rename,
		vim.tbl_extend("force", opts, {
			desc = "LSP rename",
		})
	)
end

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		lsp_keymaps(ev.buf)
	end,
})
