--SoundFile
--all information for soundeffects in the game play screen. If you need to change anything to do with how an 
--SFX behaves, update this file.

 -- gameSFXInfo = {
	-- Singleshot = {path = "com/resources/music/soundfx/laser.ogg", channel = 2, weight = 1},
	-- Doubleshot = {path = "com/resources/music/soundfx/doubleshot.ogg", channel = 2, weight = 1},
	-- SineWave = {path = "com/resources/music/soundfx/sineWave.ogg", channel = 2, weight = 1},
	-- Spreadshot = {path = "com/resources/music/soundfx/sineWave.ogg", channel = 2, weight = 1},
	-- Homingshot = {path = "com/resources/music/soundfx/laser.ogg", channel = 2, weight = 1},
	-- Randomshot = {path = "com/resources/music/soundfx/shotgun.ogg", channel = 2, weight = 1},
	-- SpiralStraightshot = {path = "com/resources/music/soundfx/laser.ogg", channel = 2, weight = 1},
	-- SpiralCurveshot = {path = "com/resources/music/soundfx/shotgun.ogg", channel = 2, weight = 1},
	-- Circleshot = {path = "com/resources/music/soundfx/shotgun.ogg", channel = 2, weight = 1},
	-- Backshot = {path = "com/resources/music/soundfx/shotgun.ogg", channel = 2, weight = 1},
	-- Hater_die = {path = "com/resources/music/soundfx/enemyDeath.ogg", channel = 3, weight = 1},
	-- Hater_onHit = {path = "com/resources/music/soundfx/enemyHit.ogg", channel = 5, weight = 1},
	-- HealthPickUp = {path = "com/resources/music/soundfx/healthTemp.ogg", channel = 4, weight = 1},
	-- EnergyPickUp = {path = "com/resources/music/soundfx/energyTemp.ogg", channel = 4, weight = 1},
	-- ScrapPickUp = {path = "com/resources/music/soundfx/ring.ogg", channel = 4, weight = 1},
-- }

--setting = R: this sound will overlap any current sound on that channel
--setting = NR: this sound will only play if the channel is not playing a sound currently, if the sound is 
--              already playing, a new instance won't pop up
--setting = Solo: this sound will turn off all non-BGM channels and play only this sound
--setting = NRML: this sound does not have a specified behavior and will seek out a free channel to play on
 gameSFXInfo = {
	Singleshot = {path = "com/resources/music/soundfx/BenSounds/Laser1.wav", channel = 2, setting = 'R'},
	Doubleshot = {path = "com/resources/music/soundfx/BenSounds/DoubleLaser1.wav", channel = 2, setting = 'R'},
	SineWave = {path = "com/resources/music/soundfx/sineWave.ogg", channel = 2, setting = 'R'},
	Spreadshot = {path = "com/resources/music/soundfx/BenSounds/Spreadshot.ogg", channel = 2, setting = 'R'},
	Homingshot = {path = "com/resources/music/soundfx/BenSounds/laser.ogg", channel = 2, setting = 'R'},
	Randomshot = {path = "com/resources/music/soundfx/BenSounds/shotgun2weak.ogg", channel = 2, setting = 'R'},
	SpiralStraightshot = {path = "com/resources/music/soundfx/BenSounds/Laser1.wav", channel = 2, setting = 'R'},
	SpiralCurveshot = {path = "com/resources/music/soundfx/BenSounds/Laser1.wav", channel = 2, setting = 'R'},
	Circleshot = {path = "com/resources/music/soundfx/BenSounds/Laser3.wav", channel = 2, setting = 'R'},
	Backshot = {path = "com/resources/music/soundfx/BenSounds/shotgun2weak.wav", channel = 2, setting = 'R'},
	Bomb = {path = "com/resources/music/soundfx/BenSounds/Bomb.wav", channel = nil, setting = 'NRML'},
	Hater_die = {path = "com/resources/music/soundfx/BenSounds/HaterDeath.wav", channel = 3, setting = 'R'},
	Hater_onHit = {path = "com/resources/music/soundfx/BenSounds/HaterHit.wav", channel = 4, setting = 'NR'},
	HealthPickUp = {path = "com/resources/music/soundfx/BenSounds/healthTemp.wav", channel = 5, setting = 'R'},
	EnergyPickUp = {path = "com/resources/music/soundfx/BenSounds/energyPickup.wav", channel = 5, setting = 'R'},
	ScrapPickUp = {path = "com/resources/music/soundfx/BenSounds/CoinPickupBitCrushed.wav", channel = 5, setting = 'R'},
	Player_onHit = {path = "com/resources/music/soundfx/BenSounds/PlayerHit.wav", channel = 6, setting = 'R'}
}