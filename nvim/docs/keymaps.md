# Neovim Keymaps

<!-- prettier-ignore-start -->

<!--toc:start-->
- [Neovim Keymaps](#neovim-keymaps)
  - [Info](#info)
    - [Keymap Groups](#keymap-groups)
  - [General](#general)
    - [Options](#options)
      - [Global options](#global-options)
      - [Local options](#local-options)
    - [Goodies](#goodies)
    - [Code Navigation](#code-navigation)
    - [Commenting](#commenting)
    - [Diagnostics](#diagnostics)
    - [Quickfix/Location List](#quickfixlocation-list)
    - [Spelling](#spelling)
    - [Buffers](#buffers)
    - [Tabs](#tabs)
    - [Windows](#windows)
    - [Others](#others)
  - [Plugins](#plugins)
    - [LSP/CMP/Snippets](#lspcmpsnippets)
      - [blink.cmp](#blinkcmp)
      - [nvim-lspconfig](#nvim-lspconfig)
    - [bufferline.nvim](#bufferlinenvim)
    - [conform.nvim](#conformnvim)
    - [flash.nvim](#flashnvim)
    - [gitsigns.nvim](#gitsignsnvim)
    - [harpoon](#harpoon)
    - [hardtime.nvim](#hardtimenvim)
    - [inc-rename.nvim](#inc-renamenvim)
    - [mini.ai](#miniai)
    - [mini.hipatterns](#minihipatterns)
    - [neogen](#neogen)
    - [nvim-lint](#nvim-lint)
    - [nvim-opposites](#nvim-opposites)
    - [nvim-sessions](#nvim-sessions)
    - [nvim-tmux-navigation](#nvim-tmux-navigation)
    - [nvim-tree](#nvim-tree)
    - [nvim-treesitter](#nvim-treesitter)
    - [outline.nvim](#outlinenvim)
    - [precognition.nvim](#precognitionnvim)
    - [render-markdown.nvim](#render-markdownnvim)
    - [snacks.words](#snackswords)
    - [snacks.notifier](#snacksnotifier)
    - [snacks.zen](#snackszen)
    - [supermaven-nvim](#supermaven-nvim)
    - [telescope.nvim](#telescopenvim)
    - [todo-comments.nvim](#todo-commentsnvim)
    - [treewalker.nvim](#treewalkernvim)
    - [trouble.nvim](#troublenvim)
    - [which-key.nvim](#which-keynvim)
    - [Deactivated](#deactivated)
      - [codeium.vim](#codeiumvim)
      - [Comment.nvim](#commentnvim)
      - [LuaSnip](#luasnip)
      - [nvim-cmp](#nvim-cmp)
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
> With `opt.langmap = 'ü[+]Ü{Ä}'` I exchanged the meaning of the characters
> `ü+ÜÄ` to `[]{}` in Normal mode.
>
> - `ü`, `+` -> `[`, `]`
> - `Ü`, `Ä` -> `{`, `}` (for `*` the default behaviour is used)

### Keymap Groups

<!--TODO: Rework keymap groups -->

| Keymap      | Description    |
| ----------- | -------------- |
| `<Leader>c` | +Code          |
| `<Leader>g` | +Git           |
| `<Leader>t` | +Toggle        |
| `<Leader>x` | +Trouble       |
| `ö`         | +Snacks.picker |
| `Ö`         | +Telescope     |

## General

### Options

#### Global options

| Mode | Keymap  | Description                  |
| ---- | ------- | ---------------------------- |
|      | `<F7>`  | Toggle line wrapping         |
|      | `<F8>`  | Toggle relative line numbers |
|      | `<F9>`  | Toggle line numbers          |
|      | `<F10>` | Toggle spell checking        |

#### Local options

| Mode | Keymap        | Description                                            |
| ---- | ------------- | ------------------------------------------------------ |
| `n`  | `<Leader>tow` | Toggle line wrapping                                   |
| `n`  | `<Leader>ton` | Toggle line numbers between absolute, relative and off |

### Goodies

| Mode     | Keymap        | Description                          |
| -------- | ------------- | ------------------------------------ |
| `n`      | `<Esc><Esc>`  | Remove search highlights             |
| `i`      | `jj`, `<C-c>` | Exit insert mode                     |
| `i`      | `jk`          | Exit insert mode and save            |
| `n`      | `<C-a>`       | Select all                           |
| `x`      | `J`           | Move selection down                  |
| `x`      | `K`           | Move selection up                    |
| `n`, `x` | `<Leader>ss`  | Search and replace template          |
| `n`      | `<Leader>sw`  | Search and replace word under cursor |
| `n`      | (`<[-Space>`) | Insert line above (normal mode)      |
| `n`      | (`<]-Space>`) | Insert line below (normal mode)      |
| `n`      | `<Leader>K`   | Neovim Help for word under cursor    |

### Code Navigation

| Mode | Keymap      | Description              |
| ---- | ----------- | ------------------------ |
| `n`  | `üm` (`[m`) | Previous method start    |
| `n`  | `+m` (`]m`) | Next method start        |
| `n`  | `üM` (`[M`) | Previous method end      |
| `n`  | `+M` (`]M`) | Next method end          |
| `n`  | `Ü` (`{`)   | Previous empty line      |
| `n`  | `Ä` (`}`)   | Next empty line          |
| `n`  | `(`         | Next paragraph           |
| `n`  | `)`         | Previous paragraph       |
| `n`  | `%`         | Jump to matching bracket |

### Commenting

| Mode | Keymap | Description                              |
| ---- | ------ | ---------------------------------------- |
| `n`  | `gcc`  | Toggle linewise comment for current line |
| `x`  | `gc`   | Toggle linewise comment for selection    |

### Diagnostics

| Mode | Keymap       | Description                   |
| ---- | ------------ | ----------------------------- |
| `n`  | `<Leader>td` | Toggle diagnostics visibility |
| `n`  | `üd` (`[d`)  | Previous diagnostic           |
| `n`  | `+d` (`]d`)  | Next diagnostic               |

### Quickfix/Location List

| Mode | Keymap       | Description          |
| ---- | ------------ | -------------------- |
| `n`  | `<Leader>xq` | Toggle quickfix list |
| `n`  | `üq` (`[q`)  | Previous quickfix    |
| `n`  | `+q` (`]q`)  | Next quickfix        |
| `n`  | `<Leader>xl` | Toggle location list |
| `n`  | `ül` (`[l`)  | Previous location    |
| `n`  | `+l` (`]l`)  | Next location        |

- See also [trouble.nvim](#troublenvim)

### Spelling

| Mode | Keymap        | Description                   |
| ---- | ------------- | ----------------------------- |
| `n`  | `<Leader>tos` | Toggle spell checking (local) |
| `n`  | `üs` (`[s`)   | Previous spelling mistake     |
| `n`  | `+s` (`]s`)   | Next spelling mistake         |

### Buffers

| Mode | Keymap      | Description     |
| ---- | ----------- | --------------- |
| `n`  | `üb` (`[b`) | Previous Buffer |
| `n`  | `+b` (`]b`) | Next Buffer     |

### Tabs

| Mode | Keymap | Description  |
| ---- | ------ | ------------ |
| `n`  | `gT`   | Previous tab |
| `n`  | `gt`   | Next tab     |

- See also [bufferline.nvim](#bufferlinenvim)

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

### Others

| Mode     | Keymap       | Description                                   |
| -------- | ------------ | --------------------------------------------- |
| `n`      | `<Leader>ui` | Inspect Pos (Treesitter highlights)           |
| `n`      | `<Leader>uI` | Inspect Tree (Treesitter highlights)          |
| `n`, `v` | `<Leader>cd` | Debug (message) for current word or selection |

## Plugins

### LSP/CMP/Snippets

#### [blink.cmp]

[blink.cmp]: https://github.com/Saghen/blink.cmp

Completion:

| Mode | Keymap                     | Description                                             |
| ---- | -------------------------- | ------------------------------------------------------- |
| `i`  | `<C-Space>`                | Show completion menu                                    |
| `i`  | `<C-e>`                    | Hide completion menu                                    |
| `i`  | `<CR>`                     | Accept                                                  |
| `i`  | `<C-j>`, `<C-n>`, `<Down>` | Select next                                             |
| `i`  | `<C-k>`, `<C-p>`, `<Up>`   | Select previous                                         |
| `i`  | `<C-y>`                    | Select and accept                                       |
| `i`  | `<C-Space>`                | Show/Hide documentation (if completion menu is visible) |
| `i`  | `<C-b>`                    | Scroll documentation up                                 |
| `i`  | `<C-f>`                    | Scroll documentation down                               |

Snippets:

| Mode     | Keymap    | Description                        |
| -------- | --------- | ---------------------------------- |
| `i`, `s` | `<Tab>`   | Go to next snippet placeholder     |
| `i`, `s` | `<S-Tab>` | Go to previous snippet placeholder |

#### [nvim-lspconfig]

<!-- ### [lsp-zero.nvim] -->

[nvim-lspconfig]: https://github.com/neovim/nvim-lspconfig

<!-- [lsp-zero.nvim]: https://github.com/VonHeikemen/lsp-zero.nvim -->

| Mode | Keymap               | Description                                                                 | P   |
| ---- | -------------------- | --------------------------------------------------------------------------- | --- |
| `n`  | (`K`)                | Show hover information                                                      |     |
| `i`  | ~~`<C-k>`~~          | Show hover information                                                      |     |
| `n`  | `gK`                 | Show signature help                                                         |     |
| `i`  | `<C-k>` (`<C-S>`)    | Show signature help                                                         |     |
| `n`  | `ti`                 | Toggle inlay hints                                                          |     |
| `n`  | `gs` (`gO`)          | Show symbols in current buffer                                              | T   |
| `n`  | `gss`                | Show symbols in workspace (sbt)                                             | T   |
| `n`  | `gr` (`grr`)         | Show references (wuc)                                                       | T   |
| `n`  | `gd`                 | Go to definition(s) (wuc)                                                   | T   |
| `n`  | `gD`                 | Go to declaration (wuc)                                                     |     |
| `n`  | `gdt`                | Go to type definition(s) (wuc)                                              | T   |
| `n`  | `gI` (`gri`)         | Go to implementation(s)                                                     | T   |
| `n`  | `<Leader>ca` (`gca`) | Show code actions                                                           |     |
| `n`  | `<Leader>rN` (`grn`) | Rename with all references (wuc)<br />-> [inc-rename.nvim](#inc-renamenvim) |     |
| `n`  | ~~`<Leader>f`~~      | Format current buffer<br />-> [conform.nvim](#conformnvim)                  |     |
| `n`  | `<Leader>d`          | Show line diagnostics                                                       |     |
| `n`  | ~~`<Leader>dd`~~     | Show diagnostics for current buffer                                         | T   |
| `n`  | ~~`<Leader>da`~~     | Show diagnostics for all buffers                                            | T   |
| `n`  | `<Leader>rs`         | Restart LSP servers for current buffer                                      |     |

- `wuc` ... Word under cursor
- `sbt` ... Same buffer (file) type?
- `T` ... [telescope.nvim](#telescopenvim)

### [bufferline.nvim]

[bufferline.nvim]: https://github.com/akinsho/bufferline.nvim

| Mode | Keymap      | Description           |
| ---- | ----------- | --------------------- |
| `n`  | ~~`+b`~~    | Go to next buffer     |
| `n`  | ~~`üb`~~    | Go to previous buffer |
| `n`  | `üt` (`[t`) | Go to previous tab    |
| `n`  | `+t` (`]t`) | Go to next tab        |

### [conform.nvim]

[conform.nvim]: https://github.com/stevearc/conform.nvim

| Mode     | Keymap       | Description                     |
| -------- | ------------ | ------------------------------- |
| `n`, `x` | `<Leader>cf` | Format buffer/file or selection |
| `n`      | `<Leader>tf` | Toggle format on save           |

### [flash.nvim]

[flash.nvim]: https://github.com/folke/flash.nvim

| Mode          | Keymap  | Description             |
| ------------- | ------- | ----------------------- |
| `n`, `x`, `o` | `s`     | Flash                   |
| `n`, `x`, `o` | `S`     | Flash treesitter        |
| `o`           | `r`     | Remote flash            |
| `o`, `x`      | `R`     | Remote flash treesitter |
| `c`           | `<C-s>` | Toggle flash search     |

> [!NOTE]
> Replaces the default `s` and `S` substitute key mappings for characterwise
> and linewise deletions. (`:help s`)

### [gitsigns.nvim]

[gitsigns.nvim]: https://github.com/lewis6991/gitsigns.nvim

| Mode | Keymap       | Description                     | P    |
| ---- | ------------ | ------------------------------- | ---- |
| `n`  | `<Leader>gp` | Peview git hunk (popup)         |      |
| `n`  | `<Leader>gP` | Preview git hunk (inline)       |      |
| `n`  | `<Leader>gs` | Stage git hunk                  |      |
| `n`  | `<Leader>gu` | Unstage git hunk                |      |
| `n`  | `<Leader>gR` | Reset git hunk                  |      |
| `n`  | `üg` (`[g`)  | Previous git hunk               |      |
| `n`  | `+g` (`]g`)  | Next git hunk                   |      |
| `n`  | `<Leader>gl` | Show git hunks in location list | (TR) |

- `(TR)` ... [trouble.nvim](#troublenvim) or `:lopen`

### [harpoon]

[harpoon]: https://github.com/ThePrimeagen/harpoon

| Mode | Keymap                     | Description                      |
| ---- | -------------------------- | -------------------------------- |
| `n`  | `<Leader>h`                | Open Harpoon quick menu          |
| `n`  | `<Leader>H`                | Add (harpoon) file to quick menu |
| `n`  | `<Leader>1` .. `<Leader>5` | Select file 1 to 9 directly      |

### [hardtime.nvim]

[hardtime.nvim]: https://github.com/m4xshen/hardtime.nvim

| Mode | Keymap        | Description     |
| ---- | ------------- | --------------- |
| `n`  | `<Leader>tha` | Toggle Hardtime |

### [inc-rename.nvim]

[inc-rename.nvim]: https://github.com/smjonas/inc-rename.nvim

| Mode | Keymap       | Description                      |
| ---- | ------------ | -------------------------------- |
| `n`  | `<Leader>rn` | Rename with all references (wuc) |

### [mini.ai]

[mini.ai]: https://github.com/nvim-mini/mini.ai

| Mode | Keymap       | Description                                                     |
| ---- | ------------ | --------------------------------------------------------------- |
| `n`  | `vab`, `vib` | Select around/in brackets (`([{`)                               |
| `n`  | `vag`, `vig` | Select around/in single/double quotes and backticks (`` "'` ``) |
| `n`  | `va#`, `vi#` | Select around/in given character (`#` is a placeholder)         |
| `n`  | ...          | ... and more                                                    |

- To expand the selection in `((...))`, use after `vib` `ib` again.

### [mini.hipatterns]

[mini.hipatterns]: https://github.com/nvim-mini/mini.hipatterns

| Mode | Keymap        | Description            |
| ---- | ------------- | ---------------------- |
| `n`  | `<Leader>thi` | Toggle mini.hipatterns |

### [neogen]

[neogen]: https://github.com/danymat/neogen

| Mode | Keymap       | Description          |
| ---- | ------------ | -------------------- |
| `n`  | `<Leader>cn` | Generate Annotations |

### [nvim-lint]

[nvim-lint]: https://github.com/mfussenegger/nvim-lint

| Mode | Keymap          | Description              |
| ---- | --------------- | ------------------------ |
| `n`  | ~~`<Leader>l`~~ | Lint current buffer/file |

### [nvim-opposites]

[nvim-opposites]: https://github.com/tigion/nvim-opposites

| Mode | Keymap      | Description             |
| ---- | ----------- | ----------------------- |
| `n`  | `<Leader>i` | Switch to opposite word |

### [nvim-sessions]

[nvim-sessions]: https://github.com/tigion/nvim-sessions

| Mode | Keymap       | Description                      |
| ---- | ------------ | -------------------------------- |
| `n`  | `<Leader>ws` | Save session (Working directory) |
| `n`  | `<Leader>wl` | Load session (Working directory) |

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

### [nvim-tree]

[nvim-tree]: https://github.com/nvim-tree/nvim-tree.lua

| Mode | Keymap      | Description          |
| ---- | ----------- | -------------------- |
| `n`  | `<Leader>e` | Toggle file explorer |

| Keymap | Description               |
| ------ | ------------------------- |
| `g?`   | Show help (exit with `q`) |

### [nvim-treesitter]

[nvim-treesitter]: https://github.com/nvim-treesitter/nvim-treesitter

| Mode | Keymap | Description                             |
| ---- | ------ | --------------------------------------- |
| `n`  | `<CR>` | Init selection (current node)           |
| `x`  | `<CR>` | Expand selection to outer (parent) node |
| `x`  | `<BS>` | Reduce selection to inner (child) node  |

### [outline.nvim]

[outline.nvim]: https://github.com/hedyhli/outline.nvim

| Mode | Keymap      | Description               |
| ---- | ----------- | ------------------------- |
| `n`  | `<Leader>o` | Toggle outline of symbols |

### [precognition.nvim]

[precognition.nvim]: https://github.com/tris203/precognition.nvim

| Mode | Keymap       | Description         |
| ---- | ------------ | ------------------- |
| `n`  | `<Leader>tp` | Toggle Precognition |

### [render-markdown.nvim]

[render-markdown.nvim]: https://github.com/MeanderingProgrammer/render-markdown.nvim

| Mode | Keymap       | Description            |
| ---- | ------------ | ---------------------- |
| `n`  | `<Leader>tm` | Toggle Render Markdown |

### [snacks.picker]

[snacks.picker]: https://github.com/folke/snacks.nvim

| Mode     | Keymap | Description                       |
| -------- | ------ | --------------------------------- |
| `n`      | `öf`   | Find files in (cwd)               |
| `n`      | `ör`   | Find recent files (cwd)           |
| `n`      | `öb`   | Find open buffers                 |
| `n`      | `ög`   | Find string (buffer)              |
| `n`      | `ögg`  | Find string (cwd)                 |
| `n`, `x` | `öw`   | Find current word/selection (cwd) |
| `n`      | `öh`   | Find help tags                    |
| `n`      | `öd`   | Find diagnostics (buffer)         |
| `n`      | `ödd`  | Find diagnostics (buffers)        |
| `n`      | `ö:`   | Find commands                     |
| `n`      | `ö::`  | Find command history              |
| `n`      | `ö/`   | Find search history               |
| `n`      | `öc`   | Find git commits (file)           |
| `n`      | `öcc`  | Find git commits                  |
| `n`      | `ös`   | Find treesitter symbols (buffer)  |
| `n`      | `öS`   | Find LSP symbols (buffer)         |
| `n`      | `öSS`  | Find LSP symbols (cwd)            |
| `n`      | `öR`   | Find registers                    |
| `n`      | `öö`   | Reopen previous search            |
| `n`      | `ööö`  | Find find sources                 |

### [snacks.words]

[snacks.words]: https://github.com/folke/snacks.nvim

| Mode | Keymap      | Description        |
| ---- | ----------- | ------------------ |
| `n`  | `üü` (`[[`) | Previous Reference |
| `n`  | `++` (`]]`) | Next Reference     |

### [snacks.notifier]

[snacks.notifier]: https://github.com/folke/snacks.nvim

| Mode | Keymap       | Description             |
| ---- | ------------ | ----------------------- |
| `n`  | `<Leader>tn` | Toggle Notifier History |

### [snacks.zen]

[snacks.zen]: https://github.com/folke/snacks.nvim

| Mode | Keymap      | Description          |
| ---- | ----------- | -------------------- |
| `n`  | `<Leader>z` | Toggle Zen Mode      |
| `n`  | `<Leader>Z` | Toggle Zen Zoom Mode |

### [supermaven-nvim]

[supermaven-nvim]: https://github.com/supermaven-inc/supermaven-nvim

| Mode | Keymap       | Description       |
| ---- | ------------ | ----------------- |
| `n`  | `<Leader>ts` | Toggle Supermaven |
| `i`  | `<Tab>`      | Accept suggestion |
| `i`  | `<C-e>`      | Clear suggestion  |
| `i`  | `<C-f>`      | Accept word       |

### [telescope.nvim]

[telescope.nvim]: https://github.com/nvim-telescope/telescope.nvim

| Mode     | Keymap    | Description                   |
| -------- | --------- | ----------------------------- |
| `n`      | `Öf`      | Find files in (cwd)           |
| `n`      | `Ör`      | Find recent (old) files (cwd) |
| `n`      | `Öb`      | Find open buffers             |
| `n`      | `Ög`      | Find string (buffer)          |
| `n`      | `Ögg`     | Find string (cwd)             |
| `n`, `x` | `Öw`      | Find current cursor (cwd)     |
| `n`      | `Öh`      | Find help tags                |
| `n`      | `Öd`      | Find diagnostics (buffer)     |
| `n`      | `Ödd`     | Find diagnostics (buffers)    |
| `n`      | `Ö:`      | Find commands                 |
| `n`      | `Ö::`     | Find command history          |
| `n`      | `Ö/`      | Find search history           |
| `n`      | ~~`Öc`~~  | Find git commits (buffer)     |
| `n`      | ~~`Öcc`~~ | Find git commits              |
| `n`      | `Ös`      | Find treesitter symbols       |
| `n`      | `ÖR`      | Find registers                |
| `n`      | `ÖÖ`      | Reopen previous search        |
| `n`      | `ÖÖÖ`     | Find telescope builtin        |

In Telescope ([Default Mappings](https://github.com/nvim-telescope/telescope.nvim#default-mappings)):

| Mode    | Keymap                     | Description                                 |
| ------- | -------------------------- | ------------------------------------------- |
| `i`,`n` | `<CR>`                     | Confirm selected item                       |
| `i`     | `<C-j>` (`<C-n>`/`<Down>`) | Move down                                   |
| `i`     | `<C-k>` (`<C-p>`/`<Up>`)   | Move up                                     |
| `n`     | `q` (`<Esc>`)              | Close Telescope                             |
| `i`     | `<Esc>` (`<C-c>`)          | Close Telescope                             |
| `i`     | `<Tab>`                    | Toggle selection and move to next selection |
| `i`     | `<S-Tab>`                  | Toggle selection and move to prev selection |
| `i`     | `<C-r>`                    | Toggle (reverse) selection of all items     |
| `i`     | `<C-q>`                    | Send all or selected items to quickfix list |
| `i`     | `<C-h>`                    | Show help                                   |
|         | `<C-x>`                    | Go to file selection as a split             |
|         | `<C-v>`                    | Go to file selection as a vsplit            |
|         | `<C-u>`                    | Scroll up in preview window                 |
|         | `<C-d>`                    | Scroll down in preview window               |
|         | !`<C-f>`                   | Scroll left in preview window               |
|         | !`<C-b>`                   | Scroll right in preview window              |

### [todo-comments.nvim]

[todo-comments.nvim]: https://github.com/folke/todo-comments.nvim

| Mode | Keymap       | Description           | P   |
| ---- | ------------ | --------------------- | --- |
| `n`  | `öt`         | Find in TODO comments | T   |
| `n`  | `<Leader>xt` | Show TODO comments    | TR  |

- `T` ... [telescope.nvim](#telescopenvim)
- `TR` ... [trouble.nvim](#troublenvim)

### [treewalker.nvim]

[treewalker.nvim]: https://github.com/aaronik/treewalker.nvim

| Mode | Keymap | Description |
| ---- | ------ | ----------- |
| `n`  | `äj`   | Down        |
| `n`  | `äk`   | Up          |
| `n`  | `äh`   | Left        |
| `n`  | `äl`   | Right       |

### [trouble.nvim]

[trouble.nvim]: https://github.com/folke/trouble.nvim

| Mode | Keymap       | Description                                |
| ---- | ------------ | ------------------------------------------ |
| `n`  | `<Leader>xx` | Toggle workspace diagnostics               |
| `n`  | `<Leader>xX` | Toggle document diagnostics                |
| `n`  | `<Leader>cs` | Toggle symbols sidebar                     |
| `n`  | `<Leader>cl` | Toggle lsp definitions, references sidebar |
| `n`  | `<Leader>xL` | Toggle location list                       |
| `n`  | `<Leader>xQ` | Toggle quickfix list                       |
| `n`  | `üt` (`[t`)  | Previous item                              |
| `n`  | `+t` (`]t`)  | Next item                                  |

- See also [Quickfix/Location List](#quickfixlocation-list)

### [which-key.nvim]

[which-key.nvim]: https://github.com/folke/which-key.nvim

| Mode | Keymap       | Description               |
| ---- | ------------ | ------------------------- |
| `n`  | `<Leader>?`  | Show local buffer keymaps |
| `n`  | `<Leader>??` | Show global keymaps       |

### Deactivated

#### [codeium.vim]

[codeium.vim]: https://github.com/Exafunction/codeium.vim

- Currently deactivated

| Mode | Keymap       | Description                      |
| ---- | ------------ | -------------------------------- |
| `n`  | `<Leader>tc` | Toggle Codeium                   |
| `i`  | `<Tab>`      | Accept completion                |
| `i`  | `<C-e>`      | Cancel/Clear current completions |
| `f`  | `<C-f>`      | Cycle completions forwards       |

- ? `<S-Tab>` for Cancel
- ? `<C-e>` for Cancel/Clear like CMP

#### [LuaSnip]

[LuaSnip]: https://github.com/L3MON4D3/LuaSnip

| Mode     | Keymap  | Description                        |
| -------- | ------- | ---------------------------------- |
| `i`, `s` | `<C-f>` | Go to next snippet placeholder     |
| `i`, `s` | `<C-b>` | Go to previous snippet placeholder |

#### [nvim-cmp]

[nvim-cmp]: https://github.com/hrsh7th/nvim-cmp

CMP - Completion Menu:

| Mode | Keymap            | Description                                       |
| ---- | ----------------- | ------------------------------------------------- |
| `i`  | `<CR>`, `<C-y>`   | Confirm completion                                |
| `i`  | `<C-e>`           | Cancel completion                                 |
| `i`  | `<S-CR>`, `<C-r>` | Confirm completion with replace                   |
| `i`  | `<C-Space>`       | Trigger completion menu                           |
| `i`  | `<C-j>`, `<Down>` | Go to the next item                               |
| `i`  | `<C-k>`, `<Up>`   | Go to the previous item                           |
| `i`  | `<C-n>`           | Go to the next item (trigger completion menu)     |
| `i`  | `<C-p>`           | Go to the previous item (trigger completion menu) |
|      | `<C-u>`           | Scroll completion documentation up                |
|      | `<C-d>`           | Scroll completion documentation down              |

#### [Comment.nvim]

[Comment.nvim]: https://github.com/numToStr/Comment.nvim

| Mode | Keymap | Description                               |
| ---- | ------ | ----------------------------------------- |
| `n`  | `gcc`  | Toggle linewise comment for current line  |
| `n`  | `gbc`  | Toggle blockwise comment for current line |
| `x`  | `gc`   | Toggle linewise comment for selection     |
| `x`  | `gb`   | Toggle blockwise comment for selection    |
| `n`  | `gco`  | Insert comment to the next line           |
| `n`  | `gcO`  | Insert comment to the previous line       |
| `n`  | `gcA`  | Insert comment to end of the current line |
| `n`  | `gc}`  | Toggle until the next blank line          |
| `n`  | `gcip` | Toggle inside of paragraph                |
| `n`  | `gca}` | Toggle around curly brackets              |

## ftplugin

### AsciiDoc

| Mode | Keymap       | Description                                  |
| ---- | ------------ | -------------------------------------------- |
| `n`  | `<Leader>Ah` | Find headers (from level 2)                  |
| `n`  | `<Leader>AH` | Find headers (from level 2) to location list |

### Help

| Mode | Keymap | Description                              |
| ---- | ------ | ---------------------------------------- |
| `n`  | `gh`   | Go to help tag (definition) like `<C-]>` |

### Markdown

| Mode | Keymap       | Description                                  |
| ---- | ------------ | -------------------------------------------- |
| `n`  | `<Leader>A1` | Fix TOC generated from Marksman              |
| `n`  | `<Leader>Ah` | Find headers (from level 2)                  |
| `n`  | `<Leader>AH` | Find headers (from level 2) to location list |
