extends 'res://source/mechanics/upgrades/Upgrade.gd'

func unlock():
	Scenes.PopAnimation.instance().pop(GameData.left_wall)
	
	Scenes.PopAnimation.instance().pop(GameData.right_wall).delay(0.25)