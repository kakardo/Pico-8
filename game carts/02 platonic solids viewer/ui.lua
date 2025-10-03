--[[ UI.LUA
	@author Kardo Rostam (https://github.com/kakardo/Pico-8)
	@date 2025-10-03
]]--

ui = {
	 centered_txt = function(txt, y_pos, txt_color)
		x_pos = 64 - #txt * 2 
		print(txt, x_pos, y_pos, txt_color)
	end,

	input_handler = function()
		-- HORIZONTAL
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
		
		-- VERTICAL
		if btnp(2) then
			if selected == 0 then
				if shape == 5 then
					shape = 1
				else
					shape += 1
				end
			elseif selected == 1 then
				angle.step_up("x")
			elseif selected == 2 then
				angle.step_up("y")
			else
				angle.step_up("z")
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
				angle.step_down("x")
			elseif selected == 2 then
				angle.step_down("y")
			else
				angle.step_down("z")
			end
		end
		
		-- SWITCHABLE NORMAL VS DEBUG MODE (X-KEY)
		if btnp(5) then
			if debug then
				debug = false
			else
				debug = true
			end
		end		
	end,

	print_menu = function(shape, x, y, z)
		dice_label = shape.dice
		color = shape.color

		-- CONVERT LONG TEXT TO VARIABLES
		x = "X= "..ceil(x * 1000)
		y = "Y= "..ceil(y * 1000)
		z = "Z= "..ceil(z * 1000)

		-- MENU STABILIZATION FOR SINGLE DIGIT DICES
		local space = ""
		if	dice_label == "d4" or
			dice_label == "d6" or
			dice_label == "d8" then
			space = " "
		end
		
		-- HIGHLIGHT CHOSEN OPTION
		if selected == 0 then
			dice_label = "<"..dice_label..">"..space
			x = " "..x.." "
			y = " "..y.." "
			z = " "..z.." "
		elseif selected == 1 then
			dice_label = " "..dice_label.." "..space
			x = "<"..x..">"
			y = " "..y.." "
			z = " "..z.." "
		elseif selected == 2 then
			dice_label = " "..dice_label.." "..space
			x = " "..x.." "
			y = "<"..y..">"
			z = " "..z.." "
		else
			dice_label = " "..dice_label.." "..space
			x = " "..x.." "
			y = " "..y.." "
			z = "<"..z..">"
		end
		
		-- OPTION MENU
		options = dice_label.." "..x.." "..y.." "..z
		ui.centered_txt(shape.name, 0, color)
		ui.centered_txt(options, 7, color)
		ui.centered_txt("⬅️/➡️ switch parameters", 116, color)
		ui.centered_txt("⬆️/⬇️ adjust rotation speed", 123, color)
	end,

	print_debug_menu = function(x, y, z, draw_buffer, error_msg)
		-- DEBUG
		if debug then
			print("debug",0,0,4)
			print("x "..angle.get("x"),0,14,4)
			print("y "..angle.get("y"),0,21,4)
			print("z "..angle.get("z"),0,28,4)
			print("buff "..#draw_buffer)
			
			-- Print saved error messages
			for msg in all(error_msg) do
				print(msg)
			end
		end
	end
}

-- LAST_LINE_OF_UI_LUA