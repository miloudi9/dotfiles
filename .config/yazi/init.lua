-- Free disk space for the current directory, shown on the right of the status bar
local df_cache = { cwd = nil, text = "", at = 0 }

Status:children_add(function()
	local cwd = tostring(cx.active.current.cwd)
	local now = os.time()
	if df_cache.cwd ~= cwd or now - df_cache.at >= 5 then
		local p = io.popen("df -h --output=avail " .. ya.quote(cwd) .. " 2>/dev/null | tail -n1")
		local out = p and p:read("*a") or ""
		if p then p:close() end
		df_cache = { cwd = cwd, text = out:gsub("%s+", ""), at = now }
	end
	if df_cache.text == "" then
		return ""
	end
	return ui.Line { ui.Span(" " .. df_cache.text .. " free "):fg("cyan") }
end, 500, Status.RIGHT)
