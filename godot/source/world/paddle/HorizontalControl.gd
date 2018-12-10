extends Node2D

export(float) var max_speed = 1500
export(float) var acceleration = 1500
export(float) var opposite_multiplier = 3
export(float) var damping = 0.1

onready var paddle = get_parent()

var _left = false
var _right = false

func move_left():
	_left = true

func move_right():
	_right = true

func _physics_process(delta):
	var frame_accel = 0
	if not (_left and _right):
		if _left:
			frame_accel = -acceleration * delta
		elif _right:
			frame_accel = acceleration * delta
		else:
			paddle.velocity.x *= 1 - damping
		
		if sign(paddle.velocity.x) == -sign(frame_accel):
			frame_accel *= opposite_multiplier
		
		paddle.velocity.x += frame_accel
	
	paddle.velocity.x = clamp(paddle.velocity.x, -max_speed * paddle.speed_multiplier, max_speed)
	
	_left = false
	_right = false