-- Disable Vim's default indenting for Java
vim.api.nvim_create_autocmd("FileType", {
	pattern = "java",
	callback = function()
		vim.bo.autoindent = false
		vim.bo.smartindent = false
		vim.bo.cindent = false
		vim.cmd("set indentexpr=")
	end,
})

-- Format Java files on save if jdtls is active
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.java",
	callback = function()
		if vim.lsp.buf.server_ready() then
			vim.lsp.buf.format({ async = false })
		end
	end,
})
