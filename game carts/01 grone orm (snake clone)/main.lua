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
	- No suicide turning (a command that turns snake into      <2025-07-25>
	  its own body within an 1-step move even though the path
	  ahead is clear and the death could have been avoided).
	- Fruit never spawns on top of the snake. The spawning
	  position's randomized from table of available locations.  <2025-07-29>
	- Game over screen show score, length and instruction on    <2025-07-29>
		how to restart.
	- Crawling into your own body leads to GAME OVER.           <2025-07-31>
	- Snakes body's visually linked together. Shapes (vertical, <2025-08-06>
    horizontal and corners) are dynamically placed depending
	  on path, and tail's dynamically rotated accordingly.
	- When heading for collision with tail tile from the side:
		tail will have time to move away unless we grow by
		eating the same movement step / tick.               	    <2025-10-06>
	- Input buffering (instead of polling).                     <2025-10-07>
	- Top scores are shown on hiscore table.										<2025-10-20>
	@version 1.2
	- Multiple fruit sprites with random bag logic (so it's
		semi-random) and Fisher-Yates shuffle.										<2025-10-23>
	- Game over captures and shows a frame of your demise.      <2025-10-26>

	TODO
	- Add win screen.
	- Make suicide turn a toggle-able option.
	- Increase speed at certain lengths.
	- Possibility to dash for higher score.
	- [VISUAL] Start screen.
	- [VISUAL] Game border.
	- [SOUND] Fruit
	- [SOUND] Snake crawl
	- [SOUND] Game over
]]--

-- TABLES AND VARIABLES
-- TODO Limit scale use. Mark variables that has been scaled.
scale = 8 -- size of game steps
min = 0
max = 128

just_moved = false
step = 1

-- game loop tick
tick_goal = 3 -- Default = 4, Testing = 15
tick_count = 0

print_tests = true
---------------------------------------------------------------

function _init()
	show_cover = true
	init_score()
	init_game()
end

function _update60()
	--debug() -- Not part of ready game
	check_button_push()

	if show_cover then
		if btnp(4) or btnp(5) then
			show_cover = false
		end
		return
	end

	if head.alive then
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

	-- Let people restart with z/x when dead
	if not head.alive and (btnp(4) or btnp(5)) then
    init_game()
	end
end

function _draw()
	cls(1)
	
	
	if show_cover then
		sspr(0, 24, 128, 104, 0, 8)
		print_cover_msg()
	end

	if head.alive then
		death_bg_captured = false
		
		if not show_cover then
			print("score = "..score, 1, 1, 9)
			draw_snake()
			draw_fruit()
		end

		return
	end
	
	if not death_bg_captured then
		-- Draw screen without the HUD
		draw_snake()
		draw_fruit()
		memcpy(0x8000, 0x6000, 0x2000)
	  death_bg_captured = true
	end

	-- Restore saved death frame to screen
	memcpy(0x6000, 0x8000, 0x2000)
	print_ui()
end

function init_game()
	-- Cell tables
	empty_cells     = init_isEmpty    (max, scale)
	available_cells = init_isAvailable(max, scale)

	-- Snake tables
	init_head()
	init_body()
	init_fruit()

	-- Makes sure values are reset during game reset
	score = 0
	score_saved = false
	tick_count = 0
	just_moved = false
	update_next_dir(head.dir)  -- Buffered turn clear
	death_bg_captured = false
end

-- LAST_LINE_OF_MAIN_LUA