extends Node2D

func _ready():
	yield(get_tree(), 'idle_frame')
	GameData.unlocker.connect('new_level', self, '_extend_every_5_levels')

func _extend_every_5_levels(new_level):
	if new_level % 5 == 1:
		GameData.scoring.increase_score_cap()