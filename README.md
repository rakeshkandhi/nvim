# Neovim Configuration

A clean and highly optimized Neovim development environment tailored for modern developers, featuring VSCode-like shortcuts, advanced LSP configurations, auto-formatting, linting, and autocomplete — managed with Neovim's native `vim.pack` package manager (0.12+), no `lazy.nvim`.

---

## ⚙️ Settings

| Option | Value |
|---|---|
| Line numbers | Absolute + Relative |
| Tab / Indent width | 4 spaces (expandtab) |
| True color | Enabled (`termguicolors`) |
| Leader key | `<Space>` |
| Spellcheck | Auto-enabled for `markdown`, `text`, `gitcommit` |

---

## 🔌 Plugins

Installed via `vim.pack.add()` in `lua/config/pack.lua` — no lazy-loading, no build hooks (treesitter parsers and telescope-fzf-native's build are handled by `dev-env-setup`'s `scripts/setup_nvim.sh` after clone/pull). Pinned revisions live in `nvim-pack-lock.json` (native equivalent of `lazy-lock.json` — see `:h vim.pack-lockfile`); update plugins with `:lua vim.pack.update()`.

| Plugin | Purpose |
|---|---|
| `nvim-treesitter` | Syntax highlighting & indentation (auto-installs parsers) |
| `nvim-lspconfig` | LSP server configs, paired with native `vim.lsp.enable()` |
| `telescope.nvim` + `telescope-fzf-native.nvim` + `plenary.nvim` | Fuzzy finder for files, grep, LSP, git |
| `nvim-autopairs` | Auto-close brackets, quotes, tags |
| `gitsigns.nvim` | Git diff gutter signs, hunk actions, inline blame |
| `nvim-lint` | Linting |
| `which-key.nvim` | Keymap discoverability popup |
| `vim-tmux-navigator` | Seamless tmux/Neovim pane navigation |
| `vim-tpipeline` | Embeds the native statusline into tmux's status bar |
| `undotree` | Graphical undo history |
| `catppuccin` | Theme (Mocha) |

Autocomplete (`vim.lsp.completion`), the statusline, format-on-save, and the file explorer (`netrw`, `<leader>e`) are native — see `lua/config/plugins/lsp.lua`, `lua/config/statusline.lua`, `lua/config/formatting.lua`, and `lua/config/netrw.lua`. No `nvim-cmp`, `lualine.nvim`, `conform.nvim`, Mason, or snippet engine.

### 🖥️ LSP Servers

Installed by `dev-env-setup`'s `scripts/install_deps.sh` (`install_lsp_tools`), not Mason — enabled here via `vim.lsp.enable()` + configs in `lua/config/plugins/lsp.lua`.

| Server | Language(s) |
|---|---|
| `pyright` | Python |
| `ts_ls` | JavaScript / TypeScript |
| `html` | HTML |
| `cssls` | CSS |
| `tailwindcss` | Tailwind CSS |
| `jsonls` | JSON |
| `yamlls` | YAML |
| `bashls` | Shell / Bash |
| `clangd` | C / C++ |
| `lua_ls` | Lua |
| `cspell_ls` | Spell-check diagnostics (all filetypes) |

### 🎨 Formatters (native, `lua/config/formatting.lua`)

| Formatter | Language(s) |
|---|---|
| `stylua` | Lua |
| `ruff format` | Python |
| `prettier` | JS, TS, JSX, TSX, JSON, JSONC, CSS, HTML, YAML, Markdown |

---

## 🎹 Keymap Reference

All keymaps use `<Space>` as the leader key.

---

### 🛠️ Core & Convenience

| Keybinding | Mode | Description |
|---|---|---|
| `gl` | Normal | Show diagnostic float under cursor |
| `<Esc>` | Normal | Clear search highlighting |
| `Ctrl + s` | Normal / Insert / Visual | Save file (skips non-modifiable buffers) |

---

### 💻 VSCode-like Editing

| Keybinding | Mode | Description |
|---|---|---|
| `Ctrl + /` or `Ctrl + _` | Normal | Toggle line comment |
| `Ctrl + /` or `Ctrl + _` | Visual | Toggle block comment |
| `Tab` | Visual | Indent selected block |
| `Shift + Tab` | Visual | Outdent selected block |
| `Alt + j` | Normal / Insert / Visual | Move line(s) down |
| `Alt + k` | Normal / Insert / Visual | Move line(s) up |
| `Alt + Shift + F` | Normal | Format document |
| `Alt + z` | Normal | Toggle line wrap |

---

### 🔍 Telescope Search

| Keybinding | Mode | Description |
|---|---|---|
| `<leader>ff` | Normal | Find files |
| `<leader>fg` | Normal | Live grep across project |
| `<leader>fw` | Normal | Grep word under cursor |
| `<leader>fb` | Normal | List open buffers |
| `<leader>fd` | Normal | Search diagnostics |
| `<leader>fh` | Normal | Search help tags |
| `<leader>fk` | Normal | Search keymaps |
| `<leader>fc` | Normal | Search commands |
| `<leader>gc` | Normal | Git commits |
| `<leader>gb` | Normal | Git branches |
| `<leader>gs` | Normal | Git status |

---

### 🗂️ File Explorer (netrw)

A persistent left sidebar (`:Lexplore`, like nvim-tree/neo-tree) — picking a file opens it in your main window and the sidebar stays open. The target window is `g:netrw_chgwin` (`:h netrw-editwindow`), not `g:netrw_browse_split` (which `:h g:netrw_browse_split` says explicitly doesn't apply to `:Lexplore`); netrw auto-points it at window 2 the first time the sidebar opens, which is exactly right for one sidebar + one main window.

| Keybinding | Mode | Description |
|---|---|---|
| `<leader>e` | Normal | Toggle the tree-view sidebar |
| `Enter` | Netrw buffer | Open the selected file in your main window (sidebar stays open) |
| `%` | Netrw buffer | Create a new file in your main window |

---

### 💡 LSP & Navigation

| Keybinding | Mode | Description |
|---|---|---|
| `gd` | Normal | Go to Definition (Telescope) |
| `gr` | Normal | Go to References (Telescope) |
| `gi` | Normal | Go to Implementation (Telescope) |
| `gt` | Normal | Go to Type Definition (Telescope) |
| `<leader>fs` | Normal | Document Symbols (Telescope) |
| `<leader>fS` | Normal | Workspace Symbols (Telescope) |
| `K` | Normal | Hover documentation |
| `<leader>rn` | Normal | Rename symbol |
| `<leader>ca` | Normal / Visual | Code actions |
| `[d` | Normal | Previous diagnostic |
| `]d` | Normal | Next diagnostic |
| `<leader>q` | Normal | Diagnostics in loclist |
| `Alt + Left` | Normal | Jump back in history |
| `Alt + Right` | Normal | Jump forward in history |

---

### 🌿 Git (Gitsigns)

| Keybinding | Mode | Description |
|---|---|---|
| `]h` | Normal | Next hunk |
| `[h` | Normal | Previous hunk |
| `<leader>hs` | Normal / Visual | Stage hunk |
| `<leader>hr` | Normal / Visual | Reset hunk |
| `<leader>hS` | Normal | Stage entire buffer |
| `<leader>hR` | Normal | Reset entire buffer |
| `<leader>hu` | Normal | Undo stage hunk |
| `<leader>hp` | Normal | Preview hunk |
| `<leader>hi` | Normal | Preview hunk inline |
| `<leader>hb` | Normal | Blame line (full) |
| `<leader>hd` | Normal | Diff this |
| `<leader>hy` | Normal | Copy commit hash from blame |
| `<leader>tb` | Normal | Toggle inline blame |

---

### 🕒 Undo History

| Keybinding | Mode | Description |
|---|---|---|
| `<leader>u` | Normal | Toggle undo history tree |
