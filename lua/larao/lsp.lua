local lspconfig = require("lspconfig")
local capabilities = require("ddc_source_lsp").make_client_capabilities()

lspconfig.rust_analyzer.setup({
  capabilities = capabilities,
})
