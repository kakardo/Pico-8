-- DIRECTIONS
-- 0 = left
-- 1 = right
-- 2 = up
-- 3 = down

--[[ FUNCTIONS
	- debug()
	- move()
	- move_increment()
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

function move()
	if (btn(0))	then
		snake.x += scale * (-1) -- LEFT
		snake.dir = 0
	elseif (btn(1)) then
		snake.x += scale * (1) -- RIGHT
		snake.dir = 1
	elseif (btn(2)) then
		snake.y += scale * (-1) -- UP
		snake.dir = 2
	elseif (btn(3)) then
		snake.y += scale * (1) -- DOWN
		snake.dir = 3
	else
		move_increment()
	end
end

-- No switch statements in Lua...
-- No increment (++) and decrement (--) operators in Lua...
function move_increment()
	if snake.dir == 0 then
		snake.x -= 1
	elseif snake.dir == 1 then
		snake.x += 1
	elseif snake.dir == 2 then
		snake.y -= 1
	elseif snake.dir == 3 then
		snake.y += 1
	end
end

function is_alive()
	if snake.x < 1 or snake.x > 128 or
	   snake.y < 1 or snake.y > 128 then
		snake.alive = false
	end
end

// LAST_LINE_SNAKE_EXTERNAL_LUA