local M = {}

function M.move_down_normal()
	local count
	if vim.v.count == 0 then
		count = 1
	else
		count = vim.v.count
	end

	return "<cmd>m .+" .. count .. "<cr>=="
end

function M.move_down_insert()
	local count
	if vim.v.count == 0 then
		count = 1
	else
		count = vim.v.count
	end

	return "<esc><cmd>m .+" .. count .. "<cr>==gi"
end

function M.move_down_visual()
	local count
	if vim.v.count == 0 then
		count = 1
	else
		count = vim.v.count
	end

	return ":m '>+" .. count .. "<cr>gv=gv"
end

function M.move_up_normal()
	local count
	if vim.v.count == 0 or vim.v.count == 1 then
		count = 2
	else
		count = vim.v.count
	end

	return "<cmd>m .-" .. count .. "<cr>=="
end

function M.move_up_insert()
	local count
	if vim.v.count == 0 or vim.v.count == 1 then
		count = 2
	else
		count = vim.v.count
	end

	return "<esc><cmd>m .-" .. count .. "<cr>==gi"
end

function M.move_up_visual()
	local count
	if vim.v.count == 0 or vim.v.count == 1 then
		count = 2
	else
		count = vim.v.count
	end

	return ":m '<-" .. count .. "<cr>gv=gv"
end

return M
