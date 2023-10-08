local dap = require('dap')
dap.adapters.c = {
    type = 'executable',
    name = 'lldb',
    command = 'lldb',
    args = {},
}

dap.configurations.c = {
    {
        name = 'Launch',
        type = 'c',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        args = {},
        cwd = '${workspaceFolder}',
        stopAtEntry = true,
        -- serverLaunchTimeout = 5000,
        runInTerminal = false,
    },
}


require('dapui').setup()

local dap, dapui =require("dap"),require("dapui")
dap.listeners.after.event_initialized["dapui_config"]=function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"]=function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"]=function()
  dapui.close()
end

-- Define the remaps for toggling breakpoints and continuing
vim.api.nvim_set_keymap('n', '<Leader>db', ':lua require("dap").toggle_breakpoint()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>dr', ':lua require("dap").continue()<CR>', { noremap = true, silent = true })

