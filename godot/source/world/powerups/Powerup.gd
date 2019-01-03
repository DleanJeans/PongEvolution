class_name Powerup
extends Node2D

export(int) var min_lifetime = 10
export(int) var max_lifetime = 15

func activate(ball:Ball):
	pass

func _ready():
	$LifeTimer.start(rand_range(min_lifetime, max_lifetime))

func _pop_out():
	$PopAnimation.play_backwards('Pop')
	yield($PopAnimation, 'animation_changed')
	queue_free()