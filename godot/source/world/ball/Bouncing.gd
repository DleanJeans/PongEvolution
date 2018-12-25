extends Node2D

onready var ball = get_parent()
func _on_Area_body_entered(body):
	if body is Paddle:
		ball._hit_paddle(body)
		body._hit_ball(ball)
		_bounce_off_paddle(body)
	elif body is StaticBody2D:
		ball.reflect_x()
		ball._hit_wall()
	_retain_velocity_y()

func _bounce_off_paddle(paddle:Paddle):
	ball.reflect_y()
	var ball_to_paddle_center = ball.position.x - paddle.position.x
	var reflected_value = ball_to_paddle_center / paddle.half_width
	reflected_value = clamp(reflected_value, -1, 1)
	ball.velocity.x = ball.normal_speed * reflected_value

func _retain_velocity_y():
	ball.velocity.y = max(abs(ball.velocity.y), ball.normal_speed) * sign(ball.velocity.y)

func _physics_process(delta):
	if ball.get_slide_count() == 0: return
	
	var collision = ball.get_slide_collision(0)
	if collision.collider is Ball:
		ball._hit_ball(ball)
		_bounce_off_collision(collision)

func _bounce_off_collision(collision:KinematicCollision2D):
	var normal = collision.normal
	ball.velocity = ball.velocity.bounce(normal)
	ball.add_child(Phasing.new())