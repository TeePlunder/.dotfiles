require('zen-mode').setup({
  -- Use Twilight to dim inactive code (requires Twilight plugin)
  twilight = true,

  -- Initial window size (width, height)
  window_size = { 180, 300 },

  -- Use relative line numbers
  relative_line_numbers = true,

  -- Use a dark statusline
  dark_statusline = true,

  -- Use a specific background color for the Zen Mode window
  background_color = '#111',

  -- Use a specific foreground color for the Zen Mode window
  foreground_color = '#fff',

  alacritty = {
    enabled = true,
    font = "15", -- font size
  }
})

vim.keymap.set('n', '<leader>z', '<cmd>lua require("zen-mode").toggle()<CR>', {})
