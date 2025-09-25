--[[ SOLIDS.LUA
	- Main loop of the program.
	@author Kardo Rostam
	@date 2025-09-15

]]--

solids = {
	{
		name="tetrahedron", dice="d4", color=8,
		v = { -- 4 vertices
			{ 1, 1, 1}, {-1,-1, 1},
			{-1, 1,-1},	{ 1,-1,-1}
		},
		e = { -- 6 edges
			{1,2}, {1,3}, {1,4},
			{2,3}, {2,4}, {3,4}
		}
	},
	{
		name="cube", dice="d6", color=9,
		v = { -- vertices (8 in a cube) Front: -1, Back: +1
			{-1,-1,-1}, {1,-1,-1}, {1,1,-1}, {-1,1,-1},
			{-1,-1, 1}, {1,-1, 1}, {1,1, 1}, {-1,1, 1}
		},
		e = { -- (12 edges in a cube)
			{1,2}, {2,3}, {3,4}, {4,1}, -- back
			{5,6}, {6,7}, {7,8}, {8,5}, -- front
			{1,5}, {2,6}, {3,7}, {4,8}  -- bridges
		}
	},
	{
		name="octahedron", dice="d8", color=10,
		v = {
			{ 1, 0, 0}, {-1, 0, 0}, { 0, 1, 0},
			{ 0,-1, 0}, { 0, 0, 1}, { 0, 0,-1}
		},
		e = { -- connects to all except its opposite
			{1,3}, {1,4}, {1,5}, {1,6},
			{2,3}, {2,4}, {2,5}, {2,6},
			{3,5}, {3,6}, {4,5}, {4,6}
		}
	},
	{name="dodecahedron", dice="d12", color=11},
	{name="icosahedron", dice="d20", color=12},
}


function solids.init()
end

function solids.calc_projection(x, y)
	return x * scale + center_x, y * scale + center_y
end



angle = {
	angle_x, angle_y, angle_z = 0, 0, 0
}
angle_x_step, angle_y_step, angle_z_step = 0.005, 0.003, 0.001

function angle.step(coordinate, value)
	if coordinate == "x" then
		angle_x += value
	elseif coordinate == "y" then
		angle_y += value
	elseif coordinate == "z" then
		angle_z += value
	else
		print("ERROR angle.step")
end