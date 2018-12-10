extends Node2D

export(float) var ball_x_threshold = 50

onready var paddle:Paddle = get_parent()

func _process(delta):
	think()

func think():
	var ball = GameData.ball
	var to_ball = ball.position - paddle.position
	
	if ball.velocity.y > 0 or to_ball.y < 0:
		return
	
	if to_ball.x < -ball_x_threshold:
		paddle.move_left()
	elif to_ball.x > ball_x_threshold:
		paddle.move_right()