extends 'res://source/mechanics/upgrades/Upgrade.gd'

func unlock():
	var paddle = Scenes.Paddle.instance()
	paddle.name = 'AIPaddle'
	paddle.position = $AIPosition.position
	GameData.world.add_child(paddle)
	GameData.ai = paddle
	paddle.speed_multiplier = 0.8