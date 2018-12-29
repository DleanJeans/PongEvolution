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

func emit_hit_paddle(paddle):
	emit_signal('hit_paddle')
	emit_signal('hit_this_paddle', paddle)

func emit_hit_wall():
	emit_signal('hit_wall')

func emit_hit_ball(ball):
	emit_signal('hit_ball')
	emit_signal('hit_this_ball', ball)

func reflect_x():
	self.velocity.x *= -1

func reflect_y():
	self.velocity.y *= -1

func set_velocity_x_sign(new_sign):
	self.velocity.x = abs(self.velocity.x) * new_sign

func set_velocity_y_sign(new_sign):
	self.velocity.y = abs(self.velocity.y) * new_sign

func bounce_off_paddle(paddle):
	$Bouncing.bounce_off_paddle(paddle)

func queue_free():
	.queue_free()