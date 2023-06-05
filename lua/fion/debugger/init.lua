local dap = require("dap")
local dapui = require("dapui")
local daptext = require("nvim-dap-virtual-text")

local remap = require("fion.remap")
local nnoremap = remap.nnoremap

local debugpy_path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
require("dap-python").setup(debugpy_path)

nnoremap("<leader>dpr", function()
	require("dap-python").test_method()
end)

daptext.setup()
dapui.setup({
	layouts = {
		{
			elements = {
				"console",
			},
			size = 7,
			position = "bottom",
		},
		{
			elements = {
				-- Elements can be strings or table with id and size keys.
				{ id = "scopes", size = 0.25 },
				"watches",
			},
			size = 40,
			position = "left",
		},
	},
})

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open(1)
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

nnoremap("<Home>", function()
	dapui.toggle(1)
end)
nnoremap("<End>", function()
	dapui.toggle(2)
end)

nnoremap("<leader><leader>", function()
	dap.close()
end)

nnoremap("<Up>", function()
	dap.continue()
end)
nnoremap("<Down>", function()
	dap.step_over()
end)
nnoremap("<Right>", function()
	dap.step_into()
end)
nnoremap("<Left>", function()
	dap.step_out()
end)
nnoremap("<Leader>db", function()
	dap.toggle_breakpoint()
end)
nnoremap("<Leader>dB", function()
	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end)
nnoremap("<leader>rc", function()
	dap.run_to_cursor()
end)
