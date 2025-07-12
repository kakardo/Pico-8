--[[ FUNCTIONS
	- debug()
]]--

function debug()
	print('X = '..snake.x)
	print('Y = '..snake.y)
	
	if snake.alive then
	 print('Alive = TRUE')
	else
	 print('Alive = FALSE')
	end

	-- Resurrect snake for debugging purposes
	if snake.x >= 1 and snake.x <= 128 and
	   snake.y >= 1 and snake.y <= 128 then
		snake.alive = true
	end
	
	print('Length = '..body.segments)
	print('Frukt x = '..fruit.x)
	print('Frukt y = '..fruit.y)
end

// LAST_LINE_SNAKE_EXTERNAL_LUA