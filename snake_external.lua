--[[ FUNCTIONS
	- debug()
	- is_alive()
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

end


function is_alive()
	if snake.x < 0 or snake.x > 128 or
	   snake.y < 0 or snake.y > 128 then
		snake.alive = false
	end
end

// LAST_LINE_SNAKE_EXTERNAL_LUA