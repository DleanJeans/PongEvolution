extends Node2D

export(float) var error_margin = 0.1

onready var ball = get_parent()

var _ball_bounced_off = true

func _physics_process(delta):
	if ball.get_slide_count() == 0: return
	
	for i in range(ball.get_slide_count()):
		var collision = ball.get_slide_collision(i)
		_handle_collision(collision)
	
	_retain_velocity_y()

func _handle_collision(collision):
	var collider = collision.collider
	var normal = collision.normal
	
	if collider is Ball and _ball_bounced_off:
		_ball_bounced_off = false
		_bounce_off_ball(collision)
		ball.emit_hit_ball(collider)
	elif collider is Wall:
		ball.set_velocity_x_sign(sign(collision.normal.x))
		ball.emit_hit_wall()

func _swap_speed(other:Ball):
	if other.has_meta('speed'):
		other.speed_multiplier = ball.speed_multiplier
		ball.speed_multiplier = other.get_meta('speed')
		other.set_meta('speed', null)
	else:
		ball.set_meta('speed', ball.speed_multiplier)

func _bounce_off_ball(collision:KinematicCollision2D):
	var normal = collision.normal
	ball.velocity = ball.velocity.bounce(normal)

func _retain_velocity_y():
	ball.velocity.y = ball.normal_speed * sign(ball.velocity.y)

func _on_Area_body_entered(body):
	if body is Paddle:
		ball.emit_hit_paddle(body)
		body.emit_hit_ball(ball)
		_bounce_off_paddle(body)

func _bounce_off_paddle(paddle:Paddle):
	var to_screen_center = _get_to_screen_center()
	ball.set_velocity_y_sign(sign(to_screen_center.y))
	
	var ball_to_paddle_center = ball.position.x - paddle.position.x
	var reflected_value = ball_to_paddle_center / paddle.half_width
	var error = rand_range(-error_margin, error_margin)
	reflected_value = clamp(reflected_value, -1, 1) + error
	
	ball.velocity.x = ball.normal_speed * reflected_value

func _get_to_screen_center():
	var screen_center = get_viewport_rect().size * 0.5
	var to_screen_center = screen_center - global_position
	return to_screen_center

func _on_Area_body_exited(body):
	if body is Ball and body != get_parent():
		_ball_bounced_off = true