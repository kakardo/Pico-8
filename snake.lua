--[[ MOVEMENT.LUA 
	- Functions connected to the body
	  and head of the snake.

	FUNCTIONS
	- init_head()
	- init_body()
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

function is_fruit_eaten()
	if snake.x == 88 and snake.y == 88 then
		body.segments += 1
		body.x[body.segments] = 88
		body.y[body.segments] = 88
	end
end


function is_alive()
	if snake.x < 0 or snake.x > 128 or
	   snake.y < 0 or snake.y > 128 then
		snake.alive = false
	end
end

// LAST_LINE_SNAKE_LUA