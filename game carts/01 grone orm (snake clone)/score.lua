--[[ SCORE.LUA 
	@date 2025-10-26

	Memory array:
	0,1,2,3,4 = top five scores
	5,6,7,8,9 = top five times
	10 = total score
	11 = total time
	12..51 = names for top five scores (5 * 8 chars)
	52 = Flag determine if first run or not

	NAME	SCORE	TIME
	Kardo	510		114
	Linus	470		163
]]--

score = 0
total_score = 0
hiscore = {0, 0, 0, 0, 0}
score_saved = false

time_played = {0, 0, 0, 0, 0}
total_time = 0 -- seconds

name_length = 8
NAME_BASE_INDEX = 12 -- first memory slot used for names
FIRST_RUN_FLAG_INDEX = 52
player = {"unknown", "unknown", "unknown", "unknown", "unknown"}



function init_score()
  cartdata("kardo_snake")
	load_score()
	load_totals()
	load_names()
	seed_default_scores_if_empty()
end

-- SCORE ----------------------------------------
function load_score()
	for i = 1, 5 do
		hiscore[i]     = dget(i - 1) or 0
		time_played[i] = dget(4 + i) or 0
	end
end

function save_score()
	for i = 1, 5 do
		dset(i - 1, hiscore    [i])
		dset(4 + i, time_played[i])
	end
end

-- TOTAL ----------------------------------------
function load_totals()
	total_score = dget(10) or 0
	total_time  = dget(11) or 0
end

function save_totals()
	dset(10, total_score)
	dset(11, total_time)
end

-- NAMES ----------------------------------------
function load_names()
	for i = 1, 5 do
		local base = NAME_BASE_INDEX + (i - 1) * name_length
		local n = load_name_from_mem(base)
		if n == "" then
			n = "unknown"
		end
		player[i] = n
	end
end

function save_names()
	for i = 1, 5 do
		local base = NAME_BASE_INDEX + (i - 1) * name_length
		save_name_to_mem(player[i] or "unknown", base)
	end
end

function load_name_from_mem(base_index)
	local s = ""
	for offset = 0, name_length - 1 do
		local code = dget(base_index + offset) or 0
		if code <= 0 then
			break
		end
		s = s .. chr(code)
	end
	return s
end

function save_name_to_mem(str, base_index)
	str = str or ""

	-- clear previous contents
	for offset = 0, name_length - 1 do
		dset(base_index + offset, 0)
	end

	local len = #str
	if len > name_length then
		len = name_length
	end

	for i = 1, len do
		local ch = sub(str, i, i)
		dset(base_index + i - 1, ord(ch))
	end
end

-- OPERATIONAL ----------------------------------
function record_run(score, sec)
	total_score += score
	total_time += sec
	save_totals()
end

function submit_score(new_score)
	local new_time = flr(cycle_cnt/60)

	for i = 1, 5 do
		local score_i = hiscore[i]
		local time_i = time_played[i]
		
		-- Is better if high score, or same but shorter time
		local better = (new_score > score_i) or
						(new_score == score_i and new_time < time_i)

		-- Shifting arrays to make room for new high score
		if better then
			for j = 5, i + 1, -1 do
				hiscore[j] = hiscore[j-1]
				time_played[j] = time_played[j-1]
			end
		
			hiscore[i] = new_score
			time_played[i] = new_time
			save_score()
			return
		end
	end
end

FORCE_SCORE_RESET = false
FORCE_SCORE_BLANK_WIPE = false

-- HELPERS --------------------------------------
function seed_default_scores_if_empty()
	-- full blank wipe (keeping totals)
	if FORCE_SCORE_BLANK_WIPE then
		blank_reset_of_score()
		return
	end

	if hiscore[1] ~= 0 or time_played[1] ~= 0 then
    if not FORCE_SCORE_RESET then
      return
    end
  end

	-- brand new cart: put in your friends + fillers
  set_score_entry(1, "kardo", 510, 114)
  set_score_entry(2, "linus", 470, 163)
  set_score_entry(3, "alundra", 420, 91)
  set_score_entry(4, "ratchet", 370, 79)
  set_score_entry(5, "daxter", 370, 88)

  save_score()
	save_names()
end

function set_score_entry(slot, name, score_value, time_value)
  player[slot]      = name or "unknown"
  hiscore[slot]     = score_value or 0
  time_played[slot] = time_value or 0
end

function blank_reset_of_score()
	for i = 1, 5 do
		set_score_entry(i, "unknown", 0, 0)
	end
	
	save_score()
	save_names()
end

-- LAST_LINE_OF_SCORE_LUA