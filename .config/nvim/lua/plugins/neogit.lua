return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    'sindrets/diffview.nvim', -- optional - Diff integration

    -- Only one of these is needed, not both.
    'nvim-telescope/telescope.nvim', -- optional
    'ibhagwan/fzf-lua', -- optional
  },
  config = true,
  keys = {
    {
      '<leader>gg',
      function()
        require('neogit').open()
      end,
      mode = '',
      desc = '[G]it show',
    },
    {
      '<leader>gc',
      function()
        require('neogit').open { 'commit' }
      end,
      mode = '',
      desc = '[G]it [c]ommit',
    },
  },
}