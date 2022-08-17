local neogit = require('neogit')
local nnoremap = require('user.keymap').nnoremap

neogit.setup {}

nnoremap("<leader>gs", function()
    neogit.open({ })
end)

nnoremap("<leader>ga", ":!git fetch --all<CR>")

