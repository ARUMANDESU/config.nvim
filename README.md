# nvim

My Neovim config. Started life as [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim);
it has since been restructured and is no longer a kickstart fork in shape.

Go-focused: gopls, delve, golangci-lint, goimports, plus custom Go snippets.
Keymaps assume a Colemak layout in a few places (harpoon slots, window picker hints).

## Layout

```
init.lua              leader, then requires lua/config/*
lua/config/
  options.lua         vim.o settings and diagnostic config
  keymaps.lua         global keymaps
  autocmds.lua        yank highlight, neo-tree highlight overrides
  lazy.lua            lazy.nvim bootstrap + setup
lua/plugins/          one file per plugin (or tight group); auto-imported by lazy
lua/snippets/         luasnip snippets, loaded from the LuaSnip spec
lua/util/             helpers used by the above
```

Adding a plugin: drop a file in `lua/plugins/` returning a lazy.nvim spec table.

## Requirements

- Neovim 0.11+
- `git`, `make`, `unzip`, a C compiler
- [ripgrep](https://github.com/BurntSushi/ripgrep), [fd](https://github.com/sharkdp/fd)
- A clipboard tool (`pbcopy` on macOS, `xclip`/`xsel`/`win32yank` elsewhere)
- A [Nerd Font](https://www.nerdfonts.com/) — set `vim.g.have_nerd_font = false` in `init.lua` if you don't have one
- Per language: `go` for Go, `npm` for the TypeScript/HTML/CSS servers

## Install

```sh
git clone git@github.com:ARUMANDESU/nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
nvim
```

Lazy installs everything on first start; `:Lazy` shows plugin status, `:Mason`
shows language servers and tools.
