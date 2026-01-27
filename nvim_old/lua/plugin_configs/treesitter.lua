return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/playground",
      --"p00f/nvim-ts-rainbow", -- optional: your rainbow plugin
      "windwp/nvim-autopairs",
    },
    config = function()
      local status_ok, configs = pcall(require, "nvim-treesitter.configs")
      if not status_ok then return end

      configs.setup({
        ensure_installed = "all",
        ignore_install = { "" },
        highlight = {
          enable = true,
          disable = { "" },
        },
        autopairs = {
          enable = true,
        },
        indent = {
          enable = true,
          disable = { "css" },
        },
        rainbow = {
          enable = true,
          extended_mode = true,
          max_file_lines = nil,
        },
        playground = {
          enable = true,
          disable = {},
          updatetime = 25,
          persist_queries = false,
          keybindings = {
            toggle_query_editor = "o",
            toggle_hl_groups = "i",
            toggle_injected_languages = "t",
            toggle_anonymous_nodes = "a",
            toggle_language_display = "I",
            focus_language = "f",
            unfocus_language = "F",
            update = "R",
            goto_node = "<cr>",
            show_help = "?",
          },
        },
      })
    end,
  },
}

