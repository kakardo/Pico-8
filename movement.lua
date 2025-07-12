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
	avert_going_backwards()

	if (button_pushed == 0) then
		update_snake()
		head.x += scale * (-step) -- LEFT
		head.dir = 0
	elseif (button_pushed == 1) then
		update_snake()
		head.x += scale * (step) -- RIGHT
		head.dir = 1
	elseif (button_pushed == 2) then
		update_snake()
		head.y += scale * (-step) -- UP
		head.dir = 2
	elseif (button_pushed == 3) then
		update_snake()
		head.y += scale * (step) -- DOWN
		head.dir = 3
	end
	
	just_moved = true
end

function avert_going_backwards()
	if button_pushed == 0 and head.dir == 1 then
		button_pushed = head.dir
	elseif button_pushed == 1 and head.dir == 0 then
		button_pushed = head.dir
	elseif button_pushed == 2 and head.dir == 3 then
		button_pushed = head.dir
	elseif button_pushed == 3 and head.dir == 2 then
		button_pushed = head.dir
	end
end

// LAST_LINE_MOVEMENT_LUA