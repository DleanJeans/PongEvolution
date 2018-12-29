extends Node2D

var split_angle = 20

func _on_Area_body_entered(ball):
	yield(get_tree(), 'idle_frame')
	var new_ball = Scenes.Ball.instance()
	new_ball.position = ball.position
	GameData.world.add_child(new_ball, true)
	
	var velocity1 = ball.velocity.rotated(deg2rad(split_angle * 0.5))
	var velocity2 = ball.velocity.rotated(-deg2rad(split_angle * 0.5))
	
	ball.velocity = velocity1
	new_ball.velocity = velocity2
	new_ball.modulate = ball.modulate
	
	ball.add_child(Phasing.new())
	
	if has_node('Explosion'):
		var explosion = $Explosion
		remove_child(explosion)
		get_parent().add_child(explosion)
		explosion.play()
	
	queue_free()