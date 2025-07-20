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
total_tests = 0
successful_tests = 0
failed_tests = 0

has_run = false

function boolean_test(boolean_argument)
	total_tests += 1

	if boolean_argument then
		successful_tests += 1
		printh("Success")
	else
		failed_tests += 1
		printh("Fail")
	end
end

function print_test_stats()
	percentage = successful_tests/total_tests*100
	printh("Results = "..percentage.."%"..
		" ("..successful_tests.." SUCCESS / "..failed_tests.." FAIL)")
end

function tester_tables()
	printh("Table Tester")
	table = {"Crash","Spyro","Ratchet","Clank","Jak","Daxter",}

	boolean_test(#table == 6)
	print_test_stats()
end


function _init()
	--store_empty_cells()
	--init_head()
	--init_body()
	--init_fruit()
	printh("TESTER START")
	tester_tables()
	printh("Run time: "..time().."\n")
end

function _update()
	cls(1)
end

function _draw()
end


// LAST_LINE_MAIN_TESTER_LUA