
local M = {}

local diag_noisy = false

local function apply_diag_mode()
  vim.diagnostic.config({
    virtual_text = diag_noisy,            -- inline text on/off
    signs = diag_noisy,                   -- gutter signs on/off
    underline = true,                     -- keep: low-noise signal
    update_in_insert = false,
    severity_sort = true,
    float = { border = "rounded" },
  })
end

function M.toggle_diagnostics_noise()
  diag_noisy = not diag_noisy
  apply_diag_mode()
  vim.notify("Diagnostics: " .. (diag_noisy and "NOISY" or "QUIET"), vim.log.levels.INFO)
end

-- call once at startup
apply_diag_mode()

return M
