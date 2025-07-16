--[[ MOVEMENT.LUA 
	- Functions connected to the body
	  and head of the snake.
	@date 2025-07-14
	
	FUNCTIONS
	- init_head()
	- init_body()
	- update_snake()
	- draw_snake()
	- is_alive()
]]--

-- VARIABLES USED ONLY IN SNAKE.LUA
snake_starting_length = 4
snake_starting_coordinate = 64
snake_starting_direction = 1

function init_head()
	head.x = snake_starting_coordinate
	head.y = snake_starting_coordinate
	head.dir = snake_starting_direction
	head.alive = true
	
	add_to_table(head.x, head.y)
end

function init_body()
	body.segments = snake_starting_length
	body.x = {}
	body.y = {}
	
	-- Build by looping once for each segment.
	local starting_x_pos = snake_starting_coordinate
	
	for i = 1, body.segments, 1 do
		starting_x_pos -= scale
		body.x[i] = starting_x_pos
		body.y[i] = snake_starting_coordinate
	end

	add_to_table(body.x[4], body.y[4])
end

-- Update the snakes movement table.
function update_snake()
	for i = body.segments, 1, -1 do
		body.x[i] = body.x[i-1]
		body.y[i] = body.y[i-1]
	end

	body.x[1] = head.x
	body.y[1] = head.y
end

-- Draw snake with its table as reference.
function draw_snake()
	-- Draw head
	spr(0,head.x,head.y)
	
	-- Draw body
	if body.segments > 0 then
		for i = body.segments, 1, -1 do
			spr(0,body.x[i],body.y[i])
		end
	end
end

-- Checks if the snake is within bounds
function is_alive()
	if head.x < 0 or head.x > 128 or
	   head.y < 0 or head.y > 128 then
		head.alive = false
	end
end

// LAST_LINE_SNAKE_LUA