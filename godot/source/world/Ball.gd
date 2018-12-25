class_name Ball
extends KinematicBody2D

signal hit_paddle
signal hit_this_paddle(paddle)
signal hit_wall
signal hit_ball
signal hit_this_ball

export(float) var normal_speed = 500
var speed_multiplier = 1

var velocity:Vector2 setget set_velocity, get_velocity
func set_velocity(value): $Movement.velocity = value
func get_velocity(): return $Movement.velocity

func _hit_paddle(paddle):
	emit_signal('hit_paddle')
	emit_signal('hit_this_paddle', paddle)

func _hit_wall():
	emit_signal('hit_wall')

func _hit_ball(ball):
	emit_signal('hit_ball')
	emit_signal('hit_this_ball', ball)

func reflect_x():
	self.velocity.x *= -1

func reflect_y():
	self.velocity.y *= -1

func queue_free():
	.queue_free()