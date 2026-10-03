return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
	require("nvim-treesitter").setup({})

	local languages  = { "c", "lua", "python", "html", "css", "go", "cpp", "javascript" }
	require("nvim-treesitter").install(languages)

	vim.api.nvim_create_autocmd("Filetype", {
	    pattern = "*",
	    callback = function()
		pcall(vim.treesitter.start)
	    end,
	})
    end,
}
