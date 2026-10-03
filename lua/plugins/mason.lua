return {
  "williamboman/mason.nvim",
  build = ":MasonUpdate",
  config = function()
    require("mason").setup()

    -- Automatically install the servers for your chosen languages
    local servers = { "clangd", "pyright", "html", "cssls" } -- 'volar' for Vue/TS, if needed
    require("mason-lspconfig").setup({
      ensure_installed = servers,
      automatic_enable = true,
    })
  end,
}
