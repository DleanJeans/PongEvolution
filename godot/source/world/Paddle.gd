class_name Paddle
extends KinematicBody2D

signal hit_ball
signal hit_this_ball(ball)

export(float) var speed_multiplier = 1

var half_width:float setget, get_width
func get_width(): return $Shape.shape.extents.x

var velocity:Vector2 setget set_velocity, get_velocity
func set_velocity(value): $Movement.velocity = value
func get_velocity(): return $Movement.velocity

func _hit_ball(ball):
	emit_signal('hit_ball')
	emit_signal('hit_this_ball', ball)

func move_left(): $HorizontalControl.move_left()
func move_right(): $HorizontalControl.move_right()
