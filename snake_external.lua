--[[ FUNCTIONS
	- debug()
]]--

function debug()
	print('X = '..head.x)
	print('Y = '..head.y)
	
	if head.alive then
	 print('Alive = TRUE')
	else
	 print('Alive = FALSE')
	end

	-- Resurrect snake for debugging purposes
	if head.x >= 1 and head.x <= 128 and
	   head.y >= 1 and head.y <= 128 then
		head.alive = true
	end
	
	print('Length = '..body.segments)
	print('Frukt x = '..fruit.x)
	print('Frukt y = '..fruit.y)
end

-- No switch statements in Lua...
-- No increment (++) and decrement (--) operators in Lua...
-- function move_increment()
	-- if head.dir == 0 then
		-- head.x -= scale
	-- elseif head.dir == 1 then
		-- head.x += scale
	-- elseif head.dir == 2 then
		-- head.y -= scale
	-- elseif head.dir == 3 then
		-- head.y += scale
	-- end
-- end

// LAST_LINE_SNAKE_EXTERNAL_LUA