extends Unlockable

func unlock():
	Scenes.PopAnimation.instance().pop(GameData.ai)
	GameData.ai.collision_enabled = true