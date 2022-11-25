--[[
-- Basic implementation of a linked list in pure Lua.
-- By: Raforawesome
-- Module file
]]


--[[
-- LinkedNode Class
]]

--[[
-- Expected Properties:
-- -- data (property)
-- -- next (LinkedNode)
]]
local LinkedNode = {}

-- Methods
function LinkedNode:get_data()
	assert(self ~= LinkedNode)
	return self.data
end

function LinkedNode:get_next()
	assert(self ~= LinkedNode)
	return self.data
end

-- Constructors
LinkedNode.new = function(data)
	local new = setmetatable({}, {
		__index = function(_, k)
			return LinkedNode[k]
		end
	})
	new.data = data
	return new
end



--[[
-- LinkedList Class
]]

--[[
-- Expected Properties:
-- -- next (LinkedNode)
]]
local LinkedList = {}
local ListConstructor = {}

-- Methods
function LinkedList:insert(data)
	assert(self ~= LinkedList)
	if self.root ~= nil then
		local current = self.root
		while current.next ~= nil do
			current = current.next
		end
		current.next = LinkedNode.new(data)
	else
		self.root = LinkedNode.new(data)
	end
end

function LinkedList:search(target)
	assert(self ~= LinkedList)
	local current = self.root
	while current ~= nil do
		if current:get_data() == target then
			return true
		end
		current = current.next
	end
	return false
end

-- Constructors
ListConstructor.new = function(...)
	local new = setmetatable({}, {
		__index = LinkedList,
		__tostring = function(t)
			local s = "{ "
			local current = t.root
			while current ~= nil do
				s = s .. current.data .. (current.next and ", " or " ")
				current = current.next
			end
			s = s .. "}"
			return s
		end
	})

	for _, value in pairs({ ... }) do
		if new.root == nil then
			new.root = LinkedNode.new(value)
		else
			new:insert(value)
		end
	end

	return new
end

---

return {
	["LinkedList"] = setmetatable({}, {
		__index = ListConstructor,
		__newindex = function()
			error("Attempt to write to read-only table!")
		end
	}),
}

