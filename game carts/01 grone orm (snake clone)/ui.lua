--[[ UI.LUA 
	@date 2025-10-12
	
	FUNCTIONS

]]--

function print_ui()
  print_centered("score: "..score, 32, 24, 9)
  print_centered("length: "..body.segments+1, 96, 24, 11)
  print_centered("game over", 64, 48, 8)
  print_centered("< press 🅾️ or \'z\' to retry >", 64, 56, 6)
  --print_centered("adjust starting speed",64,88,5)

  print_centered("hiscore", 64, 80, 137)
  print_centered("1st "..hiscore[1], 64, 88, 137)
  print_centered("2nd "..hiscore[2], 64, 96, 137)
  print_centered("3rd "..hiscore[3], 64, 104, 137)
end

-- LAST_LINE_OF_UI_LUA