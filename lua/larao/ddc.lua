vim.cmd [[

call ddc#custom#patch_global('sources', ['around'])
call ddc#custom#patch_global('sourceOptions', {
            \ '_': {
            \   'matchers': ['matcher_head'],
            \   'sorters': ['sorter_rank'],
            \ },
            \ 'around': {
            \   'mark': 'A',
            \   'minAutoCompleteLength': 1,
            \ }
            \ })
call ddc#custom#patch_global(#{
            \   ui: 'pum',
            \   autoCompleteEvents: [
            \     'InsertEnter', 'TextChangedI', 'TextChangedP',
            \   ],
            \ })
call ddc#enable()



inoremap <C-n>   <Cmd>call pum#map#insert_relative(+1)<CR>
inoremap <C-p>   <Cmd>call pum#map#insert_relative(-1)<CR>
inoremap <expr> <CR> pum#visible() ? '<Cmd>call pum#map#confirm()<CR>' : '<CR>'
inoremap <C-e>   <Cmd>call pum#map#cancel()<CR>
inoremap <PageDown> <Cmd>call pum#map#insert_relative_page(+1)<CR>
inoremap <PageUp>   <Cmd>call pum#map#insert_relative_page(-1)<CR>

]]
