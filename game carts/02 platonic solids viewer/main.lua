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

--[[ ROTATION - - - - - - - - - - ]]--
-- sin() and cos() angles go from 0 to 360° (0.0 to 1.0)
-- example -> 0.25 = 90°, 1.0 = 360°)
function calc_rotation(x, y, z)
	x, y, z = rotate_x(x, y, z, angle.get_step("x"))
	x, y, z = rotate_y(x, y, z, angle.get_step("y"))
	x, y, z = rotate_z(x, y, z, angle.get_step("z"))
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
			angle.step_up(x)
		elseif selected == 2 then
			angle.step_up(y)
		else
			angle.step_up(z)
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
			angle.step_down(x)
		elseif selected == 2 then
			angle.step_down(y)
		else
			angle.step_down(z)
		end
	end
	
	angle.update()
end

function _draw()
	cls()

	-- DRAW EDGES BETWEEN VERTICES
	for e in all(solids[shape].e) do
		alfa = solids[shape].v[e[1]]
		beta = solids[shape].v[e[2]]
	
		ax, ay, az = calc_rotation(alfa[1], alfa[2], alfa[3])
		bx, by, bz = calc_rotation(beta[1], beta[2], beta[3])

		pointX1, pointY1 = solids.calc_projection(ax, ay)
		pointX2, pointY2 = solids.calc_projection(bx, by)

		line(pointX1, pointY1, pointX2, pointY2, 7)
	end
 
	-- CONVERT LONG TEXT TO VARIABLES
	text_shape = solids[shape].dice
	text_x = "X= "..ceil(angle.get_step("x") * 1000)
	text_y = "Y= "..ceil(angle.get_step("y") * 1000)
	text_z = "Z= "..ceil(angle.get_step("z") * 1000)

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