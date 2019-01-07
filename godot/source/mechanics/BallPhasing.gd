class_name BallPhasing
extends Node2D

const NAME = 'BallPhasing'

onready var parent = get_parent()

var _disable_once_area_exited = false

var _initial_layer:int
var _initial_mask:int

func _ready():
	_record_initial_data()

func _record_initial_data():
	_initial_layer = parent.collision_layer
	_initial_mask = parent.collision_mask

func enable():
	parent.collision_layer = 0
	parent.collision_mask = 0
#	$Area.monitoring = true
#	parent.set_deferred('collision_layer', 0)
#	parent.set_deferred('collision_mask', 0)
	$Area.set_deferred('moniterable', true)
	return self

func enable_for(duration = 0.1):
	enable()
	$DisableTimer.start(duration)
	return self

func disable():
	parent.collision_layer = _initial_layer
	parent.collision_mask = _initial_mask
#	$Area.monitoring = false
#	parent.set_deferred('collision_layer', _initial_layer)
#	parent.set_deferred('collision_mask', _initial_mask)
	$Area.set_deferred('moniterable', false)
	return self

func disable_once_area_exited():
	_disable_once_area_exited = true
	return self

func _on_area_exited(area):
	if _disable_once_area_exited:
		disable()
		_disable_once_area_exited = false