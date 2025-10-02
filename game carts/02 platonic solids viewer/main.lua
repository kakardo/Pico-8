--[[ MAIN.LUA
	- Main loop of the program.
	@author Kardo Rostam
	@date 2025-09-15
	HTML & JS GENERATED: 2025-09-29
	
	https://en.wikipedia.org/wiki/Platonic_solid
	https://en.wikipedia.org/wiki/3D_projection
	https://en.wikipedia.org/wiki/Orthographic_projection
	https://en.wikipedia.org/wiki/Perspective_(graphical)
	- Linear algebra's needed for matrix calculations.

	- Make them appear the same size. The solids don't have the
	  same radius to origin as each other. Octahedron's a good
	  example. It renders really small compared to D4 and D6.
]]--

--[[ ROTATION - - - - - - - - - - ]]--
-- sin() and cos() angles go from 0 to 360° (0.0 to 1.0)
-- example -> 0.25 = 90°, 1.0 = 360°)
function calc_rotation(x, y, z)
	x, y, z = rotate_x(x, y, z, angle.get("x"))
	x, y, z = rotate_y(x, y, z, angle.get("y"))
	x, y, z = rotate_z(x, y, z, angle.get("z"))
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

function calc_projection(x, y)
	return x * scale + center_x, y * scale + center_y
end

--[[ MAIN - - - - - - - - - - - - ]]--
function _init()
	center_x, center_y = 64, 64
	scale = 48

	solids.init()

	selected = 0
	shape = 5
	
	debug = false
end

function _update()
	ui.input_handler()
	angle.update()
	
	-- SAVE ROTATED VERTICES
	draw_buffer = {}

	for e in all(solids[shape].e) do
		alfa = solids[shape].v[e[1]]
		beta = solids[shape].v[e[2]]
	
		ax, ay, az = calc_rotation(alfa[1], alfa[2], alfa[3])
		bx, by, bz = calc_rotation(beta[1], beta[2], beta[3])

		pointX1, pointY1 = calc_projection(ax, ay)
		pointX2, pointY2 = calc_projection(bx, by)

		add(draw_buffer, {pointX1, pointY1, pointX2, pointY2, 7})
	end
	
	error_msg = {}
	if shape == 1 and #draw_buffer != 6 then
		add(error_msg, "error draw_buffer size (d4)")
	elseif shape == 2 and #draw_buffer != 12 then
		add(error_msg, "error draw_buffer size (d6)")
	elseif shape == 3 and #draw_buffer != 12 then
		add(error_msg, "error draw_buffer size (d8)")
	elseif shape == 4 and #draw_buffer != 30 then
		add(error_msg, "error draw_buffer size (d12)")
	elseif shape == 5 and #draw_buffer != 30 then
		add(error_msg, "error draw_buffer size (d20)")
	end
end

function _draw()
	cls()

	-- DRAW LINES WITH SAVED VERTICES
	for seg in all(draw_buffer) do
		line(seg[1], seg[2], seg[3], seg[4], seg[5])
	end

	-- PRINT MENU
	ui.print_menu(solids[shape], angle.get_step("x"),
		    	  angle.get_step("y"), angle.get_step("z"))
				  
	ui.print_debug_menu(angle.get("x"), angle.get("y"),
						angle.get("z"), draw_buffer, error_msg)
end

-- LAST_LINE_MAIN_LUA