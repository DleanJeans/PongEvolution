extends Unlockable

func unlock():
	var powerup_spawner = Scenes.PowerupSpawner.instance()
	GameData.world.add_child(powerup_spawner)
	GameData.powerup_spawner = powerup_spawner
	powerup_spawner.add_to_pool(Scenes.MultiBall)