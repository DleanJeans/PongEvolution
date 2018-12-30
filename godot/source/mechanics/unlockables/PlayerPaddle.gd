extends Unlockable

func unlock():
	Scenes.PopAnimation.instance().pop(GameData.player)
	GameData.player.collision_enabled = true