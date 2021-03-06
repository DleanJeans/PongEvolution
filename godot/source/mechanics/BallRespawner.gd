extends Position2D

signal ball_respawned

func _ready():
	GameData.top_goal.connect('detected_this_ball', self, 'respawn_ball')
	GameData.bottom_goal.connect('detected_this_ball', self, 'respawn_ball')

func respawn_ball(ball):
	if ball.name != Const.THE_BALL:
		ball.queue_free()
		return
	
	if $Area.get_overlapping_bodies().size() > 0:
		yield(get_tree(), 'idle_frame')
		respawn_ball(ball)
		return
	
	ball.add_child(Scenes.PopAnimation.instance().delay(0.5))
	var initial_velocity = ball.velocity
	ball.velocity = Vector2()
	ball.position = position
	ball.phasing.enable_for(1)
	
	emit_signal('ball_respawned')
	yield(get_tree().create_timer(1), 'timeout')
	
	var paddle
	if initial_velocity.y < 0:
		paddle = GameData.player
	else:
		paddle = GameData.ai
	
	var to_paddle = paddle.position - ball.position
	ball.velocity = to_paddle.normalized() * ball.normal_speed