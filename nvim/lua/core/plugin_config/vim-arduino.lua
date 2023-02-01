local function arduino_status()
	local port = vim.fn["arduino#GetPort"]()
	local line = string.format("[%s]", vim.g.arduino_board)
	if vim.g.arduino_programmer ~= "" then
		line = line .. string.format(" [%s]", vim.g.arduino_programmer)
	end
	if port ~= 0 then
		line = line .. string.format(" (%s:%s)", port, vim.g.arduino_serial_baud)
	end
	return line
end

ft = vim.api.nvim_buf_get_name(0)
if  string.match(ft, "%c*.ino$") == ".ino" then
	require('lualine').setup{
		sections = {
			lualine_x = { arduino_status }
		}
	}
end
