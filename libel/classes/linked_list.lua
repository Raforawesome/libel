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
local LinkedNode = {} -- class for internal use only

-- Methods
function LinkedNode:get_data() -- LinkedNode.data getter
	assert(self ~= LinkedNode) -- Ensure it's a constructed variant
	return self.data
end

function LinkedNode:get_next() -- LinkedNode.net getter
	assert(self ~= LinkedNode) -- Ensure it's a constructed variant
	return self.next
end

-- Constructors
LinkedNode.new = function(data) -- We can use the same class since its internal use only
	local new = setmetatable({}, {
		__index = LinkedNode -- redirect all index requests to parent method table
	})
	new.data = data -- remember stored value
	return new
end



--[[
-- LinkedList Class
]]

--[[
-- Expected Properties:
-- -- next (LinkedNode)
]]
local LinkedList = {} -- Method table
local ListConstructor = {} -- Constructor wrapper

-- Methods
function LinkedList:insert(data) -- Append value to the end
	assert(self ~= LinkedList) -- Ensure it's a constructed variant
	if self.root ~= nil then -- If list isn't blank
		local current = self.root -- Start at root node
		while current.next ~= nil do -- While this node isn't the last
			current = current.next -- Advance to next node
		end
		current.next = LinkedNode.new(data) -- Add new end to last node
	else
		self.root = LinkedNode.new(data) -- If root doesn't exist, set root to new node
	end
end

function LinkedList:search(target) -- Check if value exists in list
	assert(self ~= LinkedList) -- Ensure it's a constructed variant
	local current = self.root -- Start at root
	while current ~= nil do -- Keep advancing until we hit the end
		if current:get_data() == target then
			return true
		end
		current = current.next
	end
	return false -- If we hit the end and still didn't return, nothing was found
end

-- Constructors
ListConstructor.new = function(...) -- Constructor function
	local new = setmetatable({}, {
		__index = LinkedList, -- Constructed object should "inherit" from method table
		__tostring = function(t) -- Mainly for printing/debugging purposes
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

	for _, value in pairs({ ... }) do -- For all arguments passed
		if new.root == nil then -- Make it the root if no root exists
			new.root = LinkedNode.new(value)
		else
			new:insert(value) -- otherwise append to list
		end
	end

	return new
end

---

return setmetatable({}, { -- Return a read-only version of table containing constructor
	__index = ListConstructor, -- "Inherit" from constructor table
	__call = ListConstructor.new, -- Allow constructor to be called as LinkedList() directly
	__newindex = function() -- Disallow writes
		error("Attempt to write to read-only table!")
	end,
})
