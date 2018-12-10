extends Position2D

signal ball_respawned

func respawn_ball(ball):
	ball.add_child(Scenes.PopAnimation.instance().delay(0.1))
	var initial_velocity = ball.velocity
	ball.velocity = Vector2()
	ball.position = position
	
	emit_signal('ball_respawned')
	yield(get_tree().create_timer(1), 'timeout')
	
	var paddle
	if initial_velocity.y < 0:
		paddle = GameData.player
	else:
		paddle = GameData.ai
	
	var to_paddle = paddle.position - ball.position
	ball.velocity = to_paddle.normalized() * ball.normal_speed
	