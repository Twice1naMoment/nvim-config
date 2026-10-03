local function enable_transparency()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end
return {
    {
	"takeshid/plum.nvim",
	config = function()
	    vim.opt.termguicolors = true
	    require("plum").setup({})
	    vim.cmd.colorscheme "plum"
	end,
    },
    {
	"nvim-lualine/lualine.nvim",
	dependencies = {
	    "nvim-tree/nvim-web-devicons",
	},
	opts = {
	    theme = "cyberdream",
	}
    },
}
