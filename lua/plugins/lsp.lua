return {
  -- This is what bridges Mason and Neovim's native vim.lsp
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    -- 1. Configure the keymaps for LSP (like hover, definition, etc.)
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf }
	local client = vim.lsp.get_client_by_id(ev.data.client_id)
	vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, { autotrigger = true })
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
      end,
    })

    -- 2. Setup diagnostics (underlines and floating messages)
    vim.diagnostic.config({
      virtual_text = true,
      signs = true,
      update_in_insert = false,
      float = { border = "rounded" },
    })

    -- 3. Define the native LSP configs 
    -- (Since you want C, C++, Python, HTML, CSS)
    vim.lsp.config("clangd", {
      cmd = { "clangd" },
      filetypes = { "c", "cpp" },
      root_dir = vim.fs.root(0, { ".clangd", "compile_commands.json", ".git" }),
    })

    vim.lsp.config("pyright", {
      cmd = { "pyright-langserver", "--stdio" },
      filetypes = { "python" },
      root_dir = vim.fs.root(0, { "pyproject.toml", "setup.py", "requirements.txt", ".git" }),
    })

    vim.lsp.config("html", {
      cmd = { "html-lsp" }, -- or "vscode-html-language-server" depending on Mason
      filetypes = { "html" },
      root_dir = vim.fs.root(0, { ".git", "index.html" }),
    })

    vim.lsp.config("cssls", {
      cmd = { "css-lsp" }, -- or "vscode-css-language-server"
      filetypes = { "css" },
      root_dir = vim.fs.root(0, { ".git", "style.css" }),
    })

    -- 4. Enable the servers for your languages
    vim.lsp.enable("clangd")
    vim.lsp.enable("pyright")
    vim.lsp.enable("html")
    vim.lsp.enable("cssls")
  end,
}
