# Neovim Keymaps

<!-- prettier-ignore-start -->

<!--toc:start-->
- [Neovim Keymaps](#neovim-keymaps)
  - [Plugins Archived](#plugins-archived)
    - [bufferline.nvim](#bufferlinenvim)
    - [Comment.nvim](#commentnvim)
    - [hardtime.nvim](#hardtimenvim)
    - [harpoon](#harpoon)
    - [LuaSnip](#luasnip)
    - [mini.hipatterns](#minihipatterns)
    - [nvim-cmp](#nvim-cmp)
    - [nvim-treesitter](#nvim-treesitter)
    - [precognition.nvim](#precognitionnvim)
    - [telescope.nvim](#telescopenvim)
    - [treewalker.nvim](#treewalkernvim)
<!--toc:end-->

<!-- prettier-ignore-end -->

## Plugins Archived

### [bufferline.nvim]

[bufferline.nvim]: https://github.com/akinsho/bufferline.nvim

| Mode | Keymap      | Description           |
| ---- | ----------- | --------------------- |
| `n`  | ~~`+b`~~    | Go to next buffer     |
| `n`  | ~~`üb`~~    | Go to previous buffer |
| `n`  | `üt` (`[t`) | Go to previous tab    |
| `n`  | `+t` (`]t`) | Go to next tab        |

### [Comment.nvim]

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

### [hardtime.nvim]

[hardtime.nvim]: https://github.com/m4xshen/hardtime.nvim

| Mode | Keymap        | Description     |
| ---- | ------------- | --------------- |
| `n`  | `<Leader>tha` | Toggle Hardtime |

### [harpoon]

[harpoon]: https://github.com/ThePrimeagen/harpoon

| Mode | Keymap                     | Description                      |
| ---- | -------------------------- | -------------------------------- |
| `n`  | `<Leader>h`                | Open Harpoon quick menu          |
| `n`  | `<Leader>H`                | Add (harpoon) file to quick menu |
| `n`  | `<Leader>1` .. `<Leader>5` | Select file 1 to 9 directly      |

### [LuaSnip]

[LuaSnip]: https://github.com/L3MON4D3/LuaSnip

| Mode     | Keymap  | Description                        |
| -------- | ------- | ---------------------------------- |
| `i`, `s` | `<C-f>` | Go to next snippet placeholder     |
| `i`, `s` | `<C-b>` | Go to previous snippet placeholder |

### [mini.hipatterns]

[mini.hipatterns]: https://github.com/nvim-mini/mini.hipatterns

| Mode | Keymap        | Description            |
| ---- | ------------- | ---------------------- |
| `n`  | `<Leader>thi` | Toggle mini.hipatterns |

### [nvim-cmp]

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

### [nvim-treesitter]

[nvim-treesitter]: https://github.com/nvim-treesitter/nvim-treesitter

Only for archived **master** branch:

| Mode | Keymap | Description                             |
| ---- | ------ | --------------------------------------- |
| `n`  | `<CR>` | Init selection (current node)           |
| `x`  | `<CR>` | Expand selection to outer (parent) node |
| `x`  | `<BS>` | Reduce selection to inner (child) node  |

### [precognition.nvim]

[precognition.nvim]: https://github.com/tris203/precognition.nvim

| Mode | Keymap       | Description         |
| ---- | ------------ | ------------------- |
| `n`  | `<Leader>tp` | Toggle Precognition |

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

### [treewalker.nvim]

[treewalker.nvim]: https://github.com/aaronik/treewalker.nvim

| Mode | Keymap | Description |
| ---- | ------ | ----------- |
| `n`  | `äj`   | Down        |
| `n`  | `äk`   | Up          |
| `n`  | `äh`   | Left        |
| `n`  | `äl`   | Right       |
