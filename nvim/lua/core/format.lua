
local M = {}

local autoformat = true

function M.toggle_autoformat()
  autoformat = not autoformat
  vim.notify("Autoformat: " .. (autoformat and "ON" or "OFF"))
end

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    if autoformat then
      vim.lsp.buf.format({ timeout_ms = 1000 })
    end
  end,
})
function M.format()
  vim.lsp.buf.format({
    async = true,
    timeout_ms = 2000,
  })
end
vim.api.nvim_create_user_command("ToggleAutoFormatting",M.toggle_autoformat, {})
return M
