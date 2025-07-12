--[[ MAIN.LUA 
	- Main loop of the program.

	FUNCTIONS
	
]]--

head = {}
body = {}
fruit = {}

scale = 8 -- size of game steps
button_pushed = 1
step = 1
just_moved = false

-- game loop tick
tick_goal = 5
tick_count = 0

function _init()
	init_head()
	init_body()
	init_fruit()
	spawn_fruit()
end

function _update()
	cls(1)
	debug() -- Not part of ready game
	check_button_push()

	if (just_moved == false) then
	 move()
	 is_alive()
	 is_fruit_eaten()
	elseif tick_count == tick_goal then
		just_moved = false
		tick_count = 0
	else
	 tick_count += 1
	end
end

function _draw()
	if head.alive then
		draw_snake()
		draw_fruit()
	else
		print("game over")
	end
end

// LAST_LINE_MAIN_LUA