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





angle = {
	x = 0,
	y = 0,
	z = 0,

	x_step = 0.005,
	y_step = 0.003,
	z_step = 0.001,
	
	step_size = 0.001
}

function angle.get(coordinate)
	if coordinate == "x" then
		return angle.x
	elseif coordinate == "y" then
		return angle.y
	elseif coordinate == "z" then
		return angle.z
	else
		print("ERROR angle.get")
	end
end

function angle.get_step(coordinate)
	if coordinate == "x" then
		return angle.x_step
	elseif coordinate == "y" then
		return angle.y_step
	elseif coordinate == "z" then
		return angle.z_step
	else
		print("ERROR angle.get_step")
	end
end

function angle.step_up(coordinate)
	if coordinate == "x" then
		angle.x_step += angle.step_size
	elseif coordinate == "y" then
		angle.y_step += angle.step_size
	elseif coordinate == "z" then
		angle.z_step += angle.step_size
	else
		print("ERROR angle.step_up")
	end
end

function angle.step_down(coordinate)
	if coordinate == "x" then
		angle.x_step -= angle.step_size
	elseif coordinate == "y" then
		angle.y_step -= angle.step_size
	elseif coordinate == "z" then
		angle.z_step -= angle.step_size
	else
		print("ERROR angle.step_down")
	end
end

function angle.update()
	angle.x += angle.x_step
	angle.y += angle.y_step
	angle.z += angle.z_step
end