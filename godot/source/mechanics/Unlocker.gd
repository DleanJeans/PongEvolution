tool
class_name Unlocker
extends Node2D

signal new_level(level)

export(int) var save_level = 0
export(bool) var update_unlock_level setget set_update_unlock_level

var max_level = 0
var level = 0
var unlocks = 0

func set_update_unlock_level(value):
	if not Engine.editor_hint: return
	
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

func unlock_next_upgrade():
	_unlock()
	while level < save_level:
		_unlock()

func _unlock():
	if level < max_level:
		level += 1
	
	while get_child_count() > unlocks:
		var child = get_child(unlocks)
		if child.unlock_level == level:
			child.call_deferred('unlock')
			unlocks += 1
		else: break
	
	emit_signal('new_level', level)