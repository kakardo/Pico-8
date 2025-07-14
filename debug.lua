--[[ DEBUG.LUA
	- Made to track and surveil the game.
	@date 2025-07-14

	FUNCTIONS
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

// LAST_LINE_SNAKE_EXTERNAL_LUA