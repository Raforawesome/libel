--[[
-- Test cases for linked_list.lua
]]

-- Make random functions actually random
math.randomseed(os.time())



--[[
-- Linked list testing
]]

local LinkedList = require("libel/classes/linked_list").LinkedList

local size = 8
local nums = {}
for _ = 1, size do
	table.insert(nums, math.random(size))
end


local list = LinkedList.new(table.unpack(nums))
print(tostring(list))

for i = 1, size do
	print(string.format("Searching for %d: %s", i, tostring(list:search(i))))
end
