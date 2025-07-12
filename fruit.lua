--[[ FRUIT.LUA 
	- Functions connected the fruit which
	  the snake crave more than anything.

	FUNCTIONS
	- check_button_push()
	- move()
	- move_increment()
]]--

function init_fruit()
	fruit.x = 0
	fruit.y = 0
end

function draw_fruit()
	spr(1,fruit.x,fruit.y)
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
		
		score += 10
		spawn_fruit()	
	end
end

// LAST_LINE_FRUIT_LUA