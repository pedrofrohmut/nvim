local dap = require("dap")
local dapui = require("dapui")
dapui.setup()

-- Dap -------------------------------------------------------------------------

vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>dB", dap.set_breakpoint)
vim.keymap.set("n", "<leader>dr", dap.run_last)
vim.keymap.set("n", "<leader>dq", dap.terminate)

vim.keymap.set("n", "<F5>", dap.continue)
vim.keymap.set("n", "<F6>", dap.step_over)
vim.keymap.set("n", "<F7>", dap.step_into)
vim.keymap.set("n", "<F8>", dap.step_out)

vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
    require("dap.ui.widgets").preview()
end)

vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
    require("dap.ui.widgets").hover()
end)

-- vim.keymap.set("n", "<leader>db", "<cmd>DapToggleBreakpoint<Enter>")
-- vim.keymap.set("n", "<leader>dB", dap.set_breakpoint)
-- vim.keymap.set("n", "<leader>dr", dap.run_last)
-- vim.keymap.set("n", "<leader>dq", "<cmd>DapTerminate<Enter>")

-- Dap UI ----------------------------------------------------------------------

dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
end

vim.keymap.set("n", "<leader>dt", require("dapui").toggle)

-- Dap Virtual Text ------------------------------------------------------------

-- require("nvim-dap-virtual-text").setup()

-- C/C++ GDB -------------------------------------------------------------------

dap.adapters.gdb = {
    type = "executable",
    command = "gdb",
    args = { "-i", "dap" },
}

dap.configurations.c = {
    {
        name = "Launch",
        type = "gdb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
    },
}

-- CSharp NetCoreDbg -----------------------------------------------------------

dap.adapters.coreclr = {
    type = "executable",
    command = "netcoredbg",
    args = { "--interpreter=vscode" },
}

dap.configurations.cs = {
    {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
            return vim.fn.input("Path to dll => ", vim.fn.getcwd() .. "", "file")
        end,
    },
}

-- Golang ----------------------------------------------------------------------

dap.adapters.delve = {
    type = "server",
    port = "${port}",
    executable = {
        command = "dlv",
        args = { "dap", "-l", "127.0.0.1:${port}", "--log", "--log-output=dap" },
        detached = vim.fn.has("win32") == 0,
    },
}

dap.configurations.go = {
    {
        type = "delve",
        name = "Debug",
        request = "launch",
        program = "${file}",
    },
    {
        type = "delve",
        name = "Debug test", -- configuration for debugging test files
        request = "launch",
        mode = "test",
        program = "${file}",
    },
    -- works with go.mod packages and sub packages
    {
        type = "delve",
        name = "Debug test (go.mod)",
        request = "launch",
        mode = "test",
        program = "./${relativeFileDirname}",
    },
}

-- dap.adapters.delve = function(callback, config)
--     if config.mode == "remote" and config.request == "attach" then
--         callback({
--             type = "server",
--             host = config.host or "127.0.0.1",
--             port = config.port or "38697",
--         })
--     else
--         callback({
--             type = "server",
--             port = "${port}",
--             executable = {
--                 command = "dlv",
--                 args = { "dap", "-l", "127.0.0.1:${port}", "--log", "--log-output=dap" },
--                 detached = vim.fn.has("win32") == 0,
--             },
--         })
--     end
-- end
-- -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
-- dap.configurations.go = {
--     {
--         type = "delve",
--         name = "Debug",
--         request = "launch",
--         program = "${file}",
--     },
--     {
--         type = "delve",
--         name = "Debug test", -- configuration for debugging test files
--         request = "launch",
--         mode = "test",
--         program = "${file}",
--     },
--     -- works with go.mod packages and sub packages
--     {
--         type = "delve",
--         name = "Debug test (go.mod)",
--         request = "launch",
--         mode = "test",
--         program = "./${relativeFileDirname}",
--     },
-- }
