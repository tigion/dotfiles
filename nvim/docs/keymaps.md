# Neovim Keymaps

<!-- prettier-ignore-start -->

<!--toc:start-->
- [Neovim Keymaps](#neovim-keymaps)
  - [Info](#info)
    - [Keymap Groups](#keymap-groups)
  - [General](#general)
    - [Goodies](#goodies)
    - [F-Keys](#f-keys)
    - [Quickfix/Location List](#quickfixlocation-list)
    - [Windows](#windows)
  - [Plugins](#plugins)
    - [bufferline.nvim](#bufferlinenvim)
    - [codeium.vim](#codeiumvim)
    - [Comment.nvim](#commentnvim)
    - [conform.nvim](#conformnvim)
    - [gitsigns.nvim](#gitsignsnvim)
    - [inc-rename.nvim](#inc-renamenvim)
    - [lsp-zero.nvim](#lsp-zeronvim)
    - [nvim-lint](#nvim-lint)
    - [nvim-tmux-navigation](#nvim-tmux-navigation)
    - [nvim-toggler](#nvim-toggler)
    - [nvim-tree](#nvim-tree)
    - [outline.nvim](#outlinenvim)
    - [telescope.nvim](#telescopenvim)
    - [todo-comments.nvim](#todo-commentsnvim)
    - [trouble.nvim](#troublenvim)
    - [vim-illuminate](#vim-illuminate)
    - [zen-mode.nvim](#zen-modenvim)
  - [ftplugin](#ftplugin)
    - [AsciiDoc](#asciidoc)
    - [Help](#help)
    - [Markdown](#markdown)
<!--toc:end-->

<!-- prettier-ignore-end -->

## Info

> [!NOTE]
> I use a German keyboard layout (qwertz), so I have adjusted some key mappings.
>
> for example: `[` -> `ü`, `]` -> `+`, `,` -> `ö`

### Keymap Groups

<!--TODO: Rework keymap groups -->

| Keymap      | Description |
| ----------- | ----------- |
| `<Leader>g` | +Git        |
| `<Leader>x` | +Trouble    |
| `ö`         | +Telescope  |

## General

### Goodies

| Mode | Keymap        | Description                       |
| ---- | ------------- | --------------------------------- |
| `n`  | `<Esc><Esc>`  | Remove search highlights          |
| `i`  | `jj`, `<C-c>` | Exit insert mode                  |
| `n`  | `<C-a>`       | Select all                        |
| `v`  | `J`           | Move selection down               |
| `v`  | `K`           | Move selection up                 |
| `n`  | `<Leader>s`   | Search and replace template (wuc) |

- `wuc` ... Word under cursor

### F-Keys

| Mode | Keymap  | Description                  |
| ---- | ------- | ---------------------------- |
|      | `<F8>`  | Toggle relative line numbers |
|      | `<F9>`  | Toggle line numbers          |
|      | `<F10>` | Toggle spell checking        |

### Quickfix/Location List

| Mode | Keymap       | Description          |
| ---- | ------------ | -------------------- |
| `n`  | `<Leader>xq` | Toggle quickfix list |
| `n`  | `+q`         | Next quickfix        |
| `n`  | `üq`         | Previous quickfix    |
| `n`  | `<Leader>xl` | Toggle location list |
| `n`  | `+l`         | Next location        |
| `n`  | `ül`         | Prev location        |

- See also [trouble.nvim](#troublenvim)

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

## Plugins

### [bufferline.nvim]

[bufferline.nvim]: https://github.com/akinsho/bufferline.nvim

| Mode | Keymap    | Description        |
| ---- | --------- | ------------------ |
| `n`  | `<Tab>`   | Go to next tab     |
| `n`  | `<S-Tab>` | Go to previous tab |

### [codeium.vim]

[codeium.vim]: https://github.com/Exafunction/codeium.vim

| Mode | Keymap      | Description                      |
| ---- | ----------- | -------------------------------- |
| `n`  | `<Leader>c` | Toggle Codeium                   |
| `i`  | `<Tab>`     | Accept completion                |
| `i`  | `<C-x>`     | Cancel/Clear current completions |
| `f`  | `<C-f>`     | Cycle completions forwards       |

- ? `<S-Tab>` for Cancel
- ? `<C-e>` for Cancel/Clear like CMP

### [Comment.nvim]

[Comment.nvim]: https://github.com/numToStr/Comment.nvim

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

### [conform.nvim]

[conform.nvim]: https://github.com/stevearc/conform.nvim

| Mode     | Keymap      | Description                     |
| -------- | ----------- | ------------------------------- |
| `n`, `v` | `<Leader>f` | Format buffer/file or selection |

### [gitsigns.nvim]

[gitsigns.nvim]: https://github.com/lewis6991/gitsigns.nvim

| Mode | Keymap       | Description                     | P    |
| ---- | ------------ | ------------------------------- | ---- |
| `n`  | `<Leader>gp` | Show (preview) git hunk         |      |
| `n`  | `<Leader>gs` | Stage git hunk                  |      |
| `n`  | `<Leader>gu` | Unstage git hunk                |      |
| `n`  | `<Leader>gR` | Reset git hunk                  |      |
| `n`  | `+g`         | Next git hunk                   |      |
| `n`  | `üg`         | Previous git hunk               |      |
| `n`  | `<Leader>gl` | Show git hunks in location list | (TR) |

- `(TR)` ... [trouble.nvim](#troublenvim) or `:lopen`

### [inc-rename.nvim]

[inc-rename.nvim]: https://github.com/smjonas/inc-rename.nvim

| Mode | Keymap       | Description                      |
| ---- | ------------ | -------------------------------- |
| `n`  | `<Leader>rn` | Rename with all references (wuc) |

### [lsp-zero.nvim]

[lsp-zero.nvim]: https://github.com/VonHeikemen/lsp-zero.nvim

| Mode | Keymap           | Description                                                                 | P   |
| ---- | ---------------- | --------------------------------------------------------------------------- | --- |
| `n`  | `K`              | Show hover information                                                      |     |
| `i`  | ~~`<C-k>`~~      | Show hover information                                                      |     |
| `n`  | `gK`             | Show signature help                                                         |     |
| `i`  | `<C-k>`          | Show signature help                                                         |     |
| `n`  | `gs`             | Show symbols in current buffer                                              | T   |
| `n`  | `gss`            | Show symbols in workspace (sbt)                                             | T   |
| `n`  | `gr`             | Show references (wuc)                                                       | T   |
| `n`  | `gd`             | Go to definition(s) (wuc)                                                   | T   |
| `n`  | `gD`             | Go to declaration (wuc)                                                     |     |
| `n`  | `gdt`            | Go to type definition(s) (wuc)                                              | T   |
| `n`  | `gI`             | Go to implementation(s)                                                     | T   |
| `n`  | `<Leader>ca`     | Show code actions                                                           |     |
| `n`  | ~~`<Leader>rn`~~ | Rename with all references (wuc)<br />-> [inc-rename.nvim](#inc-renamenvim) |     |
| `n`  | ~~`<Leader>f`~~  | Format current buffer<br />-> [conform.nvim](#conformnvim)                  |     |
| `n`  | `<Leader>d`      | Show diagnostics for current line                                           |     |
| `n`  | `<Leader>dd`     | Show diagnostics for current buffer                                         | T   |
| `n`  | `<Leader>ddd`    | Show diagnostics for all buffers                                            | T   |
| `n`  | `+d`             | Next diagnostic                                                             |     |
| `n`  | `üd`             | Previous diagnostic                                                         |     |
| `n`  | `<Leader>rs`     | Restart LSP servers for current buffer                                      |     |

- `wuc` ... Word under cursor
- `sbt` ... Same buffer (file) type?
- `T` ... [telescope.nvim](#telescopenvim)

CMP - Completion Menu:

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

### [nvim-lint]

[nvim-lint]: https://github.com/mfussenegger/nvim-lint

| Mode | Keymap          | Description              |
| ---- | --------------- | ------------------------ |
| `n`  | ~~`<Leader>l`~~ | Lint current buffer/file |

### [nvim-tmux-navigation]

[nvim-tmux-navigation]: https://github.com/alexghergh/nvim-tmux-navigation

| Mode | Keymap      | Description                    |
| ---- | ----------- | ------------------------------ |
| `n`  | `<C-h>`     | Go to the left window/pane     |
|      | `<C-j>`     | Go to the lower window/pane    |
|      | `<C-k>`     | Go to the upper window/pane    |
|      | `<C-l>`     | Go to the right window/pane    |
|      | `<C-\\>`    | Go to the previous window/pane |
|      | `<C-Space>` | Go to the next window/pane     |

### [nvim-toggler]

[nvim-toggler]: https://github.com/nguyenvukhang/nvim-toggler

| Mode    | Keymap      | Description         |
| ------- | ----------- | ------------------- |
| `n`,`v` | `<Leader>i` | Invert text/operand |

### [nvim-tree]

[nvim-tree]: https://github.com/nvim-tree/nvim-tree.lua

| Mode | Keymap      | Description          |
| ---- | ----------- | -------------------- |
| `n`  | `<Leader>e` | Toggle file explorer |

| Keymap | Description               |
| ------ | ------------------------- |
| `g?`   | Show help (exit with `q`) |

### [outline.nvim]

[outline.nvim]: https://github.com/hedyhli/outline.nvim

| Mode | Keymap      | Description               |
| ---- | ----------- | ------------------------- |
| `n`  | `<Leader>o` | Toggle outline of symbols |

### [telescope.nvim]

[telescope.nvim]: https://github.com/nvim-telescope/telescope.nvim

| Mode     | Keymap    | Description                                        |
| -------- | --------- | -------------------------------------------------- |
| `n`      | `öf`      | Find files in workspace                            |
| `n`      | `ör`      | Find previously opened files in workspace          |
| `n`      | `öb`      | Find open buffers                                  |
| `n`      | `ög`      | Find in current buffer                             |
| `n`      | `ögg`     | Find in workspace                                  |
| `n`, `v` | `öG`      | Find string under cursor or selection in workspace |
| `n`      | `öh`      | Find in help                                       |
| `n`      | `öd`      | Find in diagnostics                                |
| `n`      | `ö:`      | Find in commands                                   |
| `n`      | `ö::`     | Find in command history                            |
| `n`      | `ö/`      | Find in search history                             |
| `n`      | ~~`öc`~~  | Find in git commits in current buffer              |
| `n`      | ~~`öcc`~~ | Find in git commits                                |
| `n`      | `öt`      | Find in treesitter symbols                         |
| `n`      | `öö`      | Reopen previous Telescope search                   |
| `n`      | ~~`sf`~~  | Open file browser                                  |

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

### [todo-comments.nvim]

[todo-comments.nvim]: https://github.com/folke/todo-comments.nvim

| Mode | Keymap       | Description           | P   |
| ---- | ------------ | --------------------- | --- |
| `n`  | `öt`         | Find in TODO comments | T   |
| `n`  | `<Leader>xt` | Show TODO comments    | TR  |

- `T` ... [telescope.nvim](#telescopenvim)
- `TR` ... [trouble.nvim](#troublenvim)

### [trouble.nvim]

[trouble.nvim]: https://github.com/folke/trouble.nvim

| Mode | Keymap       | Description                  |
| ---- | ------------ | ---------------------------- |
| `n`  | `<Leader>xx` | Toggle trouble               |
| `n`  | `<Leader>xd` | Toggle document diagnostics  |
| `n`  | `<Leader>xw` | Toggle workspace diagnostics |
| `n`  | `<Leader>xL` | Toggle location list         |
| `n`  | `<Leader>xQ` | Toggle quickfix list         |

- See also [Quickfix/Location List](#quickfixlocation-list)

### [vim-illuminate]

[vim-illuminate]: https://github.com/RRethy/vim-illuminate

| Mode | Keymap | Description        |
| ---- | ------ | ------------------ |
| `n`  | `++`   | Next reference     |
| `n`  | `üü`   | Previous reference |

### [zen-mode.nvim]

[zen-mode.nvim]: https://github.com/folke/zen-mode.nvim

| Mode | Keymap      | Description     |
| ---- | ----------- | --------------- |
| `n`  | `<Leader>z` | Toggle zen mode |

## ftplugin

### AsciiDoc

| Mode | Keymap       | Description                                  |
| ---- | ------------ | -------------------------------------------- |
| `n`  | `<Leader>Ah` | Find headers (from level 2)                  |
| `n`  | `<Leader>AH` | Find headers (from level 2) to location list |

### Help

| Mode | Keymap | Description                              |
| ---- | ------ | ---------------------------------------- |
| `n`  | `gd`   | Go to help tag (definition) like `<C-]>` |

### Markdown

| Mode | Keymap       | Description                                  |
| ---- | ------------ | -------------------------------------------- |
| `n`  | `<Leader>A1` | Fix TOC generated from Marksman              |
| `n`  | `<Leader>Ah` | Find headers (from level 2)                  |
| `n`  | `<Leader>AH` | Find headers (from level 2) to location list |
