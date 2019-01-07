extends Node2D

export(float) var min_multiplier = 0.8
export(float) var max_multiplier = 1
export(float) var step = 0.02

var ai:Paddle

func _ready():
	ai = GameData.ai
	
	yield(get_tree(), 'idle_frame')
	GameData.unlocker.connect('new_level', self, '_enable_on_level_5')

func _enable_on_level_5(new_level):
	if new_level == 5:
		GameData.game.connect('ai_scored', self, '_decrease')
		GameData.game.connect('player_scored', self, '_increase')
		
		GameData.unlocker.disconnect('new_level', self, '_enable_on_level_5')

func _increase():
	ai.speed_multiplier += step
	_clamp()

func _decrease():
	ai.speed_multiplier -= step
	_clamp()

func _clamp():
	ai.speed_multiplier = clamp(ai.speed_multiplier, min_multiplier, max_multiplier) * 1.2