return {
  {
    "slugbyte/unruly-worker",
    lazy = false, -- load on startup so you can use mappings immediately
    priority = 900, -- load early before most keymaps
    config = function()
      local unruly_worker = require("unruly-worker")

      unruly_worker.setup({
        skip_list = {},
        unruly_options = {
          kopy_reg = "+",
          macro_reg = "q",
          seek_mode = unruly_worker.seek_mode.buffer,
          mark_mode_is_global = false,
        },
        booster = {
          default                     = true,
          easy_swap                   = true,
          easy_search                 = true,
          easy_line                   = false,
          easy_spellcheck             = false,
          easy_incrament              = true,
          easy_hlsearch               = false,
          easy_focus                  = false,
          easy_window                 = false,
          easy_jumplist               = false,
          easy_scroll                 = false,
          easy_source                 = true,
          easy_lsp                    = true,
          easy_lsp_leader             = false,
          easy_diagnostic             = false,
          easy_diagnostic_leader      = false,
          unruly_seek                 = false,
          unruly_mark                 = false,
          unruly_macro                = false,
          unruly_kopy                 = false,
          unruly_quit                 = false,
          plugin_navigator            = false,
          plugin_comment              = true,
          plugin_luasnip              = false,
          plugin_textobject           = false,
          plugin_telescope_leader     = true,
          plugin_telescope_lsp_leader = true,
          plugin_telescope_easy_jump  = true,
          plugin_telescope_diagnostic_leader = true,
        },
      })
    end,
  },
}

