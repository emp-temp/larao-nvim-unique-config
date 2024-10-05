vim.fn["ddu#custom#patch_local"]("file_recursive", {
  ui = "filer",
  sources = {{ name = "file", params = {} }},
  sourceOptions = {
    _ = {
      columns = { "filename" },
    },
  },
  kindOptions = {
    file = {
      defaultAction = "open",
    },
  },
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "ddu-filer" },
  callback = function()
    local opts = { noremap = true, silent = true, buffer = true }
    vim.keymap.set("n", "<CR>", "<CMD>call ddu#ui#do_action('itemAction')<CR>", opts)
    vim.keymap.set("n", "<Space>", "<CMD>call ddu#ui#do_action('toggleSelectItem')<CR>", opts)
    vim.keymap.set("n", "o", "<CMD>call ddu#ui#do_action('expandItem', {mode = 'toggle'})<CR>", opts)
    vim.keymap.set("n", "q", "<CMD>call ddu#ui#do_action('quit')<CR>", opts)
  end
})

vim.keymap.set({ "n" }, "sf", "<CMD>call ddu#start(#{ name: 'file_recursive' })<CR>", { noremap = true, silent = true, buffer = false })

