local M = {}
local builtin = require("telescope.builtin")
vim.g.__reload_count = (vim.g.__reload_count or -1) + 1
function M.reload_config()
  vim.g.__reload_count = (vim.g.__reload_count or -1) + 1
  -- Clear any cached modules from your config
  for name, _ in pairs(package.loaded) do
    if name:match("^core") or name:match("^plugins") or name:match("^config") then
      package.loaded[name] = nil
    end
  end

  -- Re-run init.lua
  dofile(vim.fn.stdpath("config") .. "/init.lua")
  vim.notify(
    string.format("Config reloaded [%d]",vim.g.__reload_count),
    vim.log.levels.INFO,
    os.date("%H:%M:%S")
  )
end

function M.setup()
  return 0
end

vim.api.nvim_create_user_command("ReloadConfig", M.reload_config, {})

function M.ts_picker()
  return function()
    builtin.treesitter({
      show_line = true,
      previewer = true,
      layout_strategy = "horizontal",
      layout_config = { preview_width = 0.60 },
    })
  end
end


return M
