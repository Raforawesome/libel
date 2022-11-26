--[[
-- pretty-print which flattens all tables
-- Author: Raforawesome
-- Module file
]]

-- what an indent looks like
local indent = "   "

local function flatten(val, level, k)
	if type(val) == "table" then
		local buffer = string.rep(indent, level, "") .. (k and k .. " = " or "") .. "{\n"
		for k, v in pairs(val) do
			if type(v) == "table" then
				buffer = buffer .. flatten(v, level + 1, k)
			else
				buffer = buffer .. string.rep(indent, level + 1, "") .. k .. " = " .. v .. ",\n"
			end
		end
		buffer = buffer .. string.rep(indent, level, "") .. "},\n"
		return buffer
	else
		return string.rep(indent, level, "") .. val .. "," .. "\n"
	end
end

local function pretty_print(...)
	local buffer = ""
	for i, v in ipairs({ ... }) do
		buffer = buffer .. string.format("-- Element %d\n", i)
		buffer = buffer .. flatten(v, 0) .. "\n"
	end
	print(buffer)
end

return {
	["pretty_print"] = pretty_print,
	["flatten"] = flatten,
}
--local t = { 1, 2, 3, { 4, 5, 6, { 7, 8, 9 } }, 10 }
--pretty_print(t, 2, t)
