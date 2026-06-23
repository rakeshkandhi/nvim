# Neovim Configuration

A clean and highly optimized Neovim development environment tailored for modern developers, featuring VSCode-like shortcuts, advanced LSP configurations, auto-formatting, linting, autocomplete, and lazy loading.

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

| Plugin | Purpose |
|---|---|
| `nvim-treesitter` | Syntax highlighting & indentation (auto-installs parsers) |
| `nvim-lspconfig` + Mason | LSP server management & configuration |
| `nvim-cmp` + LuaSnip | Autocomplete & snippet engine |
| `conform.nvim` | Auto-formatting on save |
| `nvim-lint` | Linting |
| `telescope.nvim` | Fuzzy finder for files, grep, LSP, git |
| `nvim-autopairs` | Auto-close brackets, quotes, tags |
| `gitsigns.nvim` | Git diff gutter signs, hunk actions, inline blame |
| `indent-blankline.nvim` | Vertical indent guides with scope highlighting |
| `nvim-ts-context-commentstring` | Context-aware JSX/TSX commenting |
| `undotree` | Graphical undo history |
| `catppuccin` | Theme (Mocha) |

### 🖥️ LSP Servers (auto-installed via Mason)

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

### 🎨 Formatters (via conform.nvim)

| Formatter | Language(s) |
|---|---|
| `stylua` | Lua |
| `black` | Python |
| `prettier` | JS, TS, JSX, TSX, JSON, JSONC |

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
| `Ctrl + /` or `Ctrl + _` | Visual | Toggle block comment (JSX/TSX aware) |
| `Tab` | Visual | Indent selected block |
| `Shift + Tab` | Visual | Outdent selected block |
| `Alt + j` | Normal / Insert / Visual | Move line(s) down |
| `Alt + k` | Normal / Insert / Visual | Move line(s) up |
| `Alt + Shift + F` | Normal | Format document |
| `Alt + z` | Normal | Toggle line wrap |

---

### 🔍 Telescope Search (Lazy-loaded)

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
