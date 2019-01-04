class_name Scoring
extends Node2D

signal score_capped
signal score_increased
signal score_decreased
signal score_reset
signal score_cap_changed(new_score_cap)

export(int) var score_cap = 1 setget set_score_cap

var board
var goal = 0

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
	
	board = GameData.world.get_node('Scoreboard')
	connect('score_increased', board, 'increase')
	connect('score_decreased', board, 'decrease')
	connect('score_reset', board, 'reset')

func _increase_score():
	goal += 1
	emit_signal('score_increased')
	
	if goal >= score_cap:
		emit_signal('score_capped')
		_reset()

func _decrease_score():
	self.goal -= 1
	emit_signal('score_decreased')
	
	if goal <= -score_cap:
		_reset()

func _reset():
	goal = 0
	emit_signal('score_reset')