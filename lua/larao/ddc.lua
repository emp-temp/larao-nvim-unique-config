vim.fn["ddc#custom#patch_global"]('sources', { "around", "lsp" })
vim.fn["ddc#custom#patch_global"]('sourceOptions', {
  _ = {
    matchers = { "matcher_head" },
    sorters = { "sorter_rank" },
  },
  around = {
    mark = "A",
    minAutoCompleteLength = 1,
  },
  lsp = {
    mark = "lsp",
    forceCompletionPattern = "%.%w*|:%w*|%-%>%w*",
    dup = "keep",
    isVolatile = true,
  }
})
vim.fn["ddc#custom#patch_global"]("sourceParams", {
  lsp = {
    snippetEngine = vim.fn["denops#callback#register"](function(body)
      return vim.fn["vsnip#anonymous"](body)
    end),
    enableResolveItem = true,
    enableAdditionalTextEdit = true,
  }
})
vim.fn["ddc#custom#patch_global"]({
  ui = "pum",
  autoCompleteEvents = {
    "InsertEnter",
    "TextChangedI",
    "TextChagnedP"
  }
})

vim.fn["ddc#enable"]()

vim.keymap.set({ "i" }, "<C-n>", "<CMD>call pum#map#insert_relative(+1)<CR>", { noremap = true, silent = true})
vim.keymap.set({ "i" }, "<C-p>", "<CMD>call pum#map#insert_relative(-1)<CR>", { noremap = true, silent = true})
vim.keymap.set({ "i" }, "<CR>", function()
  if vim.fn["pum#visible"]() then
    return "<CMD>call pum#map#confirm()<CR>"
  else
    return "<CR>"
  end
end, { expr = true })
vim.keymap.set({ "i" }, "<PageDown>", "<CMD>call pum#map#insert_relative_page(+1)<CR>", { noremap = true, silent = true })
vim.keymap.set({ "i" }, "<PageUp>", "<CMD>call pum#map#insert_relative_page(-1)<CR>", { noremap = true, silent = true })

local capabilities = require("ddc_source_lsp").make_client_capabilities()
local lspconfig = require("lspconfig")
lspconfig.rust_analyzer.setup({
  capabilities = capabilities,
})
lspconfig.gopls.setup({
  capabilities = capabilities,
})
