extends Node2D

export(float) var ball_x_threshold = 50

onready var paddle:Paddle = get_parent()

func _process(delta):
	think()

func think():
	var balls = get_tree().get_nodes_in_group('Balls')
	var ball = GameData.ball
	var shortest_time = INF
	for b in balls:
		var to_ball = b.position - paddle.position
		if b.velocity.y > 0 or to_ball.y < 0:
			continue
		if b.velocity.y == 0:
			continue
		var time_to_paddle = -to_ball.y / b.velocity.y
		if time_to_paddle > 0 and time_to_paddle < shortest_time:
			shortest_time = time_to_paddle
			ball = b
	
	var to_ball = ball.position - paddle.position
	
	if ball.velocity.y > 0 or to_ball.y < 0:
		return
	
	if to_ball.x < -ball_x_threshold:
		paddle.move_left()
	elif to_ball.x > ball_x_threshold:
		paddle.move_right()
	
	$Label.rect_global_position = ball.position + Vector2(20, -10)