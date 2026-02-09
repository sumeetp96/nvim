return {
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    config = function()
      vim.g.lazygit_floating_window_winblend = 0 -- transparency (0 is opaque)
      vim.g.lazygit_floating_window_scaling_factor = 1.0 -- 1.0 = 100% of height/width
      vim.g.lazygit_floating_window_border_chars = { "", "", "", "", "", "", "", "" } -- Remove border for true full screen
      vim.g.lazygit_use_neovim_remote = 1
    end,
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
}
