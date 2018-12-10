class_name Scoreboard
extends Node2D

export(float) var tween_duration = 0.5
var player_color setget set_player_color
var ai_color setget set_ai_color

func set_player_color(value):
	$Progress.tint_progress = value

func set_ai_color(value):
	$Progress.tint_under = value

func increase():
	_tween_to($Progress.value + 1)

func decrease():
	_tween_to($Progress.value - 1)

func reset():
	yield($Tween, 'tween_completed')
	_tween_to(0)

func _tween_to(new_goal, delay = 0):
	$Tween.interpolate_property($Progress, 'value', $Progress.value, new_goal, tween_duration, Tween.TRANS_QUAD, Tween.EASE_OUT, delay)
	$Tween.start()