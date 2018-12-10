class_name Game
extends Node2D

signal player_scored
signal ai_scored

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

func _on_GoalTop_detected_ball():
	emit_signal('player_scored')

func _on_GoalBottom_detected_ball():
	emit_signal('ai_scored')