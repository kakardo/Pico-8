--[[ MOVEMENT.LUA 
	- Functions connected to the movement
	  of the snake.

	FUNCTIONS
	- check_button_push()
	- move()
	- move_increment()
	
	DIRECTIONS
	0 = left
	1 = right
	2 = up
	3 = down
]]--

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

-- Move snake and update variable "just_moved" to TRUE
function move()
	if (button_pushed == 0)	then
		update_snake()
		snake.x += scale * (-step) -- LEFT
		snake.dir = 0
	elseif (button_pushed == 1) then
		update_snake()
		snake.x += scale * (step) -- RIGHT
		snake.dir = 1
	elseif (button_pushed == 2) then
		update_snake()
		snake.y += scale * (-step) -- UP
		snake.dir = 2
	elseif (button_pushed == 3) then
		update_snake()
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

// LAST_LINE_MOVEMENT_LUA