class_name Phasing
extends Node

var duration = 0.2

onready var parent = get_parent()

var _initial_layer:int
var _initial_mask:int

func _ready():
	_initial_layer = parent.collision_layer
	_initial_mask = parent.collision_mask
	
	yield(get_tree(), 'physics_frame')
	
	parent.collision_layer = 0
	parent.collision_mask = 0
	
	var timer = Timer.new()
	add_child(timer)
	timer.start(duration)
	timer.connect('timeout', self, '_reset_mask')

func duration(duration = 0.1):
	self.duration = duration
	return self

func _reset_mask():
	parent.collision_layer = _initial_layer
	parent.collision_mask = _initial_mask
	queue_free()