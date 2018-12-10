extends 'res://source/mechanics/upgrades/Upgrade.gd'

func unlock():
	var brain = Scenes.Brain.instance()
	GameData.ai.add_child(brain)