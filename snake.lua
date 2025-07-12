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


function init_head()
	head.x = 64
	head.y = 64
	head.dir = 1 --at start, move right
	head.alive = true
end


function init_body()
	body.segments = 0
	body.x = {}
	body.y = {}
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