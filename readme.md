# ilsrbn/markdown-to-pdf

Neovim plugin to generate Pdf files from Markdown.

## Table of contents

- [Installation](#installation)
- [Usage](#usage)

## Installation

### Using a Plugin Manager (e.g., `lazy`)

```lua
 {
    'ilsrbn/markdown-to-pdf',
    lazy = true,
    filetype = 'markdown',
    keys = {
      -- Define the keymap to Generate PDF, e.g., <leader>lp
      { '<leader>lp', function() require('markdown-to-pdf').run_pandoc() end, mode = 'n', noremap = true, silent = true, desc = 'Generate PDF from Markdown' }
    }
  }
```

## Usage

[Generate PDF example](./assets/usage.mp4)
