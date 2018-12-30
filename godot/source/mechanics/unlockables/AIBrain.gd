extends Unlockable

func unlock():
	var brain = Scenes.Brain.instance()
	GameData.ai.add_child(brain)