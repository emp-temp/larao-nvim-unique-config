local denopsSrc = "~/.cache/dpp/repos/github.com/vim-denops/denops.vim"
local denopsHello = "~/.cache/dpp/repos/github.com/vim-denops/denops-helloworld.vim"
local denopsServer = "~/.cache/dpp/repos/github.com/vim-denops/denops-shared-server.vim"
vim.opt.runtimepath:append(denopsSrc)
vim.opt.runtimepath:append(denopsHello)
vim.opt.runtimepath:append(denopsServer)

vim.g.denops_server_addr = "127.0.0.1:32123"
vim.g["denops#debug"] = 0

local dppSrc = "~/.cache/dpp/repos/github.com/Shougo/dpp.vim"
local dppBase = "~/.cache/dpp"
local dppConfig = "~/.config/nvim/dpp.ts"

local dppToml = "~/.cache/dpp/repos/github.com/Shougo/dpp-ext-toml"
local dppLazy = "~/.cache/dpp/repos/github.com/Shougo/dpp-ext-lazy"
local dppInstaller = "~/.cache/dpp/repos/github.com/Shougo/dpp-ext-installer"
local dppGit = "~/.cache/dpp/repos/github.com/Shougo/dpp-protocol-git"

vim.opt.runtimepath:append(dppSrc)
vim.opt.runtimepath:append(dppToml)
vim.opt.runtimepath:append(dppLazy)
vim.opt.runtimepath:append(dppInstaller)
vim.opt.runtimepath:append(dppGit)

local dpp = require("dpp")

if dpp.load_state(dppBase) then
	vim.api.nvim_create_autocmd("User", {
		pattern = "DenopsReady",
		callback = function ()
			vim.notify("vim load_state is failed")
			dpp.make_state(dppBase, dppConfig)
		end
	})
end

vim.api.nvim_create_autocmd("User", {
	pattern = "Dpp:makeStatePost",
	callback = function ()
		vim.notify("dpp make_state() is done")
	end
})

