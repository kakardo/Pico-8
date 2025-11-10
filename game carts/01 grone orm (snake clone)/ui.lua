--[[ UI.LUA 
	@date 2025-10-12
	
	FUNCTIONS

]]--
death_bg_captured = false

-- TODO FIX HIGH, MAKE IT PRETTIER
function print_ui()
  print_centered("score: "..score, 32, 24, 9)
  print_centered("time: "..flr(cycle_cnt/60), 32, 32, 9)
  print_centered("length: "..body.segments+1, 96, 24, 11)
  print_centered("game over", 64, 48, 8)
  print_centered("press 🅾️/❎ or z/x to retry", 64, 56, 6)
  
  -- Letter (with space) = 4 pixels
  local score_x = 18
  local score_y = 70
  
  local score_color = 137
  --print_centered("hiscore", 64, score_y, score_color)
  
  print_score("rank", "score", "time", score_x, score_y+4, 7, "player")
  print_score("1st", hiscore[1], time_played[1], score_x, score_y+11, score_color, "kakardo")
  print_score("2nd", hiscore[2], time_played[2], score_x, score_y+18, score_color, "unknown")
  print_score("3rd", hiscore[3], time_played[3], score_x, score_y+25, score_color, "unknown")
  print_score("4th", hiscore[4], time_played[4], score_x, score_y+32, score_color, "unknown")
  print_score("5th", hiscore[5], time_played[5], score_x, score_y+39, score_color, "unknown")

  print_totals()
end

function print_score(place, score, time, x, y, color, name)
  print(place, x, y, color)
  --print("8     8    8", x+16, y, 8) -- space check
  print(score, x+20, y, color)
  print(time, x+44, y, color)
  print(name, x+64, y, color) -- space check
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

function print_totals()
  local total_fruit = flr(total_score / 10)
  local total_str =
    "fruits: "..total_fruit.."   time: "..format_time(total_time)
  print_centered(total_str, 64, 124, 141)
end

function format_time(sec)
  sec = sec or 0
  local minute = flr(sec/60)
  local s = sec % 60
  return minute..":"..(s < 10 and "0"..s or s)
end

-- LAST_LINE_OF_UI_LUA