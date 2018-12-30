extends Unlockable

func unlock():
	var powerup_spawner = Scenes.PowerupSpawner.instance()
	GameData.world.add_child(powerup_spawner)