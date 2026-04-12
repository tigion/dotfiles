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
    - [Selection](#selection)
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
    - [AI](#ai)
      - [copilot.lua](#copilotlua)
      - [sidekick.nvim](#sidekicknvim)
    - [LSP/CMP/Snippets](#lspcmpsnippets)
      - [blink.cmp](#blinkcmp)
      - [nvim-lspconfig](#nvim-lspconfig)
    - [conform.nvim](#conformnvim)
    - [flash.nvim](#flashnvim)
    - [gitsigns.nvim](#gitsignsnvim)
    - [mini.nvim](#mininvim)
      - [mini.ai](#miniai)
    - [neogen](#neogen)
    - [nvim-lint](#nvim-lint)
    - [nvim-sessions](#nvim-sessions)
    - [nvim-tmux-navigation](#nvim-tmux-navigation)
    - [nvim-tree](#nvim-tree)
    - [outline.nvim](#outlinenvim)
    - [render-markdown.nvim](#render-markdownnvim)
    - [snacks.nvim](#snacksnvim)
      - [snacks.notifier](#snacksnotifier)
      - [snacks.picker](#snackspicker)
      - [snacks.scope](#snacksscope)
      - [snacks.words](#snackswords)
      - [snacks.zen](#snackszen)
    - [swap.nvim](#swapnvim)
    - [todo-comments.nvim](#todo-commentsnvim)
    - [trouble.nvim](#troublenvim)
    - [which-key.nvim](#which-keynvim)
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
| `n`, `x` | `<Leader>ss`  | Search and replace template          |
| `n`      | `<Leader>sw`  | Search and replace word under cursor |
| `n`      | (`<[-Space>`) | Insert line above (normal mode)      |
| `n`      | (`<]-Space>`) | Insert line below (normal mode)      |
| `n`      | `<Leader>K`   | Neovim Help for word under cursor    |

### Selection

| Mode     | Keymap          | Description                             |
| -------- | --------------- | --------------------------------------- |
| `n`      | `<C-a>`         | Select all                              |
| `x`      | `J`             | Move selection down                     |
| `x`      | `K`             | Move selection up                       |
| `x`, `o` | `<CR>` (`v_an`) | Expand selection to outer (parent) node |
| `x`, `o` | `<BS>` (`v_in`) | Reduce selection to inner (child) node  |

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

| Mode | Keymap      | Description  |
| ---- | ----------- | ------------ |
| `n`  | `[t` (`gT`) | Previous tab |
| `n`  | `]t` (`gt`) | Next tab     |

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

### AI

#### [copilot.lua]

[copilot.lua]: https://github.com/zbirenbaum/copilot.lua

| Mode | Keymap        | Description       |
| ---- | ------------- | ----------------- |
| `n`  | `<Leader>taa` | Toggle Copilot    |
| `i`  | `<Tab>`       | Accept suggestion |
| `i`  | `<C-f>`       | Accept word       |
| `i`  | `<C-F>`       | Accept line       |
| `i`  | `<C-g>`       | Next suggestion   |
| `i`  | `<C-G>`       | Prev suggestion   |
| `i`  | `<C-e>`       | Clear suggestion  |

#### [sidekick.nvim]

[sidekick.nvim]: https://github.com/folke/sidekick.nvim

| Mode               | Keymap        | Description         |
| ------------------ | ------------- | ------------------- |
| `n`, `t`, `i`, `x` | `<C-.>`       | Toggle (Select) CLI |
| `n`                | `<Leader>aa`  | Toggle (Select) CLI |
| `n`                | `<Leader>as`  | Select CLI          |
| `n`, `v`           | `<Leader>ap`  | Ask Prompt          |
| `i`                | `<Tab>`       | Goto/Apply NES      |
| `n`                | `<Leader>tan` | Toggle Copilot NES  |

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

| Mode | Keymap               | Description                                                | P   |
| ---- | -------------------- | ---------------------------------------------------------- | --- |
| `n`  | (`K`)                | Show hover information                                     |     |
| `i`  | ~~`<C-k>`~~          | Show hover information                                     |     |
| `n`  | `gK`                 | Show signature help                                        |     |
| `i`  | `<C-k>` (`<C-S>`)    | Show signature help                                        |     |
| `n`  | `ti`                 | Toggle inlay hints                                         |     |
| `n`  | `gs` (`gO`)          | Show symbols in current buffer                             | S   |
| `n`  | `gss`                | Show symbols in workspace (sbt)                            | S   |
| `n`  | `gr` (`grr`)         | Show references (wuc)                                      | S   |
| `n`  | `gd`                 | Go to definition(s) (wuc)                                  | S   |
| `n`  | `gD`                 | Go to declaration (wuc)                                    |     |
| `n`  | `gdt`                | Go to type definition(s) (wuc)                             | S   |
| `n`  | `gI` (`gri`)         | Go to implementation(s)                                    | S   |
| `n`  | `<Leader>ca` (`gca`) | Show code actions                                          |     |
| `n`  | `<Leader>rn` (`grn`) | Rename with all references (wuc)                           |     |
| `n`  | ~~`<Leader>f`~~      | Format current buffer<br />-> [conform.nvim](#conformnvim) |     |
| `n`  | `<Leader>d`          | Show line diagnostics                                      |     |
| `n`  | ~~`<Leader>dd`~~     | Show diagnostics for current buffer                        | S   |
| `n`  | ~~`<Leader>da`~~     | Show diagnostics for all buffers                           | S   |
| `n`  | `<Leader>rs`         | Restart LSP servers for current buffer                     |     |

- `wuc` ... Word under cursor
- `sbt` ... Same buffer (file) type?
- `S` ... [snacks.picker](#snackspicker)
- `T` ... [telescope.nvim](#telescopenvim)

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

Special keymaps:

| Mode | Keymap | Description                 |
| ---- | ------ | --------------------------- |
| `n`  | `<CR>` | Treesitter expand selection |
| `n`  | `<BS>` | Treesitter reduce selection |

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

### [mini.nvim]

[mini.nvim]: https://github.com/nvim-mini/mini.nvim

#### [mini.ai]

[mini.ai]: https://github.com/nvim-mini/mini.ai

Text objects:

| Keymap        | Description                                                     |
| ------------- | --------------------------------------------------------------- |
| `vab` / `vib` | Select around/in brackets (`([{`)                               |
| `vag` / `vig` | Select around/in single/double quotes and backticks (`` "'` ``) |
| `va#` / `vi#` | Select around/in given character (`#` is a placeholder)         |
| ...           | ... and more                                                    |

- To expand the selection in `((...))`, use after `vib` `ib` again.

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

### [outline.nvim]

[outline.nvim]: https://github.com/hedyhli/outline.nvim

| Mode | Keymap      | Description               |
| ---- | ----------- | ------------------------- |
| `n`  | `<Leader>o` | Toggle outline of symbols |

### [render-markdown.nvim]

[render-markdown.nvim]: https://github.com/MeanderingProgrammer/render-markdown.nvim

| Mode | Keymap       | Description            |
| ---- | ------------ | ---------------------- |
| `n`  | `<Leader>tm` | Toggle Render Markdown |

### [snacks.nvim]

[snacks.nvim]: https://github.com/folke/snacks.nvim

#### [snacks.notifier]

[snacks.notifier]: https://github.com/folke/snacks.nvim/blob/main/docs/notifier.md

| Mode | Keymap       | Description             |
| ---- | ------------ | ----------------------- |
| `n`  | `<Leader>tn` | Toggle Notifier History |

#### [snacks.picker]

[snacks.picker]: https://github.com/folke/snacks.nvim/blob/main/docs/picker.md

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

#### [snacks.scope]

[snacks.scope]: https://github.com/folke/snacks.nvim/blob/main/docs/scope.md

| Mode | Keymap | Description                  |
| ---- | ------ | ---------------------------- |
| `n`  | `[i`   | jump to top edge of scope    |
| `n`  | `]i`   | jump to bottom edge of scope |

Text objects:

| Keymap | Description |
| ------ | ----------- |
| `ii`   | inner scope |
| `ai`   | full scope  |

#### [snacks.words]

[snacks.words]: https://github.com/folke/snacks.nvim/blob/main/docs/words.md

| Mode | Keymap      | Description        |
| ---- | ----------- | ------------------ |
| `n`  | `üü` (`[[`) | Previous Reference |
| `n`  | `++` (`]]`) | Next Reference     |

#### [snacks.zen]

[snacks.zen]: https://github.com/folke/snacks.nvim/blob/main/docs/zen.md

| Mode | Keymap      | Description          |
| ---- | ----------- | -------------------- |
| `n`  | `<Leader>z` | Toggle Zen Mode      |
| `n`  | `<Leader>Z` | Toggle Zen Zoom Mode |

### [swap.nvim]

[swap.nvim]: https://github.com/tigion/swap.nvim

| Mode | Keymap      | Description |
| ---- | ----------- | ----------- |
| `n`  | `<Leader>i` | Swap word   |

### [todo-comments.nvim]

[todo-comments.nvim]: https://github.com/folke/todo-comments.nvim

| Mode | Keymap       | Description           | P   |
| ---- | ------------ | --------------------- | --- |
| `n`  | `öt`         | Find in TODO comments | S   |
| `n`  | `Öt`         | Find in TODO comments | T   |
| `n`  | `<Leader>xt` | Show TODO comments    | TR  |

- `T` ... [telescope.nvim](#telescopenvim)
- `S` ... [snacks.picker](#snackspicker)
- `TR` ... [trouble.nvim](#troublenvim)

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
| `n`  | `üx` (`[x`)  | Previous item                              |
| `n`  | `+x` (`]x`)  | Next item                                  |

- See also [Quickfix/Location List](#quickfixlocation-list)

### [which-key.nvim]

[which-key.nvim]: https://github.com/folke/which-key.nvim

| Mode | Keymap       | Description               |
| ---- | ------------ | ------------------------- |
| `n`  | `<Leader>?`  | Show local buffer keymaps |
| `n`  | `<Leader>??` | Show global keymaps       |

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
