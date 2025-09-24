--[[ MAIN.LUA
	- Main loop of the program.
	@author Kardo Rostam
	@date 2025-09-15
		
	https://en.wikipedia.org/wiki/Platonic_solid
	https://en.wikipedia.org/wiki/3D_projection
	https://en.wikipedia.org/wiki/Orthographic_projection
	https://en.wikipedia.org/wiki/Perspective_(graphical)
	- Linear algebra's needed for matrix calculations.

	TODO
	- Implement the five platonic solids:
		Regular dodecahedron
		Regular icosahedron 
	- Implement two perspective:
		Orthographic (ignores depth)
		Perspective
	- Make them appear the same size. The solids don't have the
	  same radius to origin as each other. Octahedron's a good
	  example. It renders really small compared to D4 and D6.
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
	{name="icosahedron", dice="d20", color=12}
}

function calc_projection(x, y)
	return x * scale + center_x, y * scale + center_y
end

--[[ ROTATION - - - - - - - - - - ]]--
-- sin() and cos() angles go from 0 to 360° (0.0 to 1.0)
-- example -> 0.25 = 90°, 1.0 = 360°)
function calc_rotation(x, y, z)
	x, y, z = rotate_x(x, y, z, angle_x)
	x, y, z = rotate_y(x, y, z, angle_y)
	x, y, z = rotate_z(x, y, z, angle_z)
	return x, y, z
end

function rotate_x(x, y, z, angle)
	return 	x,
			y*cos(angle) - z*sin(angle),
			y*sin(angle) + z*cos(angle)
end

function rotate_y(x, y, z, angle)
	return 	x*cos(angle) - z*sin(angle),
			y,
			x*sin(angle) + z*cos(angle)
end

function rotate_z(x, y, z, angle)
	return 	x*cos(angle) - y*sin(angle),
			x*sin(angle) + y*cos(angle),
			z
end

--[[ TEXT - - - - - - - - - - - - ]]--
function print_centered_txt(txt, y_pos, txt_color)
	x_pos = 64 - #txt * 2 
	print(txt, x_pos, y_pos, txt_color)
end

--[[ MAIN - - - - - - - - - - - - ]]--
function _init()
	center_x, center_y = 64, 64
	scale = 30
	
	angle_x, angle_y, angle_z = 0, 0, 0
	angle_x_step, angle_y_step, angle_z_step = 0.005, 0.003, 0.001

	selected = 0
	shape = 1
end

function _update()
	-- Horizontal
	if btnp(0) then
		if selected == 0 then
			selected = 3
		else
			selected -= 1
		end
	end
	if btnp(1) then
		if selected == 3 then
			selected = 0
		else
			selected += 1
		end
	end

	-- Vertical
	if btnp(2) then
		if selected == 0 then
			if shape == 5 then
				shape = 1
			else
				shape += 1
			end
		elseif selected == 1 then
			angle_x_step += 0.001
		elseif selected == 2 then
			angle_y_step += 0.001
		else
			angle_z_step += 0.001			
		end
	end
	if btnp(3) then
		if selected == 0 then
			if shape == 1 then
				shape = 5
			else
				shape -= 1
			end
		elseif selected == 1 then
			angle_x_step -= 0.001
		elseif selected == 2 then
			angle_y_step -= 0.001
		else
			angle_z_step -= 0.001
		end
	end
	
	angle_x += angle_x_step
	angle_y += angle_y_step
	angle_z += angle_z_step
end

function _draw()
	cls()
	
	-- DRAW EDGES BETWEEN VERTICES
	for e in all(solids[shape].e) do
		alfa = solids[shape].v[e[1]]
		beta = solids[shape].v[e[2]]
	
		ax, ay, az = calc_rotation(alfa[1], alfa[2], alfa[3])
		bx, by, bz = calc_rotation(beta[1], beta[2], beta[3])

		pointX1, pointY1 = calc_projection(ax, ay)
		pointX2, pointY2 = calc_projection(bx, by)

		line(pointX1, pointY1, pointX2, pointY2, 7)
	end
 
	-- CONVERT LONG TEXT TO VARIABLES
	text_shape = solids[shape].dice
	text_x = "X= "..ceil(angle_x_step * 1000)
	text_y = "Y= "..ceil(angle_y_step * 1000)
	text_z = "Z= "..ceil(angle_z_step * 1000)

	-- HIGHLIGHT CHOSEN OPTION
	if selected == 0 then
		text_shape = "<"..text_shape..">"
		text_x = " "..text_x.." "
		text_y = " "..text_y.." "
		text_z = " "..text_z.." "
	elseif selected == 1 then
		text_shape = " "..text_shape.." "
		text_x = "<"..text_x..">"
		text_y = " "..text_y.." "
		text_z = " "..text_z.." "
	elseif selected == 2 then
		text_shape = " "..text_shape.." "
		text_x = " "..text_x.." "
		text_y = "<"..text_y..">"
		text_z = " "..text_z.." "
	else
		text_shape = " "..text_shape.." "
		text_x = " "..text_x.." "
		text_y = " "..text_y.." "
		text_z = "<"..text_z..">"
	end
	
	-- OPTION MENU
	color = solids[shape].color
	options = text_shape.." "..text_x.." "..text_y.." "..text_z

	print_centered_txt(solids[shape].name, 0, color)
	print_centered_txt(options, 7, color)
	print_centered_txt("⬅️/➡️ switch parameters", 116, color)
	print_centered_txt("⬆️/⬇️ adjust angle", 123, color)
end

-- LAST_LINE_MAIN_LUA