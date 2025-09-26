--[[ ANGLE.LUA
	@author Kardo Rostam
	@date 2025-09-26
]]--

angle = {
	x = 0,
	y = 0,
	z = 0,

	x_step = 0.005,
	y_step = 0.003,
	z_step = 0.001,
	
	step_size = 0.001,
	
	get = function(coordinate)
		if coordinate == "x" then
			return angle.x
		elseif coordinate == "y" then
			return angle.y
		elseif coordinate == "z" then
			return angle.z
		else
			print("ERROR angle.get")
		end
	end,
	
	get_step = function(coordinate)
		if coordinate == "x" then
			return angle.x_step
		elseif coordinate == "y" then
			return angle.y_step
		elseif coordinate == "z" then
			return angle.z_step
		else
			print("ERROR angle.get_step")
		end
	end,
	
	step_up = function(coordinate)
		if coordinate == "x" then
			angle.x_step += angle.step_size
		elseif coordinate == "y" then
			angle.y_step += angle.step_size
		elseif coordinate == "z" then
			angle.z_step += angle.step_size
		else
			print("ERROR angle.step_up")
		end
	end,

	step_down = function(coordinate)
		if coordinate == "x" then
			angle.x_step -= angle.step_size
		elseif coordinate == "y" then
			angle.y_step -= angle.step_size
		elseif coordinate == "z" then
			angle.z_step -= angle.step_size
		else
			print("ERROR angle.step_down")
		end
	end,

	update = function()
		angle.x += angle.x_step
		angle.y += angle.y_step
		angle.z += angle.z_step
	end
}