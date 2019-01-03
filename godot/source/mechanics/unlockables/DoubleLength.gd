extends Unlockable

func unlock():
	GameData.powerup_spawner.add_to_pool(Scenes.DoubleLength)