extends 'res://source/mechanics/upgrades/Upgrade.gd'

func unlock():
	var left_wall = Scenes.Wall.instance()
	left_wall.name = 'LeftWall'
	left_wall.position = $LeftWallPosition.position
	GameData.world.add_child(left_wall)
	GameData.left_wall = left_wall
	Scenes.PopAnimation.instance().pop(left_wall)
	
#	yield(get_tree().create_timer(0.25), 'timeout')
	
	var right_wall = Scenes.Wall.instance()
	right_wall.name = 'RightWall'
	right_wall.position = $RightWallPosition.position
	GameData.world.add_child(right_wall)
	GameData.right_wall = right_wall
	Scenes.PopAnimation.instance().pop(right_wall).delay(0.25)