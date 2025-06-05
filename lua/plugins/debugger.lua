return {
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            "rcarriga/nvim-dap-ui",
            'theHamsta/nvim-dap-virtual-text',
        },
        config = function()
            local dap = require('dap')

            -- Dart Debug Adapter Configuration
            dap.adapters.dart = {
                type = 'executable',
                command = 'dart',
                args = { 'debug_adapter' }
            }

            -- Flutter Debug Adapter Configuration
            dap.adapters.flutter = {
                type = 'executable',
                command = 'flutter',
                args = { 'debug_adapter' }
            }

            -- Dart Debug Configurations
            dap.configurations.dart = {
                {
                    type = "dart",
                    request = "launch",
                    name = "Launch Dart Program",
                    program = "${file}",
                    cwd = "${workspaceFolder}",
                    args = {},
                    console = "terminal"
                },
                {
                    type = "dart",
                    request = "launch",
                    name = "Launch Dart Program (with args)",
                    program = "${file}",
                    cwd = "${workspaceFolder}",
                    args = function()
                        local input = vim.fn.input("Enter args: ")
                        return vim.split(input, " ", true)
                    end,
                    console = "terminal"
                },
                {
                    type = "flutter",
                    request = "launch",
                    name = "Launch Flutter App",
                    cwd = "${workspaceFolder}",
                    program = "lib/main.dart",
                    toolArgs = { "-d", "chrome" } -- Default to Chrome, change as needed
                },
                {
                    type = "flutter",
                    request = "launch",
                    name = "Launch Flutter App (Debug Mode)",
                    cwd = "${workspaceFolder}",
                    program = "lib/main.dart",
                    toolArgs = { "--debug" }
                },
                {
                    type = "flutter",
                    request = "launch",
                    name = "Launch Flutter App (Profile Mode)",
                    cwd = "${workspaceFolder}",
                    program = "lib/main.dart",
                    toolArgs = { "--profile" }
                },
                {
                    type = "flutter",
                    request = "launch",
                    name = "Launch Flutter App (Device Selection)",
                    cwd = "${workspaceFolder}",
                    program = "lib/main.dart",
                    toolArgs = function()
                        -- Get available devices
                        local devices = vim.fn.systemlist("flutter devices --machine 2>/dev/null")
                        if #devices == 0 then
                            vim.notify("No Flutter devices found", vim.log.levels.WARN)
                            return {}
                        end

                        -- Parse device list and let user choose
                        local device_options = {}
                        for _, device_json in ipairs(devices) do
                            local ok, device = pcall(vim.fn.json_decode, device_json)
                            if ok and device.id then
                                table.insert(device_options, {
                                    id = device.id,
                                    name = device.name or device.id,
                                    display = device.id .. " (" .. (device.name or "Unknown") .. ")"
                                })
                            end
                        end

                        if #device_options == 0 then
                            vim.notify("No valid Flutter devices found", vim.log.levels.WARN)
                            return {}
                        end

                        -- Show device selection
                        local display_options = { "Select device:" }
                        for i, device in ipairs(device_options) do
                            table.insert(display_options, i .. ". " .. device.display)
                        end

                        local choice = vim.fn.inputlist(display_options)
                        if choice > 0 and choice <= #device_options then
                            local selected_device = device_options[choice]
                            return { "-d", selected_device.id }
                        end

                        return {}
                    end
                },
                {
                    type = "flutter",
                    request = "attach",
                    name = "Attach to Flutter Process",
                    cwd = "${workspaceFolder}",
                }
            }

            -- Helper function to get Flutter devices
            local function get_flutter_devices()
                local devices = {}
                local result = vim.fn.systemlist("flutter devices --machine 2>/dev/null")

                for _, line in ipairs(result) do
                    local ok, device = pcall(vim.fn.json_decode, line)
                    if ok and device.id then
                        table.insert(devices, {
                            id = device.id,
                            name = device.name or device.id,
                            platform = device.platform or "unknown"
                        })
                    end
                end

                return devices
            end

            -- Flutter-specific keybinds
            vim.keymap.set('n', '<leader>dF', function()
                -- Quick launch Flutter app
                require('dap').run(dap.configurations.dart[3]) -- Launch Flutter App config
            end, { desc = 'Debug: Launch Flutter App' })

            vim.keymap.set('n', '<leader>dD', function()
                -- Show device selection and launch
                local devices = get_flutter_devices()
                if #devices == 0 then
                    vim.notify("No Flutter devices found", vim.log.levels.WARN)
                    return
                end

                local device_names = {}
                for i, device in ipairs(devices) do
                    table.insert(device_names, string.format("%d. %s (%s)", i, device.name, device.platform))
                end

                print("Available devices:")
                for _, name in ipairs(device_names) do
                    print(name)
                end

                local choice = tonumber(vim.fn.input("Select device (number): "))
                if choice and choice >= 1 and choice <= #devices then
                    local selected_device = devices[choice]

                    -- Create a custom config with selected device
                    local config = vim.deepcopy(dap.configurations.dart[3])
                    config.toolArgs = { "-d", selected_device.id }
                    config.name = "Launch Flutter App on " .. selected_device.name

                    require('dap').run(config)
                end
            end, { desc = 'Debug: Launch Flutter with Device Selection' })

            -- Hot reload keybind during debugging
            vim.keymap.set('n', '<leader>dh', function()
                if dap.session() then
                    -- Send hot reload command via DAP
                    vim.fn.system("kill -USR1 $(pgrep -f 'flutter.*run')")
                    vim.notify("Hot reload triggered", vim.log.levels.INFO)
                else
                    vim.notify("No active debug session", vim.log.levels.WARN)
                end
            end, { desc = 'Debug: Hot Reload Flutter' })

            -- Setup virtual text
            require("nvim-dap-virtual-text").setup()
        end
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio"
        },
        event = 'VeryLazy',
        keys = Keymaps.dap,
        config = function()
            local dap, dapui = require("dap"), require("dapui")

            dapui.setup(
            -- {
            --     icons = { expanded = "▾", collapsed = "▸" },
            --     layouts = {
            --         {
            --             elements = {
            --                 { id = "scopes", size = 0.25 },
            --                 "breakpoints",
            --                 "stacks",
            --                 "watches",
            --             },
            --             size = 10, -- columns
            --             position = "bottom",
            --         },
            --     },
            -- }
            )

            -- Auto-open/close DAP UI
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end
    }
}
