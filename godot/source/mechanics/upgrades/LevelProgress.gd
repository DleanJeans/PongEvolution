extends "res://source/mechanics/upgrades/Upgrade.gd"

onready var unlocker = get_parent()

func unlock():
	var level_progress = Scenes.LevelProgress.instance()
	GameData.ui.add_child(level_progress)
	
	level_progress.set_max_level(unlocker.max_level)
	level_progress.update_level(unlocker.level)
	unlocker.connect('new_level', level_progress, 'update_level')