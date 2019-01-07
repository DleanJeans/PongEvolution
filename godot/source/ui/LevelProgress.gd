extends Control

var max_level = 0

func set_max_level(value):
	max_level = value

func update_level(new_level):
	$Label.text = 'Lvl %s' % new_level
	if new_level <= max_level:
		$Label.text += '|%s' % max_level