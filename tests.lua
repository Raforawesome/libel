--[[
-- Test cases for linked_list.lua
]]

-- Make random functions actually random
math.randomseed(os.time())

local size = 8
local nums = {}
for _ = 1, size do
	table.insert(nums, math.random(size))
end



--[[
-- Linked list testing
]]
print("----------")
print("Linked List Testing")
print("----------\n")

local LinkedList = require("libel/classes/linked_list")

local list = LinkedList.new(table.unpack(nums))
print(tostring(list))

for i = 1, size do
	print(string.format("Searching for %d: %s", i, tostring(list:search(i))))
end



--[[
-- Stack testing
]]
print("\n\n\n----------")
print("Stack Testing")
print("----------\n")

local Stack = require("libel/classes/stack")

local stk = Stack(table.unpack(nums))
print(tostring(stk))

for _ = 1, #stk do
	local num = stk:pop()
	print(string.format("Popped %s", num))
	print(tostring(stk))
end
