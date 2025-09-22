--[[ MAIN.LUA
	- Main loop of the program.
	@author Kardo Rostam
	@date 2025-09-15
		
	https://en.wikipedia.org/wiki/Platonic_solid
	https://en.wikipedia.org/wiki/3D_projection
	https://en.wikipedia.org/wiki/Orthographic_projection
	https://en.wikipedia.org/wiki/Perspective_(graphical)

	TODO
	- Implement the five platonic solids:
		Regular tetrahedron
		Cube
		Regular octahedron 
		Regular dodecahedron
		Regular icosahedron 
	- Implement two perspective:
		Orthographic (ignores depth)
		Perspective
	
Notes for MD-doc
Linear algebra's needed for matrix calculations.
Cube has 8 corners (vertices).

]]--

-- vertices (8 in a cube)
vertices = { -- Front: -1, Back: +1
	{-1,-1,-1}, {1,-1,-1}, {1,1,-1}, {-1,1,-1},
	{-1,-1, 1}, {1,-1, 1}, {1,1, 1}, {-1,1, 1}
}

edges = { -- (12 in a cube)
  {1,2}, {2,3}, {3,4}, {4,1}, -- back
  {5,6}, {6,7}, {7,8}, {8,5}, -- front
  {1,5}, {2,6}, {3,7}, {4,8}  -- bridges
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

--[[ MAIN - - - - - - - - - - - - ]]--
function _init()
	center_x, center_y = 64, 64
	color = 7
	scale = 24
	
	angle_x, angle_y, angle_z = 0, 0, 0
	angle_x_step, angle_y_step, angle_z_step = 0.005, 0.003, 0.001

	menu_x, menu_y, menu_z = 2, 0, 0
	selected = 0
end

function _update()
	-- Horizontal
	if btnp(0) then
		if selected == 0 then
			selected = 2
		else
			selected -= 1
		end
	end
	if btnp(1) then
		if selected == 2 then
			selected = 0
		else
			selected += 1
		end
	end

	-- Vertical
	if btnp(2) then
		if selected == 0 then
			angle_x_step += 0.001
		elseif selected == 1 then
			angle_y_step += 0.001
		else
			angle_z_step += 0.001
		end
	end
	if btnp(3) then
		if selected == 0 then
			angle_x_step -= 0.001
		elseif selected == 1 then
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
	
	for e in all(edges) do
		alfa = vertices[e[1]]
		beta = vertices[e[2]]
	
		ax, ay, az = calc_rotation(alfa[1], alfa[2], alfa[3])
		bx, by, bz = calc_rotation(beta[1], beta[2], beta[3])

		pointX1, pointY1 = calc_projection(ax, ay)
		pointX2, pointY2 = calc_projection(bx, by)

		line(pointX1, pointY1, pointX2, pointY2, 7)
	end

	
	text_x = "X : "..flr(angle_x_step * 1000)
	text_y = "Y : "..flr(angle_y_step * 1000)
	text_z = "Z : "..flr(angle_z_step * 1000)
	
	if selected == 0 then
		text_x = "< "..text_x.." >"
	elseif selected == 1 then
		text_y = "< "..text_y.." >"
	else
		text_z = "< "..text_z.." >"
	end
	
	solid = "cube"
	solid_centered = 64 - #solid * 2
	print(solid, solid_centered, 0, 3)
	
	angle_text = text_x.." "..text_y.." "..text_z
	angle_centered = 64 - #angle_text * 2
	print(angle_text, angle_centered, 7, 3)
end

-- LAST_LINE_MAIN_LUA