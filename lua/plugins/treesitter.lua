return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local languages = {
        "lua",
        "vim",
        "python",
        "javascript",
        "typescript",
        "html",
        "css",
        "markdown",
        "json",
        "yaml",
      }

      local TS = require("nvim-treesitter")

      TS.setup({
        install_dir = vim.fn.stdpath("data") .. "/site",
        auto_install = true,
      })

      TS.install(languages)

      -- Highlighting, Folds & Indentation
      vim.api.nvim_create_autocmd("FileType", {
        pattern = languages,
        callback = function()
          vim.treesitter.start()

          vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.wo[0][0].foldmethod = "expr"
          vim.wo[0][0].foldenable = false
          vim.wo[0][0].foldlevel = 99

          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}
