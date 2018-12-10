tool
extends Node2D

export(int) var save_goal_count = 0
export(bool) var update_unlock_at setget set_update_unlock_at

var goal_count = 0
var unlocks = 0

func set_update_unlock_at(value):
	if not Engine.editor_hint: return
	
	var last_child
	var num = 0
	for child in get_children():
		num += 1
		if last_child and abs(child.unlock_at - last_child.unlock_at) >= 2:
			child.unlock_at = last_child.unlock_at + 1
		elif child.unlock_at == -1:
			child.unlock_at = num
		
		last_child = child 

func unlock_next_upgrade():
	_unlock()
	while goal_count < save_goal_count:
		_unlock()

func _unlock():
	goal_count += 1
	
	while get_child_count() > unlocks:
		var child = get_child(unlocks)
		if child.unlock_at == goal_count:
			child.unlock()
			unlocks += 1
		else: break