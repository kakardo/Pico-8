--[[ MAIN_TESTER.LUA
	- Testing enviroment for the snake game.
	@author Kardo Rostam
]]--

scale = 8 -- size of game steps
max = 128

button_pushed = 1
just_moved = false
step = 1

-- game loop tick
tick_goal = 15 -- Default = 5
tick_count = 0

score = 0

---------------------------------------------------------------

function tester_tables()


end

function _init()
	store_empty_cells()
	init_head()
	init_body()
	init_fruit()
end

function _update()
	cls(1)
end

function _draw()
end


// LAST_LINE_MAIN_TESTER_LUA