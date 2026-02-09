-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Auto format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})

-- LSP - Client:on_attach
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    if client:supports_method("textDocument/implementation") then
      local map = function(keys, func, desc)
        vim.keymap.set("n", keys, func, { buffer = args.buf, desc = desc })
      end

      -- Common bindings
      map("gd", vim.lsp.buf.definition, "Go to definition")
      map("gD", vim.lsp.buf.declaration, "Go to declaration")
      map("gr", vim.lsp.buf.references, "Show references")
      map("gi", vim.lsp.buf.implementation, "Go to implementation")
      map("K", vim.lsp.buf.hover, "Hover documentation")
      map("<leader>sh", vim.lsp.buf.signature_help, "Signature help")
      map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
      map("<leader>ca", vim.lsp.buf.code_action, "Code action")
      map("<leader>cf", function()
        vim.lsp.buf.format({ async = true })
      end, "Format")

      -- Diagnostic keymaps
      map("[d", function()
        vim.diagnostic.jump({ count = 1, float = true })
      end, "Previous diagnostic")
      map("]d", function()
        vim.diagnostic.jump({ count = -1, float = true })
      end, "Next diagnostic")
      map("<leader>d", vim.diagnostic.open_float, "Show diagnostic")
      map("<leader>q", vim.diagnostic.setloclist, "Diagnostic list")

      -- Specific to JS/TS
      if client.name == "ts_ls" then
        local function ts_action(kind)
          vim.lsp.buf.code_action({
            apply = true,
            context = { only = { kind }, diagnostics = {} },
          })
        end
        map("<leader>cA", "<Cmd>LspTypescriptSourceAction<CR>", "Typescript Source Action")
        map("<leader>co", function()
          ts_action("source.organizeImports.ts")
        end, "Organize imports")
        map("<leader>cm", function()
          ts_action("source.addMissingImports.ts")
        end, "Add missing imports")
      end
    end
  end,
})
