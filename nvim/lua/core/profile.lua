local M = {}

M.name = vim.env.NVIM_PROFILE or "desktop"

function M.is(name)
	return M.name == name
end

function M.is_server()
	return M.name == "server"
end

function M.is_desktop()
	return M.name == "desktop"
end

vim.g.profile = M.name

return M
