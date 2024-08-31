# My Vim Config
今回1から再構築することにしたのでdotfilesじゃなくてneovim専用リポジトリを作成した

## How to Setup
```sh
mkdir -p ~/.cache/dpp/repos/github.com/
cd ~/.cache/dpp/repos/github.com/

mkdir vim-denops

cd ./vim-denops
git clone https://github.com/vim-denops/denops.vim
git clone https://github.com/vim-denops/denops-helloworld.vim
git clone https://github.com/vim-denops/denops-shared-server.vim
```

```sh
# Start Vim
nvim

# Run this command in Vim
:call denops_shared_server#install()
```

```sh
cd ~/.cache/dpp/repos/github.com/

mkdir Shougo
cd ./Shougo

git clone https://github.com/Shougo/dpp.vim

git clone https://github.com/Shougo/dpp-ext-installer
git clone https://github.com/Shougo/dpp-protocol-git
git clone https://github.com/Shougo/dpp-ext-lazy
git clone https://github.com/Shougo/dpp-ext-toml
```
