extends 'res://source/mechanics/upgrades/Upgrade.gd'

func unlock():
	var paddle = Scenes.Paddle.instance()
	paddle.name = 'PlayerPaddle'
	paddle.position = $PlayerPosition.position
	GameData.world.add_child(paddle)
	GameData.player = paddle