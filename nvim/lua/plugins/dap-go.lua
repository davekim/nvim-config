return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "leoluz/nvim-dap-go",
        },
        config = function()
            local dap = require("dap")
            local dap_go = require("dap-go")

            dap_go.setup()

            vim.keymap.set("n", "<leader>dt", dap_go.debug_test, { desc = "Debug nearest Go test" })
            vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
            vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
            vim.keymap.set("n", "<leader>ds", dap.step_over, { desc = "Step over" })
            vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
            vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Step out" })
        end,
    },
}
