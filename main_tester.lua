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
		printh("<Test:"..total_tests.."> Success")
	else
		failed_tests += 1
		printh("<Test:"..total_tests.."> Fail")
	end
end

function print_test_stats()
	percentage = successful_tests/total_tests*100
	printh("Results = "..flr(percentage).."%".. --Only whole numbers
		" ("..successful_tests.." SUCCESS / "..failed_tests.." FAIL)")
end

function test_tables()
	printh("Table Tester")
	table = {"Crash","Spyro","Ratchet","Clank","Jak","Daxter",}

	boolean_test(#table == 6)
	boolean_test(del(table, "Ratchet") == "Ratchet")
	boolean_test(table[3] == "Clank")
	boolean_test(add(table, "Clank", 3) == "Clank")
	boolean_test(table[3] == "Clank")

	print_test_stats()
end

function test_empty_cells()
	tec = {}
	tec.x = {}
	tec.y = {}

	--convert_coordinate_to_index()

	

	--boolean_test()
	--print_test_stats()
end


function _init()
	--store_empty_cells()
	--init_head()
	--init_body()
	--init_fruit()
	printh("TESTER START")
	--test_tables()
	test_empty_cells()
	printh("Run time: "..time().."\n")
end

function _update()
	cls(1)
end

function _draw()
end

// LAST_LINE_MAIN_TESTER_LUA