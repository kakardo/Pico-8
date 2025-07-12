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

-- Stores pressed button direction until move update
function check_button_push()
	if (btn(0))	then
		button_pushed = 0 -- LEFT
	elseif (btn(1)) then
		button_pushed = 1 -- RIGHT
	elseif (btn(2)) then
		button_pushed = 2 -- UP
	elseif (btn(3)) then
		button_pushed = 3 -- DOWN
	end
end

function move()
	if (button_pushed == 0)	then
		snake.x += scale * (-step) -- LEFT
		snake.dir = 0
	elseif (button_pushed == 1) then
		snake.x += scale * (step) -- RIGHT
		snake.dir = 1
	elseif (button_pushed == 2) then
		snake.y += scale * (-step) -- UP
		snake.dir = 2
	elseif (button_pushed == 3) then
		snake.y += scale * (step) -- DOWN
		snake.dir = 3
	else
		move_increment()
	end
	
	just_moved = true
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