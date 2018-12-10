class_name PlayerControl
extends Node2D

export(bool) var enabled = true setget set_enabled

func set_enabled(enable):
	enabled = enable
	set_physics_process(enable)

func _physics_process(delta):
	_process_movement()

func _process_movement():
	var player = GameData.player
	
	if Input.is_action_pressed('left'):
		player.move_left()
	if Input.is_action_pressed('right'):
		player.move_right()