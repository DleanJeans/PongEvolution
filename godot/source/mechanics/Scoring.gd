class_name Scoring
extends Node2D

signal goal_maxed
signal goal_increased
signal goal_decreased
signal goal_reset
signal max_goals_changed(new_max_goals)

export(int) var max_goals = 1 setget set_max_goals

var board
var goal = 0

func set_max_goals(value):
	if max_goals != value:
		max_goals = value
		emit_signal('max_goals_changed', max_goals)

func _ready():
	GameData.scoring = self
	
	GameData.game.connect('player_scored', self, 'increase_goal')
	GameData.game.connect('ai_scored', self, 'decrease_goal')
	
	board = Scenes.Scoreboard.instance()
	connect('goal_increased', board, 'increase')
	connect('goal_decreased', board, 'decrease')
	connect('goal_reset', board, 'reset')
	GameData.world.add_child(board)
	GameData.world.move_child(board, 1)

func increase_goal():
	goal += 1
	emit_signal('goal_increased')
	
	if goal >= max_goals:
		emit_signal('goal_maxed')
		_reset()

func decrease_goal():
	self.goal -= 1
	emit_signal('goal_decreased')
	
	if goal <= -max_goals:
		_reset()

func _reset():
	goal = 0
	emit_signal('goal_reset')