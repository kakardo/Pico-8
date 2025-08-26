--[[ MAIN.LUA
	- Main loop of the program.
	@author Kardo Rostam

	@date 2025-07-14
	@version 1.0
	- Basic gameplay:	
		# Fruit spawns (always one on field).
		# Snake can eat fruit to grow.
		# Crude game over screen.
		# Scoreboard.
	- Four colors (not black and white!).
	- No going backwards into body.
	@version 1.1
	- No suicide turning (a command that turnes snake into      <2025-07-25>
	  its own body within an 1-step move even though the path
	  ahead is clear and the death could have been avoided).
	- Fruit never spawns on top of the snake. The spawning
	  position's randomised from table of available locations.  <2025-07-29>
	- Game over screen show score, length and instruction on    <2025-07-29>
	  how to restart.
	- Crawling into your own body leads to GAME OVER.           <2025-07-31>
	- Snakes body's visually linked together. Shapes (vertical, <2025-08-06>
      horizontal and corners) are dynamically placed depending
	  on path, and tail's dynamically rotated accordingly.

	TODO
	- Fix: snake dies if heading for tail that should have had
	  the time to move away. Incorrect collision.
	- Make suicide turn a toggleable option.
	- Increase speed at certain lengths.
	- Possibility to dash for higher score.
	- [VISUAL] Start screen.
	- [VISUAL] Game border.
	- [VISUAL] Multiple fruit types.
	- [SOUND] Fruit
	- [SOUND] Snake crawl
	- [SOUND] Game over
	
	KNOWN BUGS
	- Tail becomes an error cube sometimes.
	- Can crawl through tail sometimes without dying.
]]--

-- TABLES AND VARIABLES
--TODO Limit scale use. Mark variables that has been scaled.
scale = 8 -- size of game steps
min = 0
max = 128

button_pushed = 1
just_moved = false
step = 1

-- game loop tick
tick_goal = 5 -- Default = 5, Testing = 15
tick_count = 0

score = 0

print_tests = true

---------------------------------------------------------------
--[[ TODO

]]--

function _init()
	-- Cell tables
	empty_cells     = init_isEmpty    (max, scale)
	available_cells = init_isAvailable(max, scale)

	-- Snake tables
	init_head()
	init_body()
	init_fruit()
	printh("\n\nSnake debugger text")
end

function _update()
	cls(1)
	game_state_checker() -- Not part of ready game

	if head.alive then
		check_button_push()

		if (just_moved == false) then
		 move()
		 is_alive(min, max)
		 is_fruit_eaten()
		elseif tick_count == tick_goal then
			just_moved = false
			tick_count = 0
		else
		 tick_count += 1
		end
	end
end

function _draw()
	if head.alive then
		--print("score = "..score)	
		draw_snake()
		draw_fruit()
	else
		print_centered("score: "..score,32,32,9)
		print_centered("lenght: "..body.segments+1,96,32,11)
		print_centered("game over",64,64,8)
		print_centered("press \"ctr + r\" to restart",64,72,13)
	end
end

function game_state_checker()
	debug() -- Not part of ready game
	
	if #body.x != #body.y then
		print("X and Y total's not the same!")
	elseif body.segments != #body.x then
		print("Body segments not equal to X!")
	elseif body.segments != #body.y then
		print("Body segments not equal to X!")
	end

	-- Test prints
	if print_tests then
		used_cells = 256 - count(empty_cells)
		print("empty_cells:"..count(empty_cells)..
			  " (used:"..used_cells..")")
		print("available:"..#available_cells)
		print("segments:"..body.segments..
			  ' X = '..head.x..' Y = '..head.y)
		print("button pushed "..button_pushed.." -> head.dir "..head.dir)

		--print("AV-CELLS:"..available_cells[ceil(#available_cells)])
		--print("available:"..available_cells[flr(rnd(#available_cells))])
	end
end

function print_centered(str, x, y, color)
	x_centered = x - #str * 2
	y_centered = y - 3 --Half string height
	print(str, x_centered, y_centered, color)
end

// LAST_LINE_MAIN_LUA