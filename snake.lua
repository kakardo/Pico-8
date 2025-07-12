--[[ MOVEMENT.LUA 
	- Functions connected to the body
	  and head of the snake.

	FUNCTIONS
	- init_head()
	- init_body()
	- draw_snake()
	- is_fruit_eaten()
	- is_alive()
]]--

snake_starting_length = 5
snake_starting_coordinate = 64
snake_starting_direction = 1

function init_head()
	head.x = snake_starting_coordinate
	head.y = snake_starting_coordinate
	head.dir = snake_starting_direction
	head.alive = true
end

function init_body()
	body.segments = snake_starting_length
	body.x = {}
	body.y = {}
	
	coordinate_step = snake_starting_coordinate
	for i = body.segments, 1, -1 do
		coordinate_step -= scale
		body.x[i] = coordinate_step
	end
end

function update_snake()
	for i = body.segments, 1, -1 do
		body.x[i] = body.x[i-1]
		body.y[i] = body.y[i-1]
	end
	
	body.x[1] = head.x
	body.y[1] = head.y
end

function draw_snake()
	spr(9,head.x,head.y)
	
	if body.segments > 0 then
		for i = 1, body.segments do
			spr(9,body.x[i],body.y[i])
		end
	end
end

function is_alive()
	if head.x < 0 or head.x > 128 or
	   head.y < 0 or head.y > 128 then
		head.alive = false
	end
end

--[[ FRUIT FUNCTIONS -------------------- ]]--

function init_fruit()
	fruit.x = 0
	fruit.y = 0
end

function draw_fruit()
	spr(10,fruit.x,fruit.y)
end

function spawn_fruit()
	fruit.x = flr(rnd(128 / scale)) * scale
	fruit.y = flr(rnd(128 / scale)) * scale
end

function is_fruit_eaten()
	if head.x == fruit.x and head.y == fruit.y then
		body.segments += 1
		body.x[body.segments] = fruit.x
		body.y[body.segments] = fruit.y
		
		spawn_fruit()
	end
end

// LAST_LINE_SNAKE_LUA