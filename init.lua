-- basic setting
vim.cmd("autocmd!")

vim.opt.shell = "bash"

vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.expandtab = true
vim.opt.scrolloff = 10
vim.opt.backupskip = { "/tmp/*", "/private/tmp/*" }
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.wrap = true
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.wildignore = { "/node_modules/*" }
vim.opt.swapfile = false

-- plugin setting
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

-- ddc-source-lsp-setup
require("ddc_source_lsp_setup").setup()

-- Setup ddu.vim
vim.fn["ddu#custom#patch_local"]("file_recursive", {
	ui = "ff",
	uiParams = {
		ff = {
			filterFloatingPosition = "bottom",
			filterSplitDirection = "floating",
			floatingBorder = "rounded",
			previewFloating = true,
			previewFloatingBorder = "rounded",
			previewFloatingTitle = "Preview",
			previewSplit = "horizontal",
			prompt = "> ",
			split = "floating",
			startFilter = true,
		},
	},
	sources = {
		{
			name = { "file_rec" },
			options = {
				matchers = {
					"matcher_substring",
				},
				converters = {
					"converter_devicon",
				},
				ignoreCase = true,
			},
			params = {
				ignoreDirectories = { "node_modules", ".git", ".vscode" }
			},
		},
	},
	kindOptions = {
		file = {
			defaultAction = "open",
		}
	}
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "ddu-ff",
	callback = function()
		local opts = { noremap = true, silent = true, buffer = true }
		vim.keymap.set({ "n" }, "q", [[<Cmd>call ddu#ui#do_action("quit")<CR>]], opts)
		vim.keymap.set({ "n" }, "<CR>", [[<Cmd>call ddu#ui#do_action("itemAction")<CR>]], opts)
		vim.keymap.set({ "n" }, "i", [[<Cmd>call ddu#ui#do_action("openFilterWindow")<CR>]], opts)
	end
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "ddu-ff-filter",
	callback = function()
		local opts = { noremap = true, silent = true, buffer = true }
		vim.keymap.set({ "n", "i" }, "<CR>", [[<Esc><Cmd>close<CR>]], opts)
	end
})

vim.keymap.set({ "n" }, "ff", [[<Cmd>call ddu#start(#{name: "file_recursive"})<CR>]])


vim.fn["ddu#custom#patch_local"]("colorscheme", {
	ui = "ff",
	sources = {
		{
			name = { "colorscheme" },
			options = {
				matchers = {
					"matcher_substring",
				},
			},
		},
	},
	kindOptions = {
		colorscheme = {
			defaultAction = "set",
		},
	},
})

vim.fn["ddu#custom#patch_local"]("lsp_definition", {
	sync = true,
	ui = "ff",
	sources = {
		{
			name = { "lsp_definition" },
		}
	},
	uiParams = {
		ff = {
			immediateAction = "open",
		}
	},
	kindOptions = {
		lsp = {
			defaultAction = "open",
		},
		lsp_codeAction = {
			defaultAction = "apply",
		},
	},
})
vim.fn["ddu#custom#patch_local"]("lsp_references", {
	sync = true,
	ui = "ff",
	sources = {
		{
			name = { "lsp_references" },
		}
	},
	uiParams = {
		ff = {
			immediateAction = "open",
		}
	},
	kindOptions = {
		lsp = {
			defaultAction = "open",
		},
		lsp_codeAction = {
			defaultAction = "apply",
		},
	},
})
vim.fn["ddu#custom#patch_local"]("lsp_documentSymbol", {
	sync = true,
	ui = "ff",
	sources = {
		{
			name = { "lsp_documentSymbol" },
		}
	},
	uiParams = {
		ff = {
			immediateAction = "open",
		}
	},
	kindOptions = {
		lsp = {
			defaultAction = "open",
		},
		lsp_codeAction = {
			defaultAction = "apply",
		},
	},
})
vim.fn["ddu#custom#patch_local"]("lsp_codeAction", {
	sync = true,
	ui = "ff",
	sources = {
		{
			name = { "lsp_codeAction" },
		}
	},
	uiParams = {
		ff = {
			immediateAction = "open",
		}
	},
	kindOptions = {
		lsp = {
			defaultAction = "open",
		},
		lsp_codeAction = {
			defaultAction = "apply",
		},
	},
})



vim.keymap.set({ "n" }, "gd", [[<Cmd>call ddu#start(#{name: "lsp_definition"})<CR>]])
vim.keymap.set({ "n" }, "gr", [[<Cmd>call ddu#start(#{name: "lsp_references"})<CR>]])
vim.keymap.set({ "n" }, "gD", [[<Cmd>call ddu#start(#{name: "lsp_documentSymbol"})<CR>]])
vim.keymap.set({ "n" }, "ca", [[<Cmd>call ddu#start(#{name: "lsp_codeAction"})<CR>]])


-- Setup ddc.vim
vim.fn["ddc#custom#patch_global"]("ui", "pum")
vim.fn["ddc#custom#patch_global"]("sources", {"around", "lsp"})
vim.fn["ddc#custom#patch_global"]("sourceOptions", {
  ["_"] = {
    matchers = { "matcher_head" },
    sorters = { "sorter_rank" },
  },
	lsp = {
		mark = "lsp",
		forceCompletionPattern = "\\.\\w*|:\\w*|->\\w*",
		sorters = {"sorter_lsp-kind"}
	}
})
vim.fn["ddc#custom#patch_global"]("sourceParams", {
	lsp = {
		enableResolveItem = true,
		enableAdditionalTextEdit = true,
		enableDisplayDetail = true,
		comfirmBehavior = "replace"
	}
})

vim.keymap.set({ "i" }, "<C-n>", [[<Cmd>call pum#map#insert_relative(+1)<CR>]])
vim.keymap.set({ "i" }, "<C-p>", [[<Cmd>call pum#map#insert_relative(-1)<CR>]])
vim.keymap.set({ "i" }, "<C-y>", [[<Cmd>call pum#map#confirm()<CR>]])
vim.keymap.set({ "i" }, "<C-e>", [[<Cmd>call pum#map#cancel()<CR>]])
vim.keymap.set({ "i" }, "<PageDown>", [[<Cmd>call pum#map#insert_relative_page(+1)<CR>]])
vim.keymap.set({ "i" }, "<PageUp>", [[<Cmd>call pum#map#insert_relative_page(-1)<CR>]])

vim.fn["ddc#enable"]()


-- custom command
vim.api.nvim_create_user_command("DppInstall", "call dpp#async_ext_action('installer', 'install')", {})
vim.api.nvim_create_user_command("DppUpdate", 
	function (opts)
		local args = opts.fargs
		vim.fn["dpp#async_ext_action"]("installer", "update", { names = args })
	end,
	{ nargs = "*" }
)

-- lsp config

local lspconfig = require("lspconfig")

lspconfig.gopls.setup {}

-- treesitter config
local treesitter = require("nvim-treesitter.configs")
treesitter.setup {
	highlight = {
		enable = true
	}
}


vim.cmd[[ colorscheme everforest ]]

