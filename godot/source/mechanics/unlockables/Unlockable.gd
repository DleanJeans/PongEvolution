class_name Unlockable
extends Node2D

export(int) var unlock_level = -1
export(bool) var enabled = true

func _ready():
	if not enabled:
		queue_free()

func unlock():
	pass