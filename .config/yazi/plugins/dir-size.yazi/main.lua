-- Fetcher: compute recursive directory sizes so the "size" linemode
-- shows them instead of the entry count.
local M = {}

function M:fetch(job)
	return ya.co(function()
		local trails = {}
		for _, file in ipairs(job.files) do
			local it, size = fs.calc_size(file.url), 0
			while it do
				local n = it:recv()
				if not n then break end
				size = size + n
			end
			if coroutine.yield(file, {}) then
				local t = file.url.trail
				trails[t] = trails[t] or {}
				trails[t][file.url.key] = size
			end
		end
		for trail, sizes in pairs(trails) do
			ya.emit("update_files", { op = fs.op("size", { url = trail, sizes = sizes }) })
		end
	end)
end

return M
