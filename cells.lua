--[[ CELLS.LUA 
	-
	Cell grid coordinates starts at 1 (and not 0). Not my choice
	but's built in Pico 8:s array index. Little bit weird.
	
	FUNCTIONS
	- init_isEmpty								(max_position, scale)
	- init_isAvailable						(max_position, scale)
	- convert_coordinate_to_index	(x, y)
	- empty_cells_occupy					(table, del_x, del_y)
	- empty_cells_free						(table, add_x, add_y)
	- is_occupied									(table, x, y)
]]--

-- TABLES AND VARIABLES

function init_isEmpty(max_position, scale)
	table = {}

	for y = 0, max_position-1, scale do
		for x = 0, max_position-1, scale do
			table[convert_coordinate_to_index(x, y)] = false
			--printh("X:"..x.." Y:"..y.." Key:"..convert_coordinate_to_index(x, y))
		end
	end

	return table
end

function init_isAvailable(max_position, scale)
	table = {}

	for y = 1, max_position/scale, 1 do
		for x = 1, max_position/scale, 1 do
			add(table, convert_coordinate_to_index(x, y))
			--printh("X:"..x.." Y:"..y.." Key:"..convert_coordinate_to_index(x, y))
		end
	end
	
	return table
end

function convert_coordinate_to_index(x, y)
	return y * max + x
end

function empty_cells_occupy(table, del_x, del_y)
	index_key = convert_coordinate_to_index(del_x, del_y)
	table[index_key] = true

	-- TODO get available_cells as parameter and not global
	test = del(available_cells, index_key)
	printh("del["..del_x.."."..del_y.."]:"..test)
end

function empty_cells_free(table, add_x, add_y)
	index_key = convert_coordinate_to_index(add_x, add_y)
	table[index_key] = false

	-- TODO get available_cells as parameter and not global
	test = add(available_cells, index_key)
	printh("add["..add_x.."."..add_y.."]:"..test)
end

function is_occupied(table, x, y)
	if table[convert_coordinate_to_index(x, y)] then
		return true
	else
		return false
	end
end

// LAST_LINE_CELLS_LUA