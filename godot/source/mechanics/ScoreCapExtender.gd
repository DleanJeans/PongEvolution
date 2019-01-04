extends Node2D

onready var unlocker = $'../Unlocker'

func _ready():
	unlocker.connect('new_level', self, '_extend_every_5_levels')

func _extend_every_5_levels(new_level):
	if new_level % 5 == 1:
		GameData.scoring.increase_score_cap()