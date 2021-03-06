tool
class_name Unlocker
extends Node2D

signal new_level(level)

export(int) var save_level = 0
export(bool) var update_unlock_levels setget set_update_unlock_levels

var max_level = 0
var level = 0
var unlocks = 0

func set_update_unlock_levels(value):
	if Engine.editor_hint:
		_update_unlock_levels()

func _update_unlock_levels():
	var last_child
	var num = 0
	for child in get_children():
		num += 1
		if last_child and abs(child.unlock_level - last_child.unlock_level) >= 2:
			child.unlock_level = last_child.unlock_level + 1
		elif child.unlock_level == -1:
			child.unlock_level = num
		
		last_child = child

func _ready():
	max_level = get_children().back().unlock_level
	GameData.unlocker = self
	GameData.scoring.connect('score_capped', self, 'unlock_next_upgrade')

func unlock_next_upgrade():
	_unlock()
	while level < save_level:
		_unlock()

func _unlock():
	level += 1
	
	while get_child_count() > unlocks:
		var child = get_child(unlocks)
		if child.unlock_level == level:
			child.call_deferred('unlock')
			unlocks += 1
		else: break
	
	emit_signal('new_level', level)