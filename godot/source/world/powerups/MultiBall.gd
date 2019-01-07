extends Powerup

export(float) var split_angle = 30

func activate(ball):
	yield(get_tree(), 'idle_frame')
	var new_ball = Scenes.Ball.instance()
	new_ball.position = ball.position
	GameData.world.add_child(new_ball, true)
	
	var velocity1 = ball.velocity.rotated(deg2rad(split_angle * 0.5))
	var velocity2 = ball.velocity.rotated(-deg2rad(split_angle * 0.5))
	
	ball.velocity = velocity1
	new_ball.velocity = velocity2
	new_ball.modulate = ball.modulate
	new_ball.speed_multiplier = ball.speed_multiplier
	
	ball.phasing.enable().disable_once_area_exited()
	new_ball.phasing.enable().disable_once_area_exited()

	if has_node('Explosion'):
		var explosion = $Explosion
		remove_child(explosion)
		get_parent().add_child(explosion)
		explosion.play()
	
	queue_free()