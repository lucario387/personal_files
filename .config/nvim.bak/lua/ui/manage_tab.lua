-- From tiagovla/scope.nvim

local api = vim.api

local cache = {}
local last_tab = 0

-- Wrapper around api.nvim_buf_is_valid()
local buf_is_valid = function(buf_id)
	if not buf_id or buf_id < 1 then
		return false
	end
	return api.nvim_buf_get_option(buf_id, "buflisted") and api.nvim_buf_is_valid(buf_id)
end


-- Wrapper around api.nvim_list_bufs()
local get_buffer_of_tab = function()
	local buf_ids = api.nvim_list_bufs()
	local current_tab_bufs = {}
	for _, buf_id in pairs(buf_ids) do
		if buf_is_valid(buf_id) then
			table.insert(current_tab_bufs, buf_id)
		end
	end
	return current_tab_bufs
end

local on_TabNewEntered = function()
	api.nvim_buf_set_option(0, "buflisted", true)
end

local on_TabEnter = function()
	local buf_ids = cache[api.nvim_get_current_tabpage()]
	if buf_ids then
		for _, buf_id in pairs(buf_ids) do
			api.nvim_buf_set_option(buf_id, "buflisted", true)
		end
	end
end


local on_TabLeave = function()
	local tab_id = api.nvim_get_current_tabpage()
	local buf_ids = get_buffer_of_tab()
	if buf_ids then
		cache[tab_id] = buf_ids
		for _, buf_id in pairs(buf_ids) do
			api.nvim_buf_set_option(buf_id, "buflisted", false)
		end
	end
	last_tab = tab_id
end

local on_TabClosed = function()
	cache[last_tab] = nil
end

local group = api.nvim_create_augroup("TabBufManage", {})
api.nvim_create_autocmd("TabNewEntered", { group = group, callback = on_TabNewEntered })
api.nvim_create_autocmd("TabEnter", { group = group, callback = on_TabEnter })
api.nvim_create_autocmd("TabLeave", { group = group, callback = on_TabLeave })
api.nvim_create_autocmd("TabClosed", { group = group, callback = on_TabClosed })
