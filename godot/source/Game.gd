class_name Game
extends Node2D

signal player_scored
signal ai_scored
signal ball_added(ball)

onready var ball = $World/Ball

func _init():
	yield(self, 'tree_entered')
	GameData.game = self
	GameData.world = $World
	GameData.feel = $Feel
	GameData.ui = $UI
	GameData.mechanics = $Mechanics

func _ready():
	GameData.ball = ball
	ball.velocity.y = -500
	
	get_tree().connect('node_added', self, '_emit_if_ball_added')
	emit_signal('ball_added', ball)

func _emit_if_ball_added(node):
	if node is Ball:
		emit_signal('ball_added', node)

func _on_GoalTop_detected_ball():
	emit_signal('player_scored')

func _on_GoalBottom_detected_ball():
	emit_signal('ai_scored')