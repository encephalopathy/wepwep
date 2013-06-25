
WAVE_LIMIT = 0
HATER_COLUMN_OFFSET = 325
current_wave_number = 1
current_set_number = 1

function chomp(line)
   return string.gsub(line, "[\r\n]+$", "")
end


function createLevel(filename)
	local waves = {}
	
	file = io.open(filename, "r")
	local wave = nil
	local lineAmount = 0
	local waveAmount = 0
	for line in file:lines(), 1 do
      line = chomp(line)
		if line == "@" then
			if wave ~= nil then
				wave.length = lineAmount
				lineAmount = 0
				waves[waveAmount] = wave
			end
				wave = {}
				waveAmount = waveAmount + 1
		else
			lineAmount = lineAmount + 1
			wave[lineAmount] = line
		end
	end
	waves[waveAmount] = wave
	wave.length = lineAmount
	waves.length = waveAmount
	local set = {}
	for waveNum = 1, waves.length, 1 do
		--print(waves[waveNum])
		for setNum = 1, waves[waveNum].length, 1 do
			local length = string.len(waves[waveNum][setNum])
			set = {}
			for columnNum = 1, length, 1 do
				local haterType = tonumber(string.sub(waves[waveNum][setNum], columnNum, columnNum))
				set[columnNum] = haterType
			end
			set.length = length
			waves[waveNum][setNum] = set
			
		end
	end
	
	return waves
end

function createNewHaterSet(grid)
	local set = nil
	local wave = grid[current_wave_number]
	
	if wave ~= nil then
		set = grid[current_wave_number][current_set_number]
	else
		wave = set
	end
	
	if set ~= nil then
		current_set_number = current_set_number + 1
	else
		createNewHaterWave()
	end
	return set
end

function createNewHaterWave()
	current_set_number = 1
	current_wave_number = current_wave_number + 1
end
function setLevel(levelNumber)
	current_wave_number = 1
	current_set_number = 1
	if levelNumber == 0 then
		return level0
	end
end

level0 = createLevel('level0.txt')

for i = 1, level0.length, 1 do
	local wave = level0[i]
	--print('wave ' .. i)
	for j = 1, wave.length, 1 do
		local set = level0[i][j]
		--print ('set ' .. j) 
		for k = 1, set.length, 1 do
			--print(level0[i][j][k])
		end
	end
end