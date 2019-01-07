class_name Scoreboard
extends Node2D

export(float) var tween_duration = 0.25

onready var progress = $Progress

var player_color setget set_player_color
var ai_color setget set_ai_color

var _tween_queue = []

func _ready():
	GameData.scoring.connect('score_updated', self, 'tween_to')
	GameData.scoring.connect('score_cap_changed', self, 'update_score_cap')

func set_player_color(value):
	$Progress.tint_progress = value

func set_ai_color(value):
	$Progress.tint_under = value

func update_score_cap(value):
	$Progress.min_value = -value
	$Progress.max_value = value

var _direction = 0
var _value = 0

func tween_to(new_score):
	var direction = sign(new_score - _value)
	
	if $Tween.is_active():
		if direction == _direction:
			$Tween.stop_all()
			_tween_to(new_score)
		_tween_queue.append(new_score)
	else:
		_tween_to(new_score)
	
	_direction = direction
	_value = new_score

func _tween_to(new_score):
	var trans = Tween.TRANS_QUAD
	if _tween_queue.empty():
		trans = Tween.TRANS_LINEAR
	
	$Tween.interpolate_property($Progress, 'value', null, new_score, tween_duration, trans, Tween.EASE_OUT)
	$Tween.start()

func _on_tween_completed(object, key):
	$Tween.stop_all()
	if not _tween_queue.empty():
		var value = _tween_queue.front()
		_tween_queue.remove(0)
		_tween_to(value)