--[[ CELLS.LUA 
	- 
	@date 2025-07-18
	
	FUNCTIONS
	-
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

	for y = 0, max_position-1, scale do
		for x = 0, max_position-1, scale do
			test = add(table, convert_coordinate_to_index(x, y))
			--printh("X:"..x.." Y:"..y.." Key:"..test)
		end
	end
	
	return table
end

function convert_coordinate_to_index(x, y)
	return y * max + x
end

function empty_cells_occupy(table, del_x, del_y)
	table[convert_coordinate_to_index(del_x, del_y)] = true
end

function empty_cells_free(table, add_x, add_y)
	table[convert_coordinate_to_index(add_x, add_y)] = false
end

function is_occupied(table, x, y)
	if table[convert_coordinate_to_index(x, y)] then
		return true
	else
		return false
	end
end

// LAST_LINE_CELLS_LUA