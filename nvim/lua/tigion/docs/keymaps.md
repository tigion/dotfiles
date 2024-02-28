# Neovim Keymaps

<!-- prettier-ignore-start -->

<!--toc:start-->
- [Neovim Keymaps](#neovim-keymaps)
  - [Mappings](#mappings)
  - [Core](#core)
    - [Goodies](#goodies)
    - [Windows](#windows)
    - [F-Keys](#f-keys)
  - [Plugins](#plugins)
    - [Neovim/Tmux Navigation](#neovimtmux-navigation)
    - [CMP - Completion Menu](#cmp-completion-menu)
    - [LSP - Language Server Protocol](#lsp-language-server-protocol)
    - [Codeium](#codeium)
    - [Commenting](#commenting)
    - [Formatting](#formatting)
    - [Linting](#linting)
    - [NvimTree](#nvimtree)
    - [Telescope](#telescope)
    - [Git Signs](#git-signs)
    - [Illuminate](#illuminate)
    - [Toggler](#toggler)
    - [Trouble](#trouble)
    - [Zen Mode](#zen-mode)
    - [Tabs - Bufferline](#tabs-bufferline)
<!--toc:end-->

<!-- prettier-ignore-end -->

## Mappings

- `[` -> `ü`
- `]` -> `+`
- `,` -> `ö`

## Core

### Goodies

| Mode | Keymap        | Description                       |
| ---- | ------------- | --------------------------------- |
| `n`  | `<Esc><Esc>`  | Remove search highlights          |
| `i`  | `jj`, `<C-c>` | Exit insert mode                  |
| `n`  | `<C-a>`       | Select all                        |
| `v`  | `J`           | Move selection down               |
| `v`  | `K`           | Move selection up                 |
| `n`  | `<Leader>s`   | search and replace template (wuc) |

- `wuc` ... Word under cursor

### Windows

| Mode | Keymap         | Description                |
| ---- | -------------- | -------------------------- |
| `n`  | `sh`           | Split window horizontally  |
| `n`  | `sv`           | Split window vertically    |
| `n`  | `<C-h>`        | Go to the left window      |
| `n`  | `<C-j>`        | Go to the lower window     |
| `n`  | `<C-k>`        | Go to the upper window     |
| `n`  | `<C-l>`        | Go to the right window     |
| `n`  | `<C-w>x`       | Swap current with the next |
| `n`  | `<C-w>=`       | Equally width and height   |
| `n`  | `<C-w>q`       | Close current window       |
| `n`  | `<C-w><Left>`  | Decrease window width      |
| `n`  | `<C-w><Right>` | Increase window width      |
| `n`  | `<C-w><Down>`  | Decrease window height     |
| `n`  | `<C-w><Up>`    | Increase window height     |

### F-Keys

| Mode | Keymap  | Description                  |
| ---- | ------- | ---------------------------- |
|      | `<F8>`  | Toggle relative line numbers |
|      | `<F9>`  | Toggle line numbers          |
|      | `<F10>` | Toggle spell checking        |

## Plugins

### Neovim/Tmux Navigation

| Mode | Keymap      | Description                    |
| ---- | ----------- | ------------------------------ |
| `n`  | `<C-h>`     | Go to the left window/pane     |
|      | `<C-j>`     | Go to the lower window/pane    |
|      | `<C-k>`     | Go to the upper window/pane    |
|      | `<C-l>`     | Go to the right window/pane    |
|      | `<C-\\>`    | Go to the previous window/pane |
|      | `<C-Space>` | Go to the next window/pane     |

### CMP - Completion Menu

| Mode | Keymap            | Description                                       |
| ---- | ----------------- | ------------------------------------------------- |
| `i`  | `<CR>`, `<C-y>`   | Confirm completion                                |
| `i`  | `<C-e>`           | Cancel completion                                 |
| `i`  | `<S-CR>`, `<C-r>` | Confirm completion with replace                   |
| `i`  | `<C-Space>`       | Trigger completion menu                           |
|      | `<Down>`          | Go to the next item                               |
|      | `<Up>`            | Go to the previous item                           |
| `i`  | `<C-n>`           | Go to the next item (trigger completion menu)     |
| `i`  | `<C-p>`           | Go to the previous item (trigger completion menu) |
|      | `<C-f>`           | Go to next snippet placeholder                    |
|      | `<C-b>`           | Go to previous snippet placeholder                |
|      | `<C-u>`           | Scroll completion documentation up                |
|      | `<C-d>`           | Scroll completion documentation down              |

### LSP - Language Server Protocol

lsp-zero:

| Mode | Keymap          | Description                            |     |
| ---- | --------------- | -------------------------------------- | --- |
| `n`  | `T`             | Show hover information                 |     |
| `n`  | `K`             | Show signature help                    |     |
| `i`  | `<C-k>`         | Show signature help                    |     |
| `n`  | `sds`           | Show symbols in buffer                 | T   |
| `n`  | `sws`           | Show symbols in workspace (sbt)        | T   |
| `n`  | `sR`            | Show references (wuc)                  | T   |
| `n`  | `gD`            | Go to declaration (wuc)                |     |
| `n`  | `gd`            | Go to definition(s) (wuc)              | T   |
| `n`  | `gdt`           | Go to type definition(s) (wuc)         | T   |
| `n`  | `gI`            | Go to implementation(s)                | T   |
| `n`  | `<Leader>ca`    | Show code actions                      |     |
| `n`  | `<Leader>rn`    | Rename with all references (wuc)       | IR  |
| `n`  | ~~`<Leader>f`~~ | Format current buffer                  |     |
| `n`  | `<leader>d`     | Show diagnostics for current line      |     |
| `n`  | `<Leader>dd`    | Show diagnostics for current buffer    | T   |
| `n`  | `<Leader>ddd`   | Show diagnostics for all buffers       | T   |
| `n`  | `+d`            | Go to next diagnostic                  |     |
| `n`  | `üd`            | Go to previous diagnostic              |     |
| `n`  | `<Leader>rs`    | Restart LSP servers for current buffer |     |

- `wuc` ... Word under cursor
- `sbt` ... Same buffer (file) type?
- `T` ... Telescope
- `IR`... IncRename

### Codeium

| Mode | Keymap      | Description                      |
| ---- | ----------- | -------------------------------- |
| `n`  | `<leader>c` | Toggle Codeium                   |
| 'i'  | `<Tab>`     | Accept completion                |
| 'i'  | `<C-x>`     | Cancel/Clear current completions |
| 'f'  | `<C-f>`     | Cycle completions forwards       |

- ? `<S-Tab>` for Cancel
- ? `<C-e>` for Cancel/Clear like CMP

### Commenting

| Mode | Keymap | Description                               |
| ---- | ------ | ----------------------------------------- |
| `n`  | `gcc`  | Toggle linewise comment for current line  |
| `n`  | `gbc`  | Toggle blockwise comment for current line |
| `v`  | `gc`   | Toggle linewise comment for selection     |
| `v`  | `gb`   | Toggle blockwise comment for selection    |
| `n`  | `gco`  | Insert comment to the next line           |
| `n`  | `gcO`  | Insert comment to the previous line       |
| `n`  | `gcA`  | Insert comment to end of the current line |
| `n`  | `gc}`  | Toggle until the next blank line          |
| `n`  | `gcip` | Toggle inside of paragraph                |
| `n`  | `gca}` | Toggle around curly brackets              |

### Formatting

| Mode     | Keymap      | Description                     |
| -------- | ----------- | ------------------------------- |
| `n`, `v` | `<Leader>f` | Format buffer/file or selection |

### Linting

| Mode | Keymap      | Description                      |
| ---- | ----------- | -------------------------------- |
| `n`  | `<Leader>l` | Trigger linting for current file |

### NvimTree

| Mode | Keymap      | Description          |
| ---- | ----------- | -------------------- |
| `n`  | `<Leader>e` | Toggle file explorer |

| Keymap | Description               |
| ------ | ------------------------- |
| `g?`   | Show help (exit with `q`) |

### Telescope

| Mode | Keymap    | Description                                        |
| ---- | --------- | -------------------------------------------------- |
| `n`  | `öf`      | Find files in workspace                            |
| `n`  | `ör`      | Find previously open files in workspace            |
| `n`  | `ög`      | Find string in workspace                           |
| `n`  | `ögg`     | Find string under cursor or selection in workspace |
| `n`  | `öb`      | Find in buffers                                    |
| `n`  | `öbb`     | Find in current buffer                             |
| `n`  | `öh`      | Find in help                                       |
| `n`  | `öd`      | Find in diagnostics                                |
| `n`  | `ö:`      | Find in commands                                   |
| `n`  | `ö::`     | Find in command history                            |
| `n`  | `ö/`      | Find in search history                             |
| `n`  | ~~`öc`~~  | Find in git commits                                |
| `n`  | ~~`öcc`~~ | Find in git commits in current buffer              |
| `n`  | `öt`      | Find in treesitter symbols                         |
| `n`  | `öö`      | Reopen previous Telescope search                   |
| `n`  | ~~`sf`~~  | Open file browser                                  |

In Telescope ([Default Mappings](https://github.com/nvim-telescope/telescope.nvim#default-mappings)):

| Mode    | Keymap                     | Description                          |
| ------- | -------------------------- | ------------------------------------ |
| `i`,`n` | `<CR>`                     | Confirm selected item                |
| `i`     | `<C-j>` (`<C-n>`/`<Down>`) | Move down                            |
| `i`     | `<C-k>` (`<C-p>`/`<Up>`)   | Move up                              |
| `n`     | `q` (`<Esc>`)              | Close Telescope                      |
| `i`     | `<Esc>` (`<C-c>`)          | Close Telescope                      |
| `i`     | `<Tab>`                    | Toggle selection                     |
| `i`     | `<C-q>`                    | Send selected items to quickfix list |
| `i`     | `<C-h>`                    | Show help                            |
|         | `<C-x>`                    | Go to file selection as a split      |
|         | `<C-v>`                    | Go to file selection as a vsplit     |
|         | `<C-u>`                    | Scroll up in preview window          |
|         | `<C-d>`                    | Scroll down in preview window        |
|         | ⚠️ `<C-f>`                 | Scroll left in preview window        |
|         | ⚠️ `<C-b>`                 | Scroll right in preview window       |

### Git Signs

| Mode | Keymap      | Description                    |
| ---- | ----------- | ------------------------------ |
| `n`  | `<Leader>g` | Show git hunk for current line |

### Illuminate

| Mode | Keymap | Description              |
| ---- | ------ | ------------------------ |
| `n`  | `++`   | Go to next reference     |
| `n`  | `üü`   | Go to previous reference |

### Toggler

| Mode    | Keymap      | Description         |
| ------- | ----------- | ------------------- |
| `n`,`v` | `<Leader>i` | Invert text/operand |

### Trouble

| Mode | Keymap       | Description                  |
| ---- | ------------ | ---------------------------- |
| `n`  | `<Leader>xx` | Toggle document diagnostics  |
| `n`  | `<Leader>xX` | Toggle workspace diagnostics |
| `n`  | `<Leader>xx` | Toggle location list         |
| `n`  | `<Leader>xx` | Toggle quickfix list         |

### Zen Mode

| Mode | Keymap      | Description     |
| ---- | ----------- | --------------- |
| `n`  | `<Leader>z` | Toggle zen mode |

### Tabs - Bufferline

| Mode | Keymap    | Description        |
| ---- | --------- | ------------------ |
| `n`  | `<Tab>`   | Go to next tab     |
| `n`  | `<S-Tab>` | Go to previous tab |

---

#coding/neovim