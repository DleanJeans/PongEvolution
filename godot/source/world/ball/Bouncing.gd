extends Node2D

onready var ball = get_parent()

func _on_Area_body_entered(body):
	if body is Paddle:
		ball._hit_paddle(body)
		body._hit_ball(ball)
		
		ball.reflect_y()
		var paddle:Paddle = body
		var ball_to_paddle_center = ball.position.x - paddle.position.x
		var reflected_value = ball_to_paddle_center / paddle.half_width
		reflected_value = clamp(reflected_value, -1, 1)
		ball.velocity.x = ball.normal_speed * reflected_value
	elif body is StaticBody2D: # Wall
		ball.reflect_x()