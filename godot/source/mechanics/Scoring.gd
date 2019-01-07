class_name Scoring
extends Node2D

signal score_capped
signal score_increased
signal score_decreased
signal score_reset
signal score_cap_changed(new_score_cap)

signal score_updated(new_score)

export(int) var score_cap = 0 setget set_score_cap

var _score = 0

func increase_score_cap():
	score_cap += 1
	emit_signal('score_cap_changed', score_cap)

func set_score_cap(value):
	if score_cap != value:
		score_cap = value
		emit_signal('score_cap_changed', score_cap)

func _ready():
	GameData.scoring = self
	
	GameData.game.connect('player_scored', self, '_increase_score')
	GameData.game.connect('ai_scored', self, '_decrease_score')

func _increase_score():
	_score += 1
	emit_signal('score_increased')
	emit_signal('score_updated', _score)
	
	if _score >= score_cap:
		emit_signal('score_capped')
		_reset()

func _decrease_score():
	self._score -= 1
	emit_signal('score_decreased')
	emit_signal('score_updated', _score)
	
	if _score <= -score_cap:
		_reset()

func _reset():
	_score = 0
	emit_signal('score_reset')
	emit_signal('score_updated', _score)