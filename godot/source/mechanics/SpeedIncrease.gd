extends Node2D

export(float) var percent_per_paddle_hit = 2
export(float) var max_multiplier = 3

onready var ball_respawner = $'../BallRespawner'

func _ready():
	yield(get_tree(), 'idle_frame')
	GameData.ball.connect('hit_paddle', self, '_increase_speed')
	ball_respawner.connect('ball_respawned', self, '_reset_speed')

func _increase_speed():
	if GameData.ball.speed_multiplier >= max_multiplier:
		return
	GameData.ball.speed_multiplier += 0.01 * percent_per_paddle_hit

func _reset_speed():
	GameData.ball.speed_multiplier = 1