--[[
-- Implementation of a stack data structure in pure Lua
-- By: Raforawesome
-- Module file
]]

local flatten = require("libel/libraries/pretty_print").flatten

--[[
-- Expected Properties:
-- internal: table
]]
local Stack = {}
local StackConstructor = {}

-- Methods
function Stack:push(value)
	table.insert(self.internal, value)
end

Stack.insert = Stack.push

function Stack:pop()
	local buffer = self.internal
	local el = table.remove(buffer, #buffer)
	self.internal = buffer
	return el
end

-- Constructors
StackConstructor.new = function(...)
	local new = setmetatable({}, {
		__index = Stack,
		--__newindex = function()
		--error("Attempt to write to read-only table!")
		--end,
		__tostring = function(t)
			local s = "{ "
			for i, v in pairs(t.internal) do
				s = s .. v .. (i ~= #(t.internal) and ", " or " ")
			end
			s = s .. "}"
			return s
		end,
		__len = function(t)
			return #(t.internal)
		end
	})
	new.internal = {}
	for _, v in ipairs({ ... }) do
		if type(v) ~= "table" then
			new:push(v)
		end
	end
	return new
end

--

return setmetatable({}, {
	__index = StackConstructor,
	__call = StackConstructor.new,
	__newindex = function()
		error("Attempt to write to read-only table!")
	end,
	__len = function(t)
		return #(t.internal)
	end
})
