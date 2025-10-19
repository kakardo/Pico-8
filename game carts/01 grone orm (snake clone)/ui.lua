--[[ UI.LUA 
	@date 2025-10-12
	
	FUNCTIONS

]]--

function print_ui()
  print_centered("score: "..score, 32, 32, 9)
  print_centered("length: "..body.segments + 1, 96, 32, 11)
  print_centered("game over", 64, 64, 8)
  -- print_centered("press \"ctr + r\" to restart",64,72,13)
  print_centered("< press 🅾️ or \'z\' to retry >", 64, 72, 6)
  --print_centered("adjust starting speed",64,88,5)

  print_centered("hiscore", 64, 88, 137)

end

-- LAST_LINE_OF_UI_LUA