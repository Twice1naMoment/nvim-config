return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter", -- Only loads when you enter insert mode (makes startup faster)
  dependencies = {
    "hrsh7th/cmp-nvim-lsp", -- The LSP source
    "hrsh7th/cmp-buffer",   -- Autocomplete words from the open buffer
    "hrsh7th/cmp-path",     -- Autocomplete file paths
    "hrsh7th/cmp-cmdline",  -- Autocomplete commands in the command line
    "L3MON4D3/LuaSnip",     -- The snippet engine
    "saadparwaiz1/cmp_luasnip", -- Bridge for LuaSnip
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    -- The keybindings (Tab to select, Enter to confirm)
    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        -- Ctrl+Space to force completion menu to show
        ["<C-Space>"] = cmp.mapping.complete(),
        -- Scroll up/down in the menu
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        -- Tab / Shift+Tab to navigate the menu
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        -- Enter to confirm selection (unless a snippet is expanding)
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" }, -- The LSP source (clangd, pyright, etc.)
        { name = "luasnip" },  -- Snippets
      }, {
        { name = "buffer" },   -- Words from current buffer
        { name = "path" },     -- File paths
      }),
    })

    -- Setup completion for the command line (e.g., typing :e<tab>)
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
    })
  end,
}
