local function exe(name)
  return vim.fn.executable(name) == 1
end

vim.api.nvim_create_user_command("CoreHealth", function()
  local lines = {
    "CoreHealth:",
    ("- nvim: %s"):format(vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch),
    ("- git: %s"):format(exe("git") and "OK" or "MISSING"),
    ("- rg (ripgrep): %s"):format(exe("rg") and "OK" or "MISSING"),
    ("- fd: %s"):format(exe("fd") and "OK" or "MISSING"),
    ("- node: %s"):format(exe("node") and "OK" or "MISSING"),
    ("- python3: %s"):format(exe("python3") and "OK" or "MISSING"),
  }
  vim.notify(table.concat(lines, "\n"))
end, { desc = "Check external tools Neovim commonly uses" })

