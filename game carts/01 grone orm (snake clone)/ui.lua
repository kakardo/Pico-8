--[[ UI.LUA 
	@date 2025-10-12
	
	FUNCTIONS

]]--
death_bg_captured = false

function print_ui()
  print_centered("score: "..score, 32, 24, 9)
  print_centered("time: "..flr(cycle_cnt/60), 32, 32, 9)
  print_centered("length: "..body.segments+1, 96, 24, 11)
  print_centered("game over", 64, 48, 8)
  print_centered("press 🅾️/❎ or z/x to retry", 64, 56, 6)
  
  -- Letter (with space) = 4 pixels
  local score_x = 21
  local score_y = 77
  
  local score_color = 137
  print_centered("hiscore", 64, score_y, score_color)

  print_score("1st", hiscore[1], time_played[1], score_x, score_y+4, score_color, "kakardo")
  print_score("2nd", hiscore[2], time_played[2], score_x, score_y+11, score_color, "unknown")
  print_score("3rd", hiscore[3], time_played[3], score_x, score_y+18, score_color, "unknown")
  print_score("4th", hiscore[4], time_played[4], score_x, score_y+25, score_color, "unknown")
  print_score("5th", hiscore[5], time_played[5], score_x, score_y+32, score_color, "unknown")
end

function print_score(place, score, time, x, y, color, name)
  print(place, x, y, color)
  --print("88     88", x+12, y, 8) -- space check
  print(score, x+28, y, color)
  print(time, x+48, y, color)
  --print(name, x+48, y, color) -- space check
end

function print_centered(str, x, y, color)
	local x_centered = x - #str * 2
	local y_centered = y - 3 --Half string height
	print(str, x_centered, y_centered, color)
end

function print_cover_msg()
  local msg = "press 🅾️/❎ or z/x to start"
  local width = print(msg, 0, -6)
  local x = 64 - width / 2
  local y = 120
  print(msg, x, y, 7)
end

-- LAST_LINE_OF_UI_LUA