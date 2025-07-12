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
	snake.x = 64
	snake.y = 64
	snake.dir = 1 --at start, move right
	snake.alive = true
end


function init_body()
	body.segments = 0
	body.x = {}
	body.y = {}
end


function draw_snake()
	spr(9,snake.x,snake.y)
	
	if body.segments > 0 then
		for i = 1, body.segments do
			spr(9,body.x[i],body.y[i])
		end
	end
end

function is_alive()
	if snake.x < 0 or snake.x > 128 or
	   snake.y < 0 or snake.y > 128 then
		snake.alive = false
	end
end

--[[ FRUIT FUNCTIONS -------------------- ]]--

function draw_fruit()
	spr(10,fruit.x,fruit.y)
end

function spawn_fruit()
	fruit.x = rnd(16) * scale
	fruit.y = rnd(16) * scale
end

function is_fruit_eaten()
	if snake.x == fruit.x and snake.y == fruit.y then
		body.segments += 1
		body.x[body.segments] = fruit.x
		body.y[body.segments] = fruit.y
		
		spawn_fruit()
	end
	
end

// LAST_LINE_SNAKE_LUA